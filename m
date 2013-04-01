From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] fixup! pathspec: support :(glob) syntax
Date: Mon, 1 Apr 2013 10:08:31 +0700
Message-ID: <CACsJy8BO=LyFfmZtWEADk3WGm_dt6kta-CDRMasKx1FXmkbPqQ@mail.gmail.com>
References: <eeccb0bb969ed30420685c210865da22d9c85407.1364665628.git.john@keeping.me.uk>
 <7vobdzm09n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 05:09:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMV7k-0007C2-NM
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 05:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493Ab3DADJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 23:09:03 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:62238 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab3DADJC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 23:09:02 -0400
Received: by mail-ob0-f169.google.com with SMTP id oi10so1568785obb.28
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EQcg6ZsK7pSkuLkCpl3EtgpUJc2dj5saGvkv4zZ2tos=;
        b=OkkOcYiBmWopbOEWu7K3cAm9soVL5WIGDMhAVM+BU+QccTfGyJcpLEeld1HW6TyXl0
         9i6U9TSvFdt58dNRnjNoTndf535otk6maX3ar930EkcK3wgaa1LyXiJEPWGxreYPiU9m
         q8jnRKzUUbTDSTrQzyDZ38dyltrZK/O7SFfQMeDlYUGvVkLlqQmsNWITDkrnuwXnwQ0B
         cDrDSAWVdJwYBj0HwxQfxXYL8kAiK8MKzsvsxNlPie0g7ZGvk9iz1YIKVy0aKbvJvnuB
         4+UieNdV2mabgjjviODzdzlfdffenH1G/nPhb+xwxtrp9D9gOcsrgR3HFkOu0GNJRHUv
         B6HA==
X-Received: by 10.60.8.197 with SMTP id t5mr3630377oea.4.1364785741112; Sun,
 31 Mar 2013 20:09:01 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Sun, 31 Mar 2013 20:08:31 -0700 (PDT)
In-Reply-To: <7vobdzm09n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219664>

On Mon, Apr 1, 2013 at 9:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> A formatting fix for a patch currently cooking on nd/magic-pathspecs
>> (cc3d8045ec1e2323c5654e2af834e887f26deb7e).
>>
>> ---
>> The latest version of this wasn't posted to the list in full, so I'm not
>> sure about the recommended way to provide feedback.  Hopefully this is
>> easy to squash in.
>
> This is one of the reasons why I do not like to directly pull from
> contributors.
>
> Checking by others from the sidelines what was requested to be
> pulled like you did is greatly appreciated.

This bug exists in v1 [1] as well. Do you want me to resend or you
will squash it in yourself?

[1] http://article.gmane.org/gmane.comp.version-control.git/218231
--
Duy
