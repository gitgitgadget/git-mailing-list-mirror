From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Sun, 19 May 2013 06:48:49 -0500
Message-ID: <CAMP44s3HaEc1UoULYHYnzd_B_VayfedG_Gd1gT27=SeMdp4=eg@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	<7vk3mxze8v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
	<7vmwrr1pem.fsf@alter.siamese.dyndns.org>
	<CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:48:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue26h-00039M-Qb
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab3ESLsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:48:51 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:39121 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab3ESLsv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:48:51 -0400
Received: by mail-la0-f45.google.com with SMTP id ec20so5227842lab.4
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EG5Qkr2GofnfNOwH4UFiDaavoiZ3Gdox0Hjq3eHKJ0A=;
        b=VIbL1KT09pobOFHp4Ag+ISeRD9K8Zdbf9Wz9Gv6gDvWL+vQBzEH9lY/kkd0s8CbC70
         DWN/fDdWkTPPwr+3mizOhwODHtnHWAXI7Cxy2NGOx+sKQJB2h9SN+qQ56Ttxta6qCvN7
         IymYK2C8ux/PdXrV7lfkGpOn1K710F6OPE1hybzldSKSLLDmnsRBti0/12c88cmSm+ug
         fN5f2IViadzenPkAlAwLBLX8IfYp5owEU3Rpm/pxoOeeErJMKlue+XWA1Jg1iydqrNPA
         DuryGIbfsGspKsv0+W1M0acM0MecGrot/U+rndh5maqebdWWXRIRXSLw/rbeF8YnTeHi
         hKRg==
X-Received: by 10.112.125.130 with SMTP id mq2mr25535643lbb.103.1368964129126;
 Sun, 19 May 2013 04:48:49 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 04:48:49 -0700 (PDT)
In-Reply-To: <CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224862>

On Sun, May 19, 2013 at 6:44 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>> If somebody implements the "push.default = single" (see the original
>> message you are responding to), then the change might be smaller.
>
> I think this is a bad hack covering up an underlying problem: it is
> ugly, confusing, and inextensible in my opinion.  I think of
> push.default as merely a default remote.<name>.push value for all
> remotes, that can be overridden on a per-remote basis.

You can't represent push.default = single either.

-- 
Felipe Contreras
