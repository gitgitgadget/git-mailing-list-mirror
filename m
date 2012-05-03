From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 11:58:45 -0700
Message-ID: <4FA2D565.1080806@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>	<4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com>	<86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com>	<86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com> <CAMP44s2h4EY3Qu2+Ys_n3TUzmyykMkG-wMoqmKg5hjg24JQ+bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 20:58:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1Eq-00054t-DK
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 20:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198Ab2ECS6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 14:58:48 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:49287 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175Ab2ECS6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 14:58:47 -0400
X-IronPort-AV: E=Sophos;i="4.75,526,1330934400"; 
   d="scan'208";a="13294498"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 03 May 2012 11:58:47 -0700
Received: from fuji.noir.com ([10.100.2.12])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q43IwkMO027440;
	Thu, 3 May 2012 11:58:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAMP44s2h4EY3Qu2+Ys_n3TUzmyykMkG-wMoqmKg5hjg24JQ+bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196940>

On 5/1/12 16:30 , Felipe Contreras wrote:
> Show all the hg commands of what you are trying to do, and we can show
> you how you can achieve the same in git, but much more easily.
hg init foo
for i in `yes | head -4000`; do (set -x ; d=`date +%s.%N` ; hg clone foo 
foo-$d; (cd foo-$d && date > bar && hg add bar && hg ci -m $d)); done
for i in foo-*; do (set -x ; (cd $i && hg push -f)); done

--rich
