From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] config: add _cb suffix to callback functions
Date: Tue, 27 Aug 2013 15:47:08 -0400
Message-ID: <CAPig+cQ0a82N701PP0D-bgT7c_OGfZ1jdKeQxB9vaqqSDJyNBQ@mail.gmail.com>
References: <1377591136-10680-1-git-send-email-ncopa@alpinelinux.org>
	<xmqqmwo3falr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Natanael Copa <ncopa@alpinelinux.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:47:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPER-00059K-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab3H0TrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:47:10 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:39581 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3H0TrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:47:09 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so3063383lbd.30
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Lbhn7giEZ5Hxq/eDpzvJuqsTLTzgY/0iiggv67+hLvs=;
        b=DEJEqfTj4tkg+rJPdOjYXcNOMa7ND4Rbt7p/pWcAXKSNG0QOiz7jWHxTbh3UP6s26d
         JrLDP5FMUuCcazDTWQo+pxU9+7ZpJTRC3HX2+0LjlDVVWmjR0oBfBGo5FAQObllEQRyu
         Hq5Qm7FIEnYf9DCRwDnTt+fuw0lnicarOBRuyisn3vd52/RNyZW8f57BjU4w0ziEqHq2
         +SJL7wEuzuMOphfP92wjLtsTGmmbpZ+EsPfodG4lZWTRAwyCTf6vxXEoYsM3JqY8bO1V
         OpusZUdpnYFuKtZsS+dbXzrbMvEyofBqns3R17PhrmAgnrj4sqPRhsP96a4g1LvKUITZ
         jVVQ==
X-Received: by 10.152.8.115 with SMTP id q19mr20345487laa.16.1377632828228;
 Tue, 27 Aug 2013 12:47:08 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 27 Aug 2013 12:47:08 -0700 (PDT)
In-Reply-To: <xmqqmwo3falr.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: HfaFdmw5Ot63Byr9E5UrsAB3yAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233147>

On Tue, Aug 27, 2013 at 10:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Natanael Copa <ncopa@alpinelinux.org> writes:
>
>> Commit 4d8dd1494e9f3af2e9738edaca40ada096f7bf10 introduced a build
>> regression on uClibc which defines fgetc as macro. To work around that
>> we add a _cb suffix to the callback functions.
>>
>> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
>> ---
>
> Thanks; I think Peff already fixed this yesterday.

For reference: http://thread.gmane.org/gmane.comp.version-control.git/233021/focus=233036
