From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/7] Rebase topology test
Date: Wed, 29 May 2013 18:20:10 +0530
Message-ID: <CALkWK0nXgbtYXVG5tosee9eQG5ody0OvFdF9bjfAzuAoRMchow@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <1369809572-24431-1-git-send-email-martinvonz@gmail.com> <CAMP44s1a-C7upUvouH+7=Zc-V16BOxUVDv+UVzkuOt9bpip1Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 14:50:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhfqD-0007BS-6t
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934492Ab3E2Muw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 08:50:52 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54544 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520Ab3E2Muu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:50:50 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so7932222ieb.20
        for <git@vger.kernel.org>; Wed, 29 May 2013 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l5a7KA2h1t0VSW2RKRijaw4xO4sRYbIgqM5ykA9cyG4=;
        b=I/8Vj/VT56B0GOabvdUt0/4A39U7nbKRJ7Zb8/SJ/4zO7r4NPYvgPpfnt1igtEg2ha
         0MQnXg8BpJ2PIvPq7wryuGvaEtwhkRAaP+2u44SXC2FDwXywNafV5yvtv+hAc/FYwmHH
         LyFDHbkMLYANeS5HZJnLdKATfpLentaNfG67GCNlCu5gUbinmOSYcXCyGUG7huGgJO6u
         TxTIinVQgBUqNiB7n+6YaAB/fl5AU3mBHPbjZ0PZROI/E1azki+2R8LCu0C0ByOI8guG
         jnQIdqv34w7VoHYcPJVWZsYw61NCK36V1/AI90Y1MvDlWgI6xJ5lNkW9BgBmxtD7xoBz
         +dng==
X-Received: by 10.50.107.6 with SMTP id gy6mr1146141igb.57.1369831850617; Wed,
 29 May 2013 05:50:50 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 05:50:10 -0700 (PDT)
In-Reply-To: <CAMP44s1a-C7upUvouH+7=Zc-V16BOxUVDv+UVzkuOt9bpip1Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225805>

Felipe Contreras wrote:
> I think a lot of the functionality of 'git rebase' should move to 'git
> cherry-pick', and then all the 'git rebase' code can be simplified
> greatly, and tests like these would help a lot.

What do we do about the leakages?  Want to take on the task of fixing
the merge-recursive machinery?

Cf. $gmane/222887
