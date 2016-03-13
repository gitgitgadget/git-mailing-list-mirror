From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 13 Mar 2016 16:50:54 +0100
Message-ID: <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Sidhant Sharma <tigerkid001@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 16:51:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1af8IL-00023D-2D
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 16:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbcCMPvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 11:51:01 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33113 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcCMPu7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Mar 2016 11:50:59 -0400
Received: by mail-wm0-f51.google.com with SMTP id l68so73293111wml.0
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vvzUkDMtzPk4BD4Jdkrmw0my0oXnPT++5SHiywZQgr8=;
        b=e25h5nt1W4rfZbweJgkEMPyC+J0L8SWcLSN+j0btJE9wdfAnZUnmmQcaVyxlJCsj0R
         KDMSnHlqmhy4LiBq4I16y3vbqWhKXtXyhYWl3HEntbsv6FoxVZAk2r3pyoxFmIzUs1sh
         ctkkkoFUidvwR3cO+Jb0q8Aj9S11ylsWQiEzjtLIc0ljDyOpLan9OgoGzoHmDgenix/H
         GVp2q6n2RPAI+ejCSXEsMbVr43PDGaCTJ3lq+huB/NPIPK+YtIaomPjm8JL9s4Uy3e3l
         6Keovlmd+jqi5ocnIGbMuLqDex5IR6/Zj00uLQi8BnzZo7aH6gflf6V+xUTbeGB7XLmc
         UZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vvzUkDMtzPk4BD4Jdkrmw0my0oXnPT++5SHiywZQgr8=;
        b=Dvi6AIIrZ6s/qtKy/JXMZXLaavuAd7pdqybgT35iGo9x9mTO6W7Wy7l6THAZMhWCM6
         0gWg2wicKQCS5/79z2Al6JPPfH0rKVQ+6dlx2ELu35huTZ7JmaECf4Abj0sjnmnvDDK8
         p6OXrNYZuG56Avhyqwg3B4TxZ5A2Fqk5wfup0AeYBYb1yk0fUnHx1BxspfdFEnvqXZx8
         yFL0X/Xwi84hp/97GdXO16wJDHIiWfUX7kOL3MsWbqWK3dTjQkpY1003zuKMpfCZ1y0I
         C5jaPsb+oEp/6GADiXqSs7D6ZA6LgewoXARr8MNnT2lho79BjOynZk3z+asngOCG7FHb
         6yfw==
X-Gm-Message-State: AD7BkJKJ1ODVRSCgSbLL5lDmdnUjUWac8fTkVCGSWKRDAuFtXvfM5dr4mB/kFvluFbHvyg==
X-Received: by 10.28.19.204 with SMTP id 195mr14085796wmt.1.1457884257693;
        Sun, 13 Mar 2016 08:50:57 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA6B3.dip0.t-ipconnect.de. [80.139.166.179])
        by smtp.gmail.com with ESMTPSA id a10sm18084396wjb.38.2016.03.13.08.50.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Mar 2016 08:50:57 -0700 (PDT)
In-Reply-To: <56E3BE3E.9070105@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288754>

Hi Sidhant,

thanks for your interest in the 'Git Beginner' mode topic. I completely 
understand your motivation for the topic as your Git learning experience
matches mine. However, please be aware that this is no easy project. The
final implementation might be easy but it will require hard work to come 
up with a design for the beginner mode that the list considers to accept.
That being said, I am eager to learn about your ideas on the topic :-)

Based on my previous discussions with Junio [3] I think on of the most 
important aspects is to ensure that Git does not become harder to use.
I thought a while about this requirement and I wonder if a wrapper called 
'ggit' (guarded Git) could be a solution. The wrapper would pass all 
command line arguments to 'git' and check for potentially destructive 
commands. If such a command is detected then the user would see a warning. 
If the command is not destructive then 'ggit' would print a short instruction 
how to "undo" it. The ordinary Git user would not be affected at all by the 
wrapper. A novice Git user who is unsure about his/her command line
usage could use `ggit` as a safety net.

I am curious about your opinions on this kind of approach. I wonder if
people would actually use such a wrapper.

Thanks,
Lars

[3] http://thread.gmane.org/gmane.comp.version-control.git/285893/focus=286749



On 12 Mar 2016, at 07:59, Sidhant Sharma <tigerkid001@gmail.com> wrote:

> Hi everyone!
> 
> I am Sidhant Sharma, from Delhi, India. I'm a third year Software Engineering
> student at Delhi Technological University. I am looking to contribute to
> Git via GSoC 2016. I have also worked on one of the microprojects [1]. I've
> been using git for nearly two years now, and continue to be surprised by the
> vast number of features this powerful DVCS possesses. I want to contribute to
> Git because it has become a daily-use tool for me and it feels exciting to
> be a part of the community that makes effective collaborative development
> possible.
> 
> I would like to work on the project titled 'Git Beginner mode', and have been
> reading up the discussions that took place regarding this [2]. The reason I wish
> to take this project in particular is that when I initially started out with
> Git, and was still discovering how things really worked, I sometimes felt the
> need for some sort of safety-latch to keep me from making destructive and/or
> irreversible changes. So, this project gives me the opportunity to implement
> something on these lines for the future beginners. I believe a lot of discussion
> on the idea is due. I'm reading up on the commands that were mentioned on the
> project page to better understand what the project entails, and trying to design
> a solution for this, without making git harder to use or getting in the user's
> learning. I would really appreciate your comments, suggestions and critique on
> this.
> 
> Thanks and regards,
> Sidhant Sharma
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/288035
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/285893/focus=286613
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
