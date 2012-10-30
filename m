From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 15:35:19 -0700
Message-ID: <CAGdFq_iiGpYW-txPaa6mZrxg3mYdOX-Ez9uLF-rB5bAjZd5rWg@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
 <CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
 <CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
 <CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com>
 <CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
 <CAGdFq_h3L-1rPvb=dSYeXqEea+f+g2kRHp7aAjaU-AxjZHB7dQ@mail.gmail.com> <CAMP44s2KNmr7zAvFo2gOR8G=YaoBWiGPCjPY47x00eev6MOAFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ">" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:36:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTKPu-0008Q8-B2
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758390Ab2J3WgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:36:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38346 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758060Ab2J3Wf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:35:59 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so821581obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mSI5hADZsufAFVDUSev+f1n/wwc3WhiJZH5KvRblqUo=;
        b=HBCtTWLLjDythK0jfbz8yvF9Y+k+S/UiTYCATnOlvcbMZK9F6zZ5KXWyepT41fNxcc
         rEcBee3W/4JUhvt4p3L+DJcuNBo4M4s2kl63L6k+Nye3lk7pGPqEkyFTluiAGJ/pkmBj
         I7ej1laEULGn+I+769Q38Co35dtJwozQMusX++n8sOjs9pZgEDtWih3iudmAi5IPzvIL
         hl0p6bpijBDULieT24HJOXaOy/A+y+PTRzUNYKAo0byTopTllkQ6fEVotRjJlI5JgeHH
         FtzBsQiVDlSq6dtGkBbGAh1Rp01uvYYIc+0XLejSqB7/YcdFYSyV5SFI9AgV4/6gliY1
         IY7Q==
Received: by 10.60.7.41 with SMTP id g9mr29433321oea.18.1351636559354; Tue, 30
 Oct 2012 15:35:59 -0700 (PDT)
Received: by 10.60.95.97 with HTTP; Tue, 30 Oct 2012 15:35:19 -0700 (PDT)
In-Reply-To: <CAMP44s2KNmr7zAvFo2gOR8G=YaoBWiGPCjPY47x00eev6MOAFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208762>

On Tue, Oct 30, 2012 at 3:18 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Which is expected and correct; the branch already points to the right
> commit, no need for an extra reset.

I think you're correct. Thanks for confirming.

-- 
Cheers,

Sverre Rabbelier
