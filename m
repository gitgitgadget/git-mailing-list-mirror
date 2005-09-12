From: Greg Louis <glouis@dynamicro.on.ca>
Subject: Re: [PATCH] Redirect cd output to /dev/null, was: git-clone seems dead
Date: Mon, 12 Sep 2005 06:56:37 -0400
Organization: Dynamicro Consulting Limited
Message-ID: <20050912105637.GA5290@athame.dynamicro.on.ca>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk> <7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net> <20050911220421.GA14593@athame.dynamicro.on.ca> <20050911230136.GA15224@athame.dynamicro.on.ca> <7vwtlnm4zx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Mon Sep 12 12:58:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EElzf-0000WC-4C
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 12:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVILK4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 06:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVILK4n
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 06:56:43 -0400
Received: from csl2r.consultronics.on.ca ([204.138.93.16]:13955 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S1750725AbVILK4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 06:56:43 -0400
Received: from [70.29.36.34] (helo=athame.dynamicro.internal ident=glouis)
	by csl2.consultronics.on.ca with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.52)
	id 1EElzK-0004tX-34
	for git@vger.kernel.org; Mon, 12 Sep 2005 06:56:38 -0400
Received: from root by athame.dynamicro.internal with local (Exim 4.52)
	id 1EElzJ-0001Op-Ms
	for git@vger.kernel.org; Mon, 12 Sep 2005 06:56:37 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwtlnm4zx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8376>

On 20050911 (Sun) at 1847:30 -0700, Junio C Hamano wrote:
> I really do not see a point of having CDPATH as an            
> environment variable, exported to be honored by any unsuspecting
> shell scripts.
> 
Well, that's why I didn't originally bother submitting the patch -- was 
just going to use it internally.
  
I could argue that it's a relatively harmless contribution to
robustness of the git scripts, but if someone replied that total
idiot-proofing isn't a worthwhile goal for a project of this sort, I   
wouldn't necessarily disagree.

-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |
