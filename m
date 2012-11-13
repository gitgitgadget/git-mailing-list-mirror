From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 18:20:38 +0100
Message-ID: <CABPQNSZ6_jaEf+_pVon6w=zX5_FFHRHO0KoUSnS67O-j3t9n7w@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com> <20121112233546.GG10531@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYKB9-0006lV-3p
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 18:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228Ab2KMRVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 12:21:23 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48152 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932220Ab2KMRVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 12:21:20 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so7593194vcb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 09:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=y9FiJ6yJLpbTMqk0C9LxJ6D2aqRinChi6RtQ/UOl9aw=;
        b=LgYptV46pt7ninw/qiCB06c1wwh/YQwxZozCMCyhDpm4hiv8Q9dFfXyzS1acWedZUW
         nkVHTSEMZIvApNS5xlIC5rOczIN72ZzWMkb9QBxji8UhiHtqWDTLkwJRTmur8EUzfBkf
         wZ3goB374LTVZnOgJ6x6yo8gTfcSYK0GUT8ApqGDiSNNDzd/FW9p/6ly2isByBypryra
         IEMK6WK5pYwIXJUtu1kznxG/pOOEaxQijwHx7ipbcZ96wkL7NgYnh2YtkXhEGLLPyZj6
         rM93+C3dUNv882y6Z31sbWkbjmOeqSdjOspDHzZ/1vmmSXCZVYZ2XqQviMMFCsDlrPjo
         5+pg==
Received: by 10.221.12.9 with SMTP id pg9mr7078789vcb.68.1352827279089; Tue,
 13 Nov 2012 09:21:19 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Tue, 13 Nov 2012 09:20:38 -0800 (PST)
In-Reply-To: <20121112233546.GG10531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209643>

On Tue, Nov 13, 2012 at 12:35 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2012 at 06:06:50PM +0100, Felipe Contreras wrote:
>
>> There's no point in asking this over and over if the user already
>> properly configured his/her name and email.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> I got really tired of 'git send-email' always asking me from which address to send mails... that's already configured.
>
> It should be defaulting to your regular git ident, and you just have to
> hit enter, right?
>
> I think it's probably reasonable to skip that "enter" in most cases. But
> I'm not sure why we ever asked in the first place. What do people input
> there if they are not taking the default?
>

I usually input "Linus Torvalds <torvalds@linux-foundation.org>", to
give my patch high priority ;-)
