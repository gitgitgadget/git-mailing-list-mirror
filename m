From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v7 2/3] branch: mark missing tracking branch as gone
Date: Thu, 22 Aug 2013 08:00:53 +0800
Message-ID: <CANYiYbEewHBTvmeZbfQXj-36aujjtrABzc=2fT1dgA-rJmDynw@mail.gmail.com>
References: <cover.1376618877.git.worldhello.net@gmail.com>
	<7vzjsio99d.fsf@alter.siamese.dyndns.org>
	<cover.1376620130.git.worldhello.net@gmail.com>
	<a4b446b4ff63f56f8203df0723eeb319b2ba58dc.1376620130.git.worldhello.net@gmail.com>
	<vpqeh9nh4u7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 22 02:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCIL1-0001TP-KH
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 02:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab3HVAAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 20:00:55 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33367 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab3HVAAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 20:00:54 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so998574wgh.5
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t7pWssDIN+eCyFAGwgCOL/SaJpwhRGpgoN7yb50ovWk=;
        b=aj4UkQM8YjpHAKLIIVUC0dP3FCrwuQRPocw03N6HiRG+UtJdq32tHTtXQ4rFK6Y7HB
         /a+xP+yXZ6p7JA4Dv5+pdTiEsv4ehvhzY2InblPkoIZmBbyAEXG6E/6YO0JL9IL58v1l
         vpdKw70z6HqNlrgcp3//W21z5mtP6e6tlWjfusQL9ih5Pe3PerkHNuP3sPH7kf6nmWiz
         VxwDNMHQ5i2fF9CIFda+QG+h7TKjDDgU8UaDZBEiw2QHA3JgyGqsN982fLJFWkHTgNtH
         M0L66mqsndjL/h/IwKBp8flXWkQJ+ZQ3Gt01Fp4jn2RKoxZpDh2v5u/FrRUbKTue15WP
         +PWA==
X-Received: by 10.194.11.67 with SMTP id o3mr8023890wjb.0.1377129653105; Wed,
 21 Aug 2013 17:00:53 -0700 (PDT)
Received: by 10.194.104.201 with HTTP; Wed, 21 Aug 2013 17:00:53 -0700 (PDT)
In-Reply-To: <vpqeh9nh4u7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232752>

2013/8/21 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>>     $ git status
>>     # On branch topic
>>     # Your branch is based on 'topicbase', but the upstream is gone.
>>     #   (use "git branch --unset-upstream" to fixup)
>
> Sorry, I didn't follow closely the previous discussions. I'm not sure
> "gone" is right either, since the user may just have configured an
> upstream that does not exist and never existed. Perhaps "absent" would
> be better.
>
> Just a thought, shouldn't block the patch.

Thank you for following this, and offering better statements. I will
make another reroll after the end of my business trip this week.

-- 
Jiang Xin
