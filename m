From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Tue, 12 Nov 2013 07:16:21 +0100
Message-ID: <CAP8UFD3sGqYsk_0b5F3d6TE-ZvcSg46fqDRT62ubX8NSDPxUxw@mail.gmail.com>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
	<87fvr5ps9m.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Nov 12 07:16:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg7H9-00059s-G2
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 07:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab3KLGQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 01:16:23 -0500
Received: from mail-vb0-f54.google.com ([209.85.212.54]:43226 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3KLGQV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 01:16:21 -0500
Received: by mail-vb0-f54.google.com with SMTP id q4so1041354vbe.27
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 22:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FLZ+EHd/86TMRtyfju6MSRqhy0CV53oZFKshIuw3WtE=;
        b=l0XO5rTmfZbv6hivPz4mOzcxDa9UJGn+W2Elle1Qs3k8b8zbowWjMN6ZGcyIzbcoVB
         Skh2bnryDO6ztrpnByrxL7yhzfasGgsJO5pRUTBkQDVvSfHyOOMP9phqBtnvE0SRQqNv
         1jx1lOtvnKI6akuSEM/76j1e2CrFPCAtXJycA+j3hZdRbb9WM1LZ23y7e2fVhwqlilXN
         D0BlBJn5n2P+Dt83N9+JoR9f1a2BNkHbui8dFSxiJomCSsnonBNlmMrchy382CTSCXpp
         XnIO1pt+4XRG9G98NDyeqi8S8pNIkhPv/2SMMo0wqdjsmky48JJWye1evEPD+bT53+dH
         xfeg==
X-Received: by 10.58.54.69 with SMTP id h5mr1313714vep.25.1384236981248; Mon,
 11 Nov 2013 22:16:21 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Mon, 11 Nov 2013 22:16:21 -0800 (PST)
In-Reply-To: <87fvr5ps9m.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237697>

On Sat, Nov 9, 2013 at 3:24 PM, Thomas Rast <tr@thomasrast.ch> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Christian Couder (86):
>>   strbuf: add has_prefix() to be used instead of prefixcmp()
>>   diff: replace prefixcmd() with has_prefix()
>>   fast-import: replace prefixcmd() with has_prefix()
> [...]
>>   builtin/update-ref: replace prefixcmd() with has_prefix()
>>   builtin/upload-archive: replace prefixcmd() with has_prefix()
>>   strbuf: remove prefixcmp() as it has been replaced with has_prefix()
>
> All of your subjects except for the first and last say "prefixcm*d*". :-)

Yeah, sorry about that.

Junio already sent me, with some others in cc, an email about this and
I replied to all asking Junio if he wants me to resend with a fixed
subject, but unfortunately the mailing list was not among the
recipient of his email and my reply.

Thanks and sorry again,
Christian.
