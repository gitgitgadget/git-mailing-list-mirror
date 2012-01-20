From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-sh-i18n: detect and avoid broken gettext(1) implementation
Date: Fri, 20 Jan 2012 21:24:00 +0100
Message-ID: <CALxABCZnz-8BuXf=-HrH7UZXi6pQ3VzL4HrOKgKHqWwUMnwJQA@mail.gmail.com>
References: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
 <1327063775-28420-1-git-send-email-avarab@gmail.com> <7vobtydu0o.fsf@alter.siamese.dyndns.org>
 <CALxABCZJATyVRf9akmfpn3WpJ8Xt80Ky0isFOTwDGpFKvFp3nw@mail.gmail.com> <7vfwfadt10.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 21:24:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoL0c-0001I3-VZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 21:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab2ATUYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 15:24:22 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:56862 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753281Ab2ATUYV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 15:24:21 -0500
Received: by obcva7 with SMTP id va7so1144330obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Hh7GJh0pJ4sspOOv/ozEuLLzbUO/Y60A8nsC4Y4/810=;
        b=WkbWT9ty3JLFyY1+kSMqe6nqt/lOLCY2z+HMY/1hPZvuSXeaHZ54SZVTA9Rs8doArQ
         F8fI+FxsAM2BoFUGcJr9xdEl1kBvpXTLDjPRUW7zPLxD4HQbbdG7Q2I74u6e6jx/316T
         Gs2maZrNlqSa/+fPJNP3s5tFRRN1MBgu4UKeg=
Received: by 10.182.160.5 with SMTP id xg5mr4470838obb.53.1327091061192; Fri,
 20 Jan 2012 12:24:21 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Fri, 20 Jan 2012 12:24:00 -0800 (PST)
In-Reply-To: <7vfwfadt10.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188901>

On Fri, Jan 20, 2012 at 21:21, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>>> ... At build time, instead
>>> of, or in addition to, the $(cmd_munge_script), we could replace the
>>> single @@GETTEXT_SH_SCHEME@@ token above with whatever scheme we want to
>>> use to hardcode the decision we make at the compile time.
>>
>> I can imagine a Solaris system being upgraded to GNU gettext _after_ Git
>> installation. Hardcoding the decision might break git scripts then.
>
> Just like you would break http transport by removing libcurl after
> installing Git? What else is new?

Removing - yes, upgrading it - very unlikely. Besides, the current version
wont have problems with such an upgrade.
