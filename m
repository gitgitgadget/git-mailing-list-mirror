From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: adding files in .git?
Date: Mon, 16 Mar 2009 08:18:23 -0700
Message-ID: <20090316151823.GP22920@spearce.org>
References: <3a69fa7c0903160814u42fbb461qf03a37176546357d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 16:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjEba-0007uH-Ih
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 16:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbZCPPS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 11:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZCPPS0
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 11:18:26 -0400
Received: from george.spearce.org ([209.20.77.23]:54142 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbZCPPSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 11:18:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D794738211; Mon, 16 Mar 2009 15:18:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <3a69fa7c0903160814u42fbb461qf03a37176546357d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113334>

E R <pc88mxer@gmail.com> wrote:
> I'd like to add a "short description" attribute to my .git repository.
> This would be used by my bash prompt setting function in creating the
> PS1 string. How would you recommend that this be implemented?
> 
> My ideas are:
> 
> 1) Use another file in .git similar to the "description" file (such as
> .git/short-description)
> 2) Use a setting in the .git/config file.
> 
> Any comments on the advantages/disadvantages of these approaches? Or
> is there yet another better way?

Using another file may be faster to execute as you can probably
read the file directly in shell, vs. needing to fork to read the
file with `git config`.

But there really isn't a huge argument either way other than that.

-- 
Shawn.
