From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: barf when user tries old:new
Date: Tue, 21 May 2013 16:12:09 -0500
Message-ID: <CAMP44s2EbKxqCFepnBj82oprz9WDWqS935w-fXFRHxrh+ng7kA@mail.gmail.com>
References: <1369098165-8727-1-git-send-email-felipe.contreras@gmail.com>
	<7v7gisqonp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 23:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uetqx-0004Xu-UV
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 23:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab3EUVML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 17:12:11 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:61710 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3EUVML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 17:12:11 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so1339439lbc.16
        for <git@vger.kernel.org>; Tue, 21 May 2013 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j8PymkhxEew9Kl87D0EZpOo1Im98V2TQfLSFdxGHSpQ=;
        b=ylu5OQHWlkYmo7TBCFUCRRgMhU2E7lbMovuiGGkPw2zmiQUumXKhhMcXSpf8vJetAX
         5hAl9ffCilZqZ/MFzlTG36a4KQ26OnB8eadU9vO/QLgrQfn6EjPuG3AvBCtXm0mTiblY
         zL6FBioyuq1fMMruVhhHYbRXeFhh2nr4t6s8I18KanXgdtTYIZ/H32roMo8MWUtOiavC
         yQqHMQS4O9hx2Bg6RfVudbCh6G1EssJfxrp+euK4pY5qnQWUVQ+W61SVnQY9MqDgWnwj
         ayPGcV60yhePb2qU2bQG33XmMm5CNAVnCBkWKRsRySuX6XoT2vqK4HzDQvPU4ASOvrt1
         ed3A==
X-Received: by 10.152.22.168 with SMTP id e8mr2363706laf.20.1369170729346;
 Tue, 21 May 2013 14:12:09 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 14:12:09 -0700 (PDT)
In-Reply-To: <7v7gisqonp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225078>

On Tue, May 21, 2013 at 11:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I won't
>> bother rationalizing if this makes sense for 'master'
>
> As this is a change to an old code/behaviour that was with us with
> many released versions, it hardly is for 'master' during -rc period.

Probably.

-- 
Felipe Contreras
