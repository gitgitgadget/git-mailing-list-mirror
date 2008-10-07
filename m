From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Implement git clone -v
Date: Tue, 7 Oct 2008 08:21:28 +0200
Message-ID: <81b0412b0810062321h33abe076kd87b60bffdaf218b@mail.gmail.com>
References: <81b0412b0810041442i3aa29628lf66ef9b188fe8ce7@mail.gmail.com>
	 <1223331590-22138-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:22:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5xv-0002go-SV
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYJGGVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbYJGGV3
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:21:29 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:35475 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbYJGGV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:21:29 -0400
Received: by yx-out-2324.google.com with SMTP id 8so506238yxm.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 23:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YZT4LOGRK+X/efiVKfHjUxLmedCPpIX90GoxpBFTBu4=;
        b=Lu7O7C+s/KN+o29XCgPqtLp0WUdv6LxQxRk2NJXhCJ/O9YX0mluI2InhjZfZt5NVrj
         g3JtdRfKjP2icz4WmKIKZ8Orpn2E13D//SD/P+jozcqsMAIL3L4TPTQE1HI4YT063BEp
         ffGvetLTkxtsVKpulJdvCRx95ZC0lmV8xmxWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vboZZHWMGzbpeLCrshFbImDwlo4JPB9lp27aKFb5lmn/vwy1+DPRuPb5qj9x6lybaB
         J71byZkUSm3f5Bpk0fwCTlAgWX5SNm0eHYMhYr4tahBH9hkuBwnB2+dLGJMBinFPwDk3
         /XOh4r5qS4imqrwAQs+jDKmmPlhfsMkSsp3pk=
Received: by 10.100.171.16 with SMTP id t16mr2635856ane.48.1223360488202;
        Mon, 06 Oct 2008 23:21:28 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Mon, 6 Oct 2008 23:21:28 -0700 (PDT)
In-Reply-To: <1223331590-22138-1-git-send-email-vmiklos@frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97673>

2008/10/7 Miklos Vajna <vmiklos@frugalware.org>:
> The new -v option forces the progressbar, even in case the output is not
> a terminal.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Sat, Oct 04, 2008 at 11:42:15PM +0200, Alex Riesen <raa.lkml@gmail.com> wrote:
>> 2008/10/3 Constantine Plotnikov <constantine.plotnikov@gmail.com>:
>> > Is there a way to force a progress output on stderr for git clone
>> > preferably using options or environment variables?
>>
>> No, but "-v" option is not used for anything yet, so you are free to
>> implement it.
>
> Something like this?
>

Yes. Does it work? :)
