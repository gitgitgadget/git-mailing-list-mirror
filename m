From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Thu, 07 May 2015 09:04:30 +0530
Message-ID: <CD7EEBF2-FE5A-4309-86D8-CBF9F205A159@gmail.com>
References: <55463094.9040204@gmail.com> <xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com> <xmqqvbg9td0x.fsf@gitster.dls.corp.google.com> <CAPig+cQKqkoqN+o_QfVBRvxGdNuJn_oxD5YMsvnBOHguimJhGQ@mail.gmail.com> <CAPig+cStUNPZqEyE1rJVj5AsTeZFU54mc97rgQqiPbr5V1B0Sw@mail.gmail.com> <554A192D.7000102@gmail.com> <xmqq1titd3t6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 05:34:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqCaA-0008Eq-7U
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 05:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbbEGDeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 23:34:37 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35095 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbbEGDeg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 23:34:36 -0400
Received: by pdbqd1 with SMTP id qd1so28604804pdb.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 20:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=Ntl5U3fckep6mjgIJKjHrAvhRrDBRR2Olb5MmoAzb7Q=;
        b=XKLIsgDaGMN0/eYqCz1VzOBoVZAITPvz40tkSJhik6tJTo7q4QmEMJ8AaD7oC7WVwB
         ckJYilKQmZY3Phw/H+nEJfB3JLv6OqPaYsLskTEeP9eX3MtTLtG3nkNJs0rGhoxmGOpl
         MMEGx+cgK0OtMe4xGTtKyP6J9ueR/m4M2UxH5vZrgQ46NJRzEGDT9NdODR4YWvSUO+Rv
         vQdZ2jXSVMo1tnzyj7N/26/kaygVwPc3Hoi2rUAR+umiIP7lQ/BgoqOvgJ19D3gJnvSh
         n5KGiPWkg0k/YTqWqnXB+gzyQs+iruUIfgFR6x/lZP9XfnWu95dDe6gS9yQ1qydmKcHZ
         JDZA==
X-Received: by 10.68.112.195 with SMTP id is3mr3307442pbb.92.1430969676112;
        Wed, 06 May 2015 20:34:36 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id h12sm457422pdk.77.2015.05.06.20.34.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 20:34:35 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqq1titd3t6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268504>



On May 6, 2015 10:46:37 PM GMT+05:30, Junio C Hamano <gitster@pobox.com> wrote:
>karthik nayak <karthik.188@gmail.com> writes:
>
>> No other changes for now, apart from the changes suggested by
>> you and Eric. You can merge it into 'next'.
>
>Do you mean by "the changes suggested" the SQUASH queued on the
>topic?  If it is more than that, then I'd prefer you to send an
By saying "the changes suggested" I meant the SQUASH queued on topic
>updated series, as I do not want to guess how you'd plan to respond
>to these suggestions.
>
>Thanks.
