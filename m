From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/2] send-email: make annotate configurable
Date: Sun, 7 Apr 2013 00:54:30 -0600
Message-ID: <CAMP44s1+XDQNctRe_N1u=cmF+e83bzu4LFK6GUaz-UKagvYLBg@mail.gmail.com>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
	<1365239012-15079-2-git-send-email-felipe.contreras@gmail.com>
	<7vr4in818e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 08:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOjUx-00050m-4D
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 08:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab3DGGyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 02:54:33 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:40770 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab3DGGyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 02:54:32 -0400
Received: by mail-la0-f52.google.com with SMTP id ej20so272342lab.25
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qJNLh8etzkLpBD8gDmt5VUcmO++7bjNP/6w9n/EAP6Y=;
        b=uiEQi20bocuisJ1KJXhod8TNeZfZYGyqyEaz3GADgNZMI5sXC8v3xprLAdnLDtGhom
         hO6duDvfEopk4QvMosSG/HyjJcQMBn+84FPmzjidbUCx1/6bT/M4XwaPb/3zx4vUNCsK
         Pxr03axEz+//99ZPXGPeZUAEPtCbxh5h4lnlJCiDxP+kHO2dhQ6L7TBKEU5vQ8rDFxuP
         ofwZzN68771Kv3fOy9LeGYmZK82mCQ/CSq1frxWgUn4vb+WZx3QXNzAwzw0iYz9xPI76
         l9+XsW+1g9fmxf0cMVWG9E1rP9wLfJOg3YTZey+vU8uNTi/rfKcFiZr/8Q5IIIn7gGIR
         2ieg==
X-Received: by 10.112.132.166 with SMTP id ov6mr7673441lbb.71.1365317670735;
 Sat, 06 Apr 2013 23:54:30 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sat, 6 Apr 2013 23:54:30 -0700 (PDT)
In-Reply-To: <7vr4in818e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220281>

On Sat, Apr 6, 2013 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> @@ -305,6 +306,7 @@ my $rc = GetOptions("h" => \$help,
>>                   "smtp-domain:s" => \$smtp_domain,
>>                   "identity=s" => \$identity,
>>                   "annotate" => \$annotate,
>> +                 "no-annotate" => \$no_annotate,
>
> Wouldn't it be much better to let GetOptions know that --no-annotate
> is allowed by saying
>
>         "annotate!" => \$annotate
>
> which also let us lose an extra $no_annotate variable?

Right. Will resend.

-- 
Felipe Contreras
