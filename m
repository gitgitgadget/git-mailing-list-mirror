From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A few contributor's questions
Date: Fri, 31 Jan 2014 08:19:24 -0800
Message-ID: <20140131161924.GA4332@google.com>
References: <8738k44808.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 31 17:19:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9GoZ-0000h2-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 17:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbaAaQTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 11:19:31 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:39499 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbaAaQTb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 11:19:31 -0500
Received: by mail-pb0-f54.google.com with SMTP id uo5so4593505pbc.13
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 08:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DseGoL0LUFaLcgjkbrF5+nNodT/+bnT+dCmxiJqvRgg=;
        b=wWI3vuhfZFEkisQD1a+NSpYywjVV0ZxgXpfWkW7OqJs2pyZg6ARfxFZZ3SPHyLF+xA
         fBjhADAHrFXIJNprbSnNZ1A8x0o3H6zbZe6801s1jHw9qqD/4VZUnzeg2EWpUXs0anIF
         MFFD4BMRR91ZKesSk4leXVWt3aZmoOrvXNuu9eY3/0tItFE2/oEWP8gv/OxrRZptMZbZ
         dZESAosLjMRfiiXTkjSLBOcy9ZvRTYXRh5/lKQV1W2z/LbWyMSlqBth0I6Q8M3OUdove
         Aq4yrg+eTbXLtRImJ+bPV5/l/L99INa7HSTFp5dpIlGvBgXXS6UhnvhYV2oZ/OMcABYo
         iGqQ==
X-Received: by 10.66.189.129 with SMTP id gi1mr21578262pac.57.1391185170385;
        Fri, 31 Jan 2014 08:19:30 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bc4sm29021393pbb.2.2014.01.31.08.19.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 08:19:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8738k44808.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241302>

Hi,

David Kastrup wrote:

>       builtin/blame.c merely states
>
> /*
>  * Blame
>  *
>  * Copyright (c) 2006, Junio C Hamano
>  */

I think you planned to make substantial changes, so

> /*
>  * Blame
>  *
>  * Copyright (c) 2006--2014, Junio C Hamano and others
>  * Licensed under GPLv2.  See Git's COPYING file for details.
>  */

towards the end of the series (or squashed into some patch that makes
significant changes) looks fine to me.

Also keep in mind that you don't need a copyright notice to own
copyright, that it would be crazy for someone to claim you've assigned
copyright on your changes without an explicit reassignment, and that
libgit2's git.git-authors file that keeps coming up includes a comment
with a heuristic for delving into the history to find the authors of
some code.

[...]
> Permissable-Licenses: GPL Version 2 or later

Wouldn't a signed message on your website or some other public place
(e.g., the mailing list) do the trick?

Or a sentence in a commit message saying

 "I'd be happy to have these changes relicensed under the GPL version 2
 or later."

sounds fine to me, at least.

Thanks and hope that helps,
Jonathan
