From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH v1 00/25] contrib: cleanup
Date: Thu, 8 May 2014 21:47:45 -0400
Message-ID: <CACPiFCLW_KujOdu5Ha0yg04HTzabJuu+s2uu0J59EFTKRY5p0w@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 03:48:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZv1-0002vr-S7
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbaEIBsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:48:07 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62561 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaEIBsG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:48:06 -0400
Received: by mail-vc0-f174.google.com with SMTP id ib6so4329120vcb.5
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7SZJlIHvLvyHhGEbS+RJurmT3HNqWt+FfSb8HlEJNNY=;
        b=BBHSzxFLKHLeOsU7qb59k8jlPsDKSqIQQKKnWNgDArnotZC4ms+tYOVk+b8w74arBB
         +eKuFezGo8/cP+rE+yRzcSJemFg916yVjZDhrDLhUmVWkjy+npNz4Qppwi5P+cx/JxxK
         6ggIK3m7xaJUHiH/L40Nfe2NKgntyoY2NhuhAOrvCylYP1rsRF5c6vZWQTyb7f+nqAdv
         8c78umpWMbkXQV5FXe+4IsWF/Kp0yuuZzXe8RoUmj6RRgPtPkeI1WcwTVRxRvb8fBLb9
         eO4/wxk14ZnNYGTU507v3Mw2tA2Clvzwy1+EYuGfsrmPQAKq4xjhEK4Fu46Tnb8tUmCJ
         ZrtA==
X-Received: by 10.52.27.209 with SMTP id v17mr3707964vdg.23.1399600085103;
 Thu, 08 May 2014 18:48:05 -0700 (PDT)
Received: by 10.220.183.138 with HTTP; Thu, 8 May 2014 18:47:45 -0700 (PDT)
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248494>

On Thu, May 8, 2014 at 8:58 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Let us be honest, the vast majority of tools in 'contrib/' have no chance of
> ever graduating, so let's remove them.

I am curious -- have you checked what parts of contrib downstreams
package&ship? Are you planning on CC'ing the (inactive)
authors/maintainers so they know that if they care they should host
those elsewhere?

My candid opinion is that you're trying to force a group of people to
undertake a pointless exercise. Contrib in many/most projects is
uneven, and folks know that. But it gives upstream a chance to push
for some minimal quality, and in turn it gives visibility to a bunch
of sometimes useful tools.

If my code was going to get the axe, I'd be rather pissed off. If
Junio is in agreement that code quality is bad, or tools should have
unit tests, then the push could be to address the problem or face
removal. For example: contrib maintainer, show you're responsive to
bug reports on the list, or face removal; add unit tests (or explain
why they aren't needed) or face removal.

cheers,


m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
