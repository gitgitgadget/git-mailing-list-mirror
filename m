From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: Re: Managing websites with git
Date: Sat, 3 Jan 2009 13:29:08 -0800
Message-ID: <20090103212908.GG6136@penguin.codegnome.org>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 22:56:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJEUG-0007SE-I6
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 22:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979AbZACVz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 16:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755799AbZACVz3
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 16:55:29 -0500
Received: from que11.charter.net ([209.225.8.21]:54701 "EHLO que11.charter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbZACVz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 16:55:29 -0500
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jan 2009 16:55:28 EST
Received: from aarprv06.charter.net ([10.20.200.76]) by mta21.charter.net
          (InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
          id <20090103212910.DPFB20903.mta21.charter.net@aarprv06.charter.net>
          for <git@vger.kernel.org>; Sat, 3 Jan 2009 16:29:10 -0500
Received: from penguin.codegnome.org ([71.83.124.90])
          by aarprv06.charter.net with ESMTP
          id <20090103212910.ZAWI128.aarprv06.charter.net@penguin.codegnome.org>
          for <git@vger.kernel.org>; Sat, 3 Jan 2009 16:29:10 -0500
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id 742D537CAB; Sat,  3 Jan 2009 13:29:09 -0800 (PST)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Sat, 03 Jan 2009 13:29:09 -0800
Content-Disposition: inline
In-Reply-To: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: git@vger.kernel.org
X-Chzlrs: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104479>

On Sun, Nov 30, 2008 at 05:30:30PM +0100, Felix Andersen wrote:

> I was thinking about any security issues with the .git dir being
> hosted. Or is that even the right way to do it?

With Apache, you can add the following to your httpd.conf file, or to an
.htaccess file within your document root:

    <DirectoryMatch "^\.git">
	Order allow,deny
	Deny from all
    </DirectoryMatch>
    <FilesMatch "^\.gitignore">
	Order allow,deny
	Deny from all
    </FilesMatch>

to prevent web access to the respository.

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
