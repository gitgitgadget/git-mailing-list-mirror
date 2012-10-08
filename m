From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Mon, 8 Oct 2012 12:57:49 +0530
Message-ID: <CALkWK0=gYFuLBfWBiXcw=1Be9nYgRJgFSSDSbvwxPnttHqAFew@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7v7gr75s40.fsf@alter.siamese.dyndns.org> <CALkWK0m0ZzOmwFxAt40gHXi98JEq+==9ctiLYVYf4UE5GB+V8A@mail.gmail.com>
 <7v7gr2qb7q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 09:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL7lF-00052N-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 09:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab2JHH2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 03:28:12 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33787 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab2JHH2K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 03:28:10 -0400
Received: by mail-qc0-f180.google.com with SMTP id v28so2701931qcm.11
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Zrno1BhqqAIw+vrortbuyCaTuKUl/fc5H7v6J988L5w=;
        b=xWO+kbLNXgdP7xktUU+uywhI9Z/4u9YDZ8vT/afkEgNyeV/VqvBpKOitIxrVhXJuMD
         wUmKN4psBUuIdu6DXx8ut2bo3Bj9UGMqPODNXWNvzEXG2t0I45mQruCIzT4ZDEukJvU7
         7PsM0OVcpwsA99CJbTbA0aDqey6aWEdWvJDFN6H+BbEt8Dwy7/CFZUs3Nf1efX+kPLtJ
         hyWFOnmNMa4KPvvu6AZVWPO/dDBaiLyx4cfloiwO6Yo7dzm+VmlYV6/Nom5U7ZaOKHfO
         qVMHmuP+i6KgvB3p4UyIpAJ65wE+tBRVuk2s3sx/7r/XI0oxZ/24rP98mvDjVALGlRIA
         Td4A==
Received: by 10.224.213.10 with SMTP id gu10mr10720156qab.10.1349681289473;
 Mon, 08 Oct 2012 00:28:09 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 8 Oct 2012 00:27:49 -0700 (PDT)
In-Reply-To: <7v7gr2qb7q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207223>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>>
>>> With a weaker phrase, e.g. "These configuration variables may be of
>>> interest", such a list may not hurt readers, but personally I do not
>>> think it adds much value to have a list of variables without even a
>>> single line description of what each is used for.
>>
>> Okay.  Does this work?
>
> Hrm, is it useful without even a single line description of what
> each is used for?

Should we replicate the description from git-config[1]?  That seems
like a waste.

> Besides, how does it appear in the formatted documents?  A thick
> paragraph that lists names of variables enumerated without comma in
> between?

Oops; I didn't build it and check.

Ram
