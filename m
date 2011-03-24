From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2011, #04; Wed, 23)
Date: Wed, 23 Mar 2011 20:39:09 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1103232015390.30954@debian>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 01:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2YaA-0003g2-19
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 01:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933474Ab1CXAjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 20:39:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54387 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933406Ab1CXAjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 20:39:15 -0400
Received: by vws1 with SMTP id 1so6112813vws.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 17:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=85wEJeldbIo9SyKYaaKgIp44bCW/9T8SCoD1chG9Ths=;
        b=eF1L8kjcStArt9w8Nm1NuNV9DqepDsq4duuTW8QBZdAeHKHJ+3EyYeMps412pvBUcj
         OO/u6o5XGOnTWF/1gtntp8Zmc1R8Va8Vuw4Ystvi2QC/bN78USwmcFxNFaGVj4+yzh2A
         j5BorRnWw+nW+467KtrKjDjO98Zrz5P4K5dSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=phKl97hno7DujGAKX+QZ9loDcvL5ugt1jTMZyBLyNioaoxGCUTbkEEM9DuA9Neino3
         AAFyeVaIwyQKh3opvPyLzwutW+hjN5pjqDPCtaTZ3V50L2yBV19ppGHkdIO+CU48FSk4
         STc3QYGaQSEqVXWhB7L/sJAZo0T86PADW2FpU=
Received: by 10.52.0.106 with SMTP id 10mr934245vdd.257.1300927154283;
        Wed, 23 Mar 2011 17:39:14 -0700 (PDT)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e10sm1892694vch.19.2011.03.23.17.39.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2011 17:39:13 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169884>

On Wed, 23 Mar 2011, Junio C Hamano wrote:

> --------------------------------------------------
> [Stalled]
> 
> ...
> 
> * mz/rebase (2011-02-28) 34 commits
>  - rebase: define options in OPTIONS_SPEC
>   (merged to 'next' on 2011-02-25 at 52caa7a)
>  + Makefile: do not install sourced rebase scripts
>   (merged to 'next' on 2011-02-22 at 3219155)
>  + rebase: use @{upstream} if no upstream specified
> ...
> 
> I think the tip one is a response to J6t's regression concerns; it looked
> Ok to me.

Do I need to do anything to un-stall (the tip of) this topic?

I didn't remove USAGE and LONG_USAGE in that patch because I wasn't
sure if they are used somehow. As far as I can see, they are only used
if no OPTIONS_SPEC is defined. If someone can confirm that, I can
submit an updated version.

And yes, it is a response to J6t's regression concerns.


/Martin
