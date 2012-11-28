From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v6 07/16] remote-hg: add support for hg-git compat mode
Date: Wed, 28 Nov 2012 15:23:20 -0500
Message-ID: <20121128202320.GA22522@odin.tremily.us>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
 <1351995218-19889-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:24:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdoAr-0006eM-3W
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 21:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab2K1UXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 15:23:46 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:57318 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab2K1UXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 15:23:45 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.13])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME700MLSSMXRN30@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Nov 2012 14:23:28 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 12E276E1BDA; Wed,
 28 Nov 2012 15:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354134201; bh=+RUyh8+FLwSVY1xvsggsKaji8hxTlevJgErhrOCiTVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QSHlmivxmpOXh01vu8SeapIhQXQ8wMSmYD+QnYji8uG4suP0NKuN85GE3Y3/OybI+
 f+dpFeab+2zd6PhoDVcejlECtcbjz+VRixbB2uEDd0CE4RaMFT1g08n5RRf5SlGAWc
 bFYL4/7OnkNpjGrqssrG5ZPE626vgRqIN+1bz4Oo=
Content-disposition: inline
In-reply-to: <1351995218-19889-8-git-send-email-felipe.contreras@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210774>

I'm not sure if this is the most recent patch iteration for this
feature, but I just saw this typo in `pu`.

On Sun, Nov 04, 2012 at 03:13:29AM +0100, Felipe Contreras wrote:
> +# Commits are modified to preserve hg information and allow biridectionality.
                                                               ^^^^^^^^
s/biridectionality/bidirectionality/

Cheers,
Trevor

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
