From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 8 Aug 2013 17:09:16 -0400
Message-ID: <CACPiFCLPA=ih5PVgqoi763YL2CYvJ1friC1YMG5ziLrSPUpYZg@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
 <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org> <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:09:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7XSq-0005C9-AO
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966648Ab3HHVJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:09:40 -0400
Received: from mail-qe0-f52.google.com ([209.85.128.52]:52750 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966588Ab3HHVJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:09:39 -0400
Received: by mail-qe0-f52.google.com with SMTP id cz11so2001862qeb.11
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qfEiK+YpGG97siOKr+mpNhl/7sSuGdK500q+YrOXhsQ=;
        b=yKZP0jrPOqMEWUWaVX8QKEiU+uiexBROvUogRGph810w9CuoUj+QL7WMO9s7FuZTUS
         CS3884r8rCoI5rgHt1lg/l/PcMJ43LbquMRLyy9IBxGakHfFTrv19uT42pqF4n4ZcYQn
         nahW/47boV8IhdBbNmjHlUzuJ/kytu9kE0jrF25k1WmP1rfvC4RL7tHHdnccwIm6mQnv
         R8aeQTAEvOVC8zVI3q7XoEMpETtJ0pefFf8XejJss68Ogrx8t5YC2dvfkrIrDlUmlC16
         9EnFY/cuXfjvGomdD3R/E0J1i0q4/Qt+rq3zAdvszgmVVmaplD3rZECIJsH3RIxACmM9
         kqCw==
X-Received: by 10.49.97.99 with SMTP id dz3mr8097511qeb.38.1375996176139; Thu,
 08 Aug 2013 14:09:36 -0700 (PDT)
Received: by 10.49.61.35 with HTTP; Thu, 8 Aug 2013 14:09:16 -0700 (PDT)
In-Reply-To: <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231932>

On Thu, Aug 8, 2013 at 4:04 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> You will need to educate your contributors and potential contributors
> if you want these problems to be fixed.

TBH, I think Junio is exceedingly kind and generous with his time.

IME (and there's quite a few years of it :-) ), good contributors
learn a little bit asking, and ton on their own.

Your tone is quite demanding, which I personally find... rather out of place.



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
