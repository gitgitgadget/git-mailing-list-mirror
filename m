From: David Aguilar <davvid@gmail.com>
Subject: Re: Help creating git alias
Date: Thu, 31 Oct 2013 11:15:10 -0700
Message-ID: <20131031181509.GB39079@gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
 <CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
 <CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
 <xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
 <CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
 <xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
 <CAPZPVFYFSBRHThO08LmuN_0fc55gYX-A+Y3=yA_MESko1t6fXQ@mail.gmail.com>
 <20131031174008.GA39079@gmail.com>
 <xmqqd2ml8gbs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eugene Sajine <euguess@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:15:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbwm9-0006lT-5Z
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab3JaSPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:15:15 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39016 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab3JaSPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:15:14 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so2880674pab.22
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XUKSHJiFfHvoO5O+M1NYqIW7fsN+2KmMQnw1XeJ1ow4=;
        b=tS1SAIAHhEE5rIfxg6dmdkDo79SOGrCmLBis5eT+L/MI0I2KFIHF+VQOP5HvplyBVQ
         QNdZ/A6k0YL2xvvJ8MIDxWl/ExfR3qRwFfkTN2U6umfXPqDPSEdGDjSL/uDlwpyaj+/o
         y++Jp01lfj4BOoSfVopvbba5f92V1NUnCkYB5bYXZlBgQUFROAL5K8j5Mfkp2NAP56F9
         mjRNaVaoq5kp8UNBuCLSNqoR1Pf/r7IGRE4wTAiq73WetyLrFO3Ac7KxWaVp85z0Es18
         yFGziV5UQJ3H06cF8D2c6y2b+gIhKm4lyUELW3OzVfPC/NaoY90Qcn680YYmRmPlkfbH
         fx1A==
X-Received: by 10.68.29.36 with SMTP id g4mr3269949pbh.145.1383243313489;
        Thu, 31 Oct 2013 11:15:13 -0700 (PDT)
Received: from gmail.com (w.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPSA id qw8sm5627786pbb.27.2013.10.31.11.15.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 11:15:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqd2ml8gbs.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237143>

On Thu, Oct 31, 2013 at 11:07:19AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > A-ha.. I think adding the chdir to alias is possible using a function.
> 
> You do not have to use a function to do so, no?

Right, of course.

So something like:

[alias]
	example = "!cd ${GIT_PREFIX:-.} && git log \"$@\""

should do the trick.
-- 
David
