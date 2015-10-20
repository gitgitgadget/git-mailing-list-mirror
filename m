From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Wed, 21 Oct 2015 02:23:33 +0530
Message-ID: <CAOLa=ZT1AEyXbETrRdMQMfBFv5qJhNL4msRxFGpKe0K5aA7SsQ@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3l5zgst.fsf@grenoble-inp.fr> <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
 <vpq8u7dp9qr.fsf@grenoble-inp.fr> <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
 <xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com> <vpqpp0ojvs6.fsf@grenoble-inp.fr>
 <xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
 <xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com> <CAOLa=ZT5AUAOgHNhX3AwpY20AZkm39=-JVQjUCgb0_x6LTHXaA@mail.gmail.com>
 <vpq7fms9cjs.fsf@grenoble-inp.fr> <xmqq37xfncak.fsf@gitster.mtv.corp.google.com>
 <vpq612bzz0o.fsf@grenoble-inp.fr> <CAOLa=ZQ5dCx4XheMvaFo1u-fR=uaR-LU-n7KHR3xNJ7TuF-zww@mail.gmail.com>
 <xmqqzizfa2n7.fsf@gitster.mtv.corp.google.com> <vpqy4ezjmyp.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:54:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zodv7-0000iv-N1
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 22:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbbJTUyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 16:54:06 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36027 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbbJTUyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 16:54:04 -0400
Received: by vkex70 with SMTP id x70so17720012vke.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZV6/xqmBiERuWOMyaLvsOYfY+8TWx2H+ZnCvsownv+Y=;
        b=iiDjk/lVqvNHnblFHRB1X6JEGt0cbGGn00jwv4jQpy8Z2KDLTMJZiwpfPQGf4vNFkO
         1seDo+v9yn+/MQGmcE4XvwEQkDlSp1l/DtV8MSaE6/5c3SklY9eRq39tJ3SJlaCkMeSK
         gMDfX4mHZeGvvSEHrXOhcQFAwNcDsO8wbc23TZCgHHgpZ/CalwYU3i6WRUNRW68TeFGr
         Zijaj+uRfOYgGCSaynbj30X3LItGaFUmKg3V2C2sJjyKVCQR/MDPc58Kv4RXhzHWiJiF
         nmuc3pvACbhyfKWNx+v6hpKR0KRQwKybOUVoCkzI6tsYh6E3eOs9n6M28cL8D8rqGlAB
         yDFg==
X-Received: by 10.31.49.10 with SMTP id x10mr3512255vkx.46.1445374442825; Tue,
 20 Oct 2015 13:54:02 -0700 (PDT)
Received: by 10.103.0.7 with HTTP; Tue, 20 Oct 2015 13:53:33 -0700 (PDT)
In-Reply-To: <vpqy4ezjmyp.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279939>

On Mon, Oct 19, 2015 at 1:42 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I personally would suggest whichever order you feel more comfortable
>> and less error-prone.
>
> This is a good summary, and I fully agree with it.

Well then, I'm working on the parsing part of it before this series :)

-- 
Regards,
Karthik Nayak
