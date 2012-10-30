From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 22:41:55 +0100
Message-ID: <CAMP44s0dxW_FGGFQF_gDduFcGr3xri41SF0mvTjxbN-jbYWZ0w@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
	<CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
	<CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
	<CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com>
	<CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
	<20121030213827.GM15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, ">" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:42:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJZY-0007NM-UE
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934743Ab2J3Vl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:41:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43037 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934733Ab2J3Vlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:41:55 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so775192obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NL6hFad7+6hMdS9UOQDyQAagO3c/OS3/XD3Irkhodm0=;
        b=eXYKNwZlBHtzVSi6Z01+lgWIg/RAAOWs2BcgrTWK3hGdrCUgQ+mMbyBhIDt+bOEIzg
         it0RHeCtDlemSzUZHop5afbXc7D2EMdvu1t+3vDzpVmxwycw0dHaj1h7joPm9F0LTRRw
         g2OYpeoXA15KWJNKQX5rosTFlR75hNktMAMbMpX3NQqFHsaFn7K/aAO3s8H/cwY5IcYb
         yaDpI9v7BW577bOGKa+zaL1GV+acPioX/Yp4gMP2N5n4PxnwHX2bKFiQzDfXvH0y3Yi0
         hGyU42AO9ZaqCV27sx2tEN7ugHGvsVg4Zidef/4KjAEl1syJK3yFdJDZQEh5Av7190ub
         rMeA==
Received: by 10.60.12.233 with SMTP id b9mr30574090oec.95.1351633315337; Tue,
 30 Oct 2012 14:41:55 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 14:41:55 -0700 (PDT)
In-Reply-To: <20121030213827.GM15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208748>

On Tue, Oct 30, 2012 at 10:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> % git fast-export $marks_args one
>> % git fast-export $marks_args one two
>>
>> Then yeah, 'one' will be updated once again in the second command,
>
> That's probably worth a mention in the commit message and tests
> (test_expect_failure), to save future readers from some confusion.

It is mentioned in the commit message.

-- 
Felipe Contreras
