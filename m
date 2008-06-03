From: Johan Herland <johan@herland.net>
Subject: Re: Eliminate curl binary
Date: Tue, 3 Jun 2008 13:14:52 +0200
Message-ID: <200806031314.52579.johan@herland.net>
References: <20080603105323.GA15825@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jun 03 13:16:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3UUn-0005Vg-UL
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 13:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYFCLPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 07:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYFCLPM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 07:15:12 -0400
Received: from sam.opera.com ([213.236.208.81]:58502 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbYFCLPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 07:15:11 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m53BEqPQ024877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Jun 2008 11:14:53 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20080603105323.GA15825@camelia.ucw.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83640>

On Tuesday 03 June 2008, Stepan Kasal wrote:
> Hello,
>
> git source code uses curl (the binary) on exactly one spot:
> git-clone.sh
> I would welcome if that spot were rewritten so that git would no
> longer require curl, only libcurl.

In the next version of Git (v1.5.6, currently in RC1), git-clone.sh has 
been replaced by a builtin C version (builtin-clone.c, part of the git 
binary). I assume the new version uses libcurl instead of the curl 
binary.


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
