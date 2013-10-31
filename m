From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Help creating git alias
Date: Thu, 31 Oct 2013 16:06:43 -0400
Message-ID: <CAPZPVFaFQrEdr7EN3a=ds2T_C87sct6ksH2SbjEg=43-ZNt6Jg@mail.gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
	<CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
	<xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
	<CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
	<xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
	<CAPZPVFYFSBRHThO08LmuN_0fc55gYX-A+Y3=yA_MESko1t6fXQ@mail.gmail.com>
	<20131031174008.GA39079@gmail.com>
	<xmqqd2ml8gbs.fsf@gitster.dls.corp.google.com>
	<20131031181509.GB39079@gmail.com>
	<CAPZPVFYWf3_xtxKkdw4_gzqKagVsbNvj73cb=RvX1Zm0C1h8pQ@mail.gmail.com>
	<xmqq7gct5iu1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:06:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbyW3-0004JW-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab3JaUGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:06:46 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:39192 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab3JaUGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:06:44 -0400
Received: by mail-we0-f178.google.com with SMTP id q59so3170771wes.37
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=InUH/K6GucfXp71ScaH0zWmaQ9zqM62dDsfU/cCfT+I=;
        b=XlQzhpXARWIwyMTRCBH8b7876gxFj8FiPJBbCPkSKGOiK51bbM52EMd9tWfzgEZq/I
         TT78hrtsEqB3BDZ4hsSHYjdGPdwBrYKFAaKFp0tGh5865tbZwfQy39YCZJ/AJtW15KYN
         QhYF1Z0KP+8wcou1LBjhhCqQpvzyWiDpzejqYcckZy97qIHPeT/vAQ1C2+IuQTIk6Gk9
         UpkVXOb7MK8Gq4sLmUd//Zx6kGkrv3T9NsleyzEC7U/sZQW4fX93tuypsGj2hrPlqotK
         U8zy+Sqvg5B5q/4Xe/PoMLFnYi/KnyBZMtc0fPMhTzcwQJR80/4GiASCVK2qgSAWQZFS
         xiKw==
X-Received: by 10.181.12.104 with SMTP id ep8mr961353wid.54.1383250003277;
 Thu, 31 Oct 2013 13:06:43 -0700 (PDT)
Received: by 10.216.123.145 with HTTP; Thu, 31 Oct 2013 13:06:43 -0700 (PDT)
In-Reply-To: <xmqq7gct5iu1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237175>

On Thu, Oct 31, 2013 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> One note: i tried the ${GIT_PREFIX:-.}  and ${GIT_PREFIX} and it seems
>> to give the same results. What is the expected difference here?
>
> GIT_PREFIX may be an empty string when you run from the top-level,
> in which case you would end up with "cd && ..." and end up working
> in your $HOME.
>


got it! thank you!

Eugene
