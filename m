From: Andreas Ericsson <ae@op5.se>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 16:09:30 +0200
Message-ID: <4FA3E31A.6060606@op5.se>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>	<4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com>	<86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com>	<86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com> <CAMP44s2h4EY3Qu2+Ys_n3TUzmyykMkG-wMoqmKg5hjg24JQ+bg@mail.gmail.com> <4FA2D565.1080806@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 16:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQJCl-0008G0-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 16:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab2EDOJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 10:09:37 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41705 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab2EDOJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 10:09:36 -0400
Received: by lbbgm6 with SMTP id gm6so2047050lbb.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 07:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=QopAlEXuIVJ974s23n3YV/A08F4EeEHhB7/DIZ2e0k8=;
        b=oDcKtokG/zXBnF055BDH6c/mFy1gV5HUDOm7ttuktcbhxMbIxnq7XuXavLk9H7Hzc6
         qrxkoA6dpZPSyDKWrJbl8vPZARpBUenpwsLYk5p1HsfaK8bfXm/xogqEddM3f4D4TiHf
         NaUwe2bBVZ05pFvRt+hhelFVWlk+N2dd7KTOFbqDK9DqtjSntOYg8HHuovx+qYcJKMo/
         2h5XC0VAkAqdZAF174ketQBqRdVh7nEdFE39uJgrDkjkdNPIuPODG45tmLksooTPgISL
         xOQ8nh2QcgZ+LmOdMRJrMYYX625NVF2OBN6hMEW07LySWc/KWaKFo7+o6EhP2l9GQV6o
         eqXQ==
Received: by 10.112.47.8 with SMTP id z8mr3038743lbm.51.1336140574612;
        Fri, 04 May 2012 07:09:34 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id b5sm11094472lbg.15.2012.05.04.07.09.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 07:09:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120424 Thunderbird/12.0
In-Reply-To: <4FA2D565.1080806@palm.com>
X-Gm-Message-State: ALoCoQmHLbm+MB5/CDYoUEzttKEGMaCf4GE/UgJ70aQ6AiTVgv6gfF/1yWQtD1gbtThyx+f9gv/I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197024>

On 05/03/2012 08:58 PM, Rich Pixley wrote:
> On 5/1/12 16:30 , Felipe Contreras wrote:
>> Show all the hg commands of what you are trying to do, and we can show
>> you how you can achieve the same in git, but much more easily.
> hg init foo
> for i in `yes | head -4000`; do (set -x ; d=`date +%s.%N` ; hg clone foo foo-$d; (cd foo-$d && date > bar && hg add bar && hg ci -m $d)); done
> for i in foo-*; do (set -x ; (cd $i && hg push -f)); done
> 

Here's how that would look in git (though I got rid of the timestamp
stuff and used seq instead):

git init foo
for i in $(seq 1 4000); do git clone foo foo-$i; (cd foo-$i && date > bar && git add bar && git commit -m "$i"; done)
for i in foo-*; do (set -x; (cd $i && git push master:$i/master)); done

The hg recipe creates 4000 branches which I for some reason can't
find the names of so I have no idea how to interact with them. The
git recipe names them explicitly to foo-$i/master in the foo/ repo,
since git doesn't allow pushing of commits without a ref.


Having read further in the thread, I see you did "hg merge" to merge
*all* the branches (which is impressive in itself, doing a 4000-way
merge), but I still don't see how you'd go about merging just one of
them. Perhaps that's not desirable.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
