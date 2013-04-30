From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 17:53:50 -0500
Message-ID: <CAMP44s02QkL7QAuHHm_uT6B4QCzk9Mur0_w_D8t2A2u1go2F8A@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
	<CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
	<7vsj27ac2a.fsf@alter.siamese.dyndns.org>
	<CAMP44s3=frHWUh8rQ5kTooUJqwAtkEG37MaeY3Ho6G7-kwZQ_w@mail.gmail.com>
	<7vbo8vabet.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:53:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJQr-0002TI-7e
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933897Ab3D3Wxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:53:53 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33640 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933600Ab3D3Wxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:53:51 -0400
Received: by mail-lb0-f177.google.com with SMTP id x10so1009971lbi.22
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 15:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=U98zKuoif3Q1pD0wqqIsMy72aK4jBXIqKeWRWr+4/a4=;
        b=QYO/aX1BTPEBpb9xoV92TaQZwMfcZvV5FLaaK8QNCE+WKD/HYjlSMK9Brqsr+9RoCf
         p36UhoJVVQzLdJSirYAy+bqqfNBWC3p90EFFJPQNXnhe7KgyLessajyODh41AOCAHKUH
         JPbb9Odb6PSGx8YJoUp8JG+0NZSBFip4BdwdLZ3zzLw3gtJLPfXZtHkuu0VzA26N3Lrp
         Eb2qspHcWSHY+Gre05gCQdxpl1KlZ0gdknR0tph/uWrfCWhqX+GUU/ljhBZVhYcigUyh
         0dxSVMaxz9dN4v5AeqQngCRgPwjIZ8zqaopT/LLkuTOCysHS//fPJYzpUxDMm1q/UxlM
         I43w==
X-Received: by 10.112.139.226 with SMTP id rb2mr386429lbb.12.1367362430175;
 Tue, 30 Apr 2013 15:53:50 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 15:53:50 -0700 (PDT)
In-Reply-To: <7vbo8vabet.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223038>

On Tue, Apr 30, 2013 at 5:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Since 'update-ref master' updates the 'master' ref, and not
>> 'refs/heads/master' (IOW; no parsing at all), I think it makes sense
>> that @{-1} is not parsed, and neither is @.
>
> That is a very valid point.
>
> What should "rev-parse --symbolic-full-name @" say?

Probably the same as 'rev-parse --symbolic-full-name HEAD' (it doesn't
with my patch).

-- 
Felipe Contreras
