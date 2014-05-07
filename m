From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Big Java repositories to play with?
Date: Wed, 07 May 2014 16:08:28 +0200
Message-ID: <536A3E5C.4020008@gmail.com>
References: <CACsJy8ArsQMBA3hq92u-6N9MCLYBgTRa_NYDm3QKjmKq25__oQ@mail.gmail.com> <CACBZZX7STWGniKtn7yB=Ea6YVkHkzNW4CtLBxFHwr0JDWs3q+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 16:08:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi2WR-0001Gp-2n
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbaEGOIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2014 10:08:31 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51260 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaEGOIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:08:30 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so780087eei.33
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tOvrBC2LIOdq4pZCqREf1/Ud116De2CgVK8OnWEO2Wo=;
        b=q9Yoar6XYi6lHCPqzsF2+DS99HLN3LjyVD4GciyF+2JRLiZr12j/URXvZiIMJYj2WF
         L4kWCCUm1st90pbTD72E6ZVd8tKYbNY9FFdbjPpyhz3++zA8wFw9q7WG0cbCSra76TMH
         RP8dbGh+Mfp3SWNA2yP+pzDAFc1Dhikff8RQ29jhz2hSXB1u0i2MLZLJ8FoFtYFgQfa5
         FVK2ydcp+xuRcWluooL7rhR+yZjntPjWdHCzz9ppJQROBqiGLe0r3v1P2ozxRfDo92+V
         O431LD4LXcB4eqDOEGb95vxhxzZ55t4oRZDSQTrj6IpkjsaWCsR3aIsHvnh4UaWHIanm
         0Q4Q==
X-Received: by 10.14.127.197 with SMTP id d45mr17112183eei.59.1399471709004;
        Wed, 07 May 2014 07:08:29 -0700 (PDT)
Received: from [192.168.1.7] (ip-178-200-168-156.unitymediagroup.de. [178.200.168.156])
        by mx.google.com with ESMTPSA id 48sm46622602eei.24.2014.05.07.07.08.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:08:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CACBZZX7STWGniKtn7yB=Ea6YVkHkzNW4CtLBxFHwr0JDWs3q+Q@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248305>

On 07.05.2014 16:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, May 7, 2014 at 3:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> I need some big Java repos (over 100k files) to test "git status".
>> Actually any repos with long path names and deep/wide directory
>> structure are fine, not only Java ones. Right now I'm aware of
>> gentoo-x86 and webkit. Let me know if you know some others. I'm afra=
id
>> my Google-foo is not strong enough to search these repos.
>=20
> 1. Take a small repo with a small src directory
> 2. for i in {1..100}; do cp -Rvp src src-$i; done
> 3. git add src-*; git commit -m"bigger"
>=20
> For some value of 100 you'll end up with a big repo to test "git stat=
us" on.
>=20
> You just need lots of files to stat(), git status doesn't care about
> history, so there's no reason why you need to track down an existing
> large repository.

As you may have anomalies of one repo reproduced 100 times then,
it may be better to use 100 different projects?
There is http://gittup.org/gittup/ which is an entire linux distributio=
n
packed into one git repo, but all the individual
projects (kernel, nethack etc) are subprojects. Maybe instead of
having them as subprojects you could add all of them into one large rep=
o?

Also you could just do a git init in your home directory?
