From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v2 3/8] rebase: cherry-pick: fix sequence continuation
Date: Wed, 29 May 2013 01:05:42 -0500
Message-ID: <CAMP44s0MQ-u=Yo1RAoxsVyiAe7xcorCW992xsa4YsEyH9RbzoQ@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-4-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6ivOnRfOVMTsgDygi=2dvxmMOqqWdqs7CBYohThOVzt7Q@mail.gmail.com>
	<CAMP44s0Zy4KpPN1n6HOVXWyCuevenbSFnH589YngMB9NVWcamQ@mail.gmail.com>
	<CANiSa6h7fY=GNM0VvFXvE-LD=nVWbEBGqWbaheZ6gr518_aPNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 08:05:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZW8-0007aE-I1
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab3E2GFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:05:44 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:54910 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab3E2GFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:05:44 -0400
Received: by mail-we0-f171.google.com with SMTP id t59so6125421wes.16
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FhY/1OZ2Gx7QMXWzEqBEMwFjR0nsjomaFg6K2FaS1GQ=;
        b=MhFii5sUbN8mWAb/sylS118WeqI3DuqyUPdF53aaSdXhibFfsAh4ipTvAhM4b6egud
         o/95DqeQXcK02lsuc7N7ODqCbT7FHs9pWV0WhEf98hpa4FPCTCbUisfI+9VZAms0EWHW
         O4x6bgODoTcoFXFNbMU3ilf7GIpSLGXCSAquW/CWMiP7rxqsuvhrW2W1/A41MPaRfzfO
         qpDVUoWLOs6ROY4GGlFm1WFpVNG5q5ULCyJ8uwrfohLUI0HeqwV4DsKg61i/RtyNTLUC
         vjMEb6y0O2UF12F23gX8SCcFxIrxeq9nP227mfsxXF5Atdn3UkjhgZAIA3QPxoCQJICe
         A1jg==
X-Received: by 10.194.77.66 with SMTP id q2mr888837wjw.34.1369807542864; Tue,
 28 May 2013 23:05:42 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Tue, 28 May 2013 23:05:42 -0700 (PDT)
In-Reply-To: <CANiSa6h7fY=GNM0VvFXvE-LD=nVWbEBGqWbaheZ6gr518_aPNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225749>

On Wed, May 29, 2013 at 12:51 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> On Tue, May 28, 2013 at 10:41 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>> One change splits, the other change fixes, what's wrong with that?
>
> I didn't say there was anything wrong. I was asking if the bug was
> there before (and I didn't see an answer when Junio asked).

Why wouldn't it be before? Did I mention a commit that introduced a
problem? No. Did any patch in this series introduce a problem? No.

All we've done in this series is 1) reorganize the code without
introducing *ANY* functional changes, and 2) fix a bug.

If you see 1) introducing a problem, or 2) introducing a problem, then
mention that in *those* patches. If there is no problem with 1) or 2)
then it follows the problem already exists.

-- 
Felipe Contreras
