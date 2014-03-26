From: George Papanikolaou <g3orge.app@gmail.com>
Subject: Re: [PATCH] builtin/apply.c: use iswspace() to detect
 line-ending-like chars
Date: Wed, 26 Mar 2014 18:58:19 +0200
Message-ID: <CAByyCQBX+xfDdMwFOE2bZg8W2S0jwj2nLV36JwH1N3D4Fn2BUw@mail.gmail.com>
References: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
	<532C1EFA.3000109@alum.mit.edu>
	<7vd2haq3n5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 17:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSr9r-0001gG-61
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 17:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbaCZQ6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 12:58:25 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:46689 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbaCZQ6U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 12:58:20 -0400
Received: by mail-vc0-f181.google.com with SMTP id id10so2820539vcb.12
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P/kqcBPqF4RBItF4JqRHbA6mdVfA4/8l3AGEf5hFyT4=;
        b=NA/XzCZcsE1Gbc7ThsxMsTyzXPsjhvq920rWnjsGPeCnHZ1eA1h8Rd2xqc8Y8POPgq
         kndDDC294C+PFWHE/WxrOu3Tg8GV2cgodIcBtGgVw1S+PznGnltQ2JV3MT6bHKjVy2Kt
         aSQcIAK7NDM5E9QgqTe8Er+dyn2TrlXuN4TuYN40reXykYFQa5+cMOMyCAGeBXWbCMKq
         ywM4VrEwZ1CZGo5ZbiSIEIqduSAfWUTQaKQcWRV+ofKLlpRMMFBXV7ixOi+4npdB1Ebw
         EDjjCWePZZqdSFBt4q0X8laS8nAI2pRgEC6My1iOfHOVMKnHw8CgU1WyaFXZfChM8lk+
         xT7g==
X-Received: by 10.221.4.66 with SMTP id ob2mr1401926vcb.28.1395853099675; Wed,
 26 Mar 2014 09:58:19 -0700 (PDT)
Received: by 10.58.29.48 with HTTP; Wed, 26 Mar 2014 09:58:19 -0700 (PDT)
In-Reply-To: <7vd2haq3n5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245197>

On Tue, Mar 25, 2014 at 6:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> As a tangent, I have a suspicion that the current implementation may
> be wrong at the beginning of the string.  Wouldn't it match " abc"
> and "abc", even though these two strings shouldn't match?

Wouldn't that be accomplished by just removing the leading whitespace check?

I'm somewhat confused about what the function should match. I haven't
grasped it.

--
papanikge's surrogate email.
I may reply back.
http://www.5slingshots.com/
