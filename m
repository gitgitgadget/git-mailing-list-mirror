From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Thu, 28 Apr 2016 08:09:20 +0200
Message-ID: <09EB11F9-5254-4D03-BDBA-FD1C1B191F07@gmail.com>
References: <E230B4FD-79B5-4CA7-9F0D-A4F8F3470296@gmail.com> <20160425162502.31558-1-szeder@ira.uka.de> <xmqq8u01mwji.fsf@gitster.mtv.corp.google.com> <20160426011056.Horde.yl47nWMpVGsuGDgrKiKb_nR@webmail.informatik.kit.edu>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Woosley <Ben.Woosley@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	Git Users <git@vger.kernel.org>
To: =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 28 08:10:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avf9H-0002h4-63
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbcD1GJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2016 02:09:25 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38845 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbcD1GJZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 02:09:25 -0400
Received: by mail-wm0-f46.google.com with SMTP id g17so22986149wme.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=joctkNLrJmuDz1pN2v34MXBUNTp1nIjn6DlX0xYioVw=;
        b=tuwy+IoLo2wdS5PqxXT552zSbvxSiFLYuJ/NwpcKfi2AftJbSPLfZ1WfqCQSmrWZh1
         LDh3ezA0GRl5KcsqejK8w9rTgDhYxk6eH7mzRSHplwEXFn/U3a3Ehxg31C+6X+LZC3pJ
         WwQcx9saYb2xPyCgIsvctIB+ZSkOcFhiWJ8iCjvtJviUM+i787iU/wU9j2CRhzzV1qU4
         PhRMl34IsOcgBvlruDb5WSzUI/WJNnrhrTH3xxeN6Il41z3nZvZFLWWf07uMuhB5LPu7
         6s5atOn4Zclo0iYmNIKfwyZyQW0EGEH2D2S/WpaRWS0qc2IDHQEtvERj/b1kVorG2zXn
         xT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=joctkNLrJmuDz1pN2v34MXBUNTp1nIjn6DlX0xYioVw=;
        b=egR+F6nXDtoItpMkJC9+U7B2kIq8U/EoPVb3T6oCRJybf0l0bbBb1XEqmPYEH8mBD9
         P/tcxlcbFyq5ZsnMBbCkGEilkUKNp41qBJa8eSW/4qHeU3Ak1ocB8dVyuSRibZHTxdXq
         2tAnpIagViTF54F3/XsAiaUDfew6N1vJOQ785XF//5ozkOTWl1rwXX9j+i3F1cc/dJ9T
         pUaVmX2ofLhJXWjKk0hig7SV6OX9QZWVp7J/iIPlKP70ta/vWVk5cW/DXf+IPGJDcAw9
         X6J6xXc3gfbr5b9sKuu7KpJq5DuCp/3AWchU2gnfNSgM4i9v1bu1pDzpuWcdUJOsDMKR
         yseg==
X-Gm-Message-State: AOPr4FU3P/J2nhBkdV/LubtZN+/mVuwoPTmsGcqkBeSpdkSIqkBzW5NuMwiV1oFcqsU7QQ==
X-Received: by 10.28.25.67 with SMTP id 64mr28980591wmz.10.1461823763226;
        Wed, 27 Apr 2016 23:09:23 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BAD07.dip0.t-ipconnect.de. [80.139.173.7])
        by smtp.gmail.com with ESMTPSA id d79sm33088409wmi.23.2016.04.27.23.09.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 23:09:22 -0700 (PDT)
In-Reply-To: <20160426011056.Horde.yl47nWMpVGsuGDgrKiKb_nR@webmail.informatik.kit.edu>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292844>


On 26 Apr 2016, at 01:10, SZEDER G=E1bor <szeder@ira.uka.de> wrote:

>=20
> Quoting Junio C Hamano <gitster@pobox.com>:
>=20
>> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>>=20
>>> You can have a look at these patches at
>>>=20
>>>  https://github.com/szeder/git completion-test-multiple-bash-versio=
ns
>>>=20
>>> and perhaps you could even adapt it to LFS and/or p4 somehow.
>>>=20
>>>> Plus if we want to be consistent we would
>>>> need to do the same for LFS 1.0, 1.2, and for pretty much every ot=
her
>>>> dependency...
>>>=20
>>> I'm not sure we should be consistent in this case, at least not sol=
ely
>>> for consistency's sake and not in git.git. Taking what I did for Ba=
sh
>>> and doing it for different versions of LFS, p4, etc. could perhaps
>>> keep the runtime under control, but t/Makefile would surely get out
>>> of control rather quickly.  Putting these into a travis-ci matrix i=
s
>>> so much simpler, but the runtime makes it infeasible, of course.
>>=20
>> I took a brief look of your branch, and I like its approach.  If I
>> understood your approach correctly, you:
>>=20
>> * Group selected tests in t/ as "these are bash related tests I
>>   care about" in t/Makefile;
>=20
> Yes.
>=20
>> * Add Travis test target to build Git with specific versions of
>>   bash, and run the above target instead of the full test to
>>   exercise the version of bash you are testing.
>=20
> Not quite.
>=20
>  * Add t/Makefile targets to run a Bash-related test script with a
>    specific Bash version, one target for each script-version pair,
>    and a target to run all Bash-related tests with all listed
>    Bash-versions.
>=20
>  * Extend the travis-ci config so that, after building Git as usual
>    and running the full test suite as usual, it additionaly runs all
>    Bash-related tests will all listed Bash versions on Linux builds.
>=20
>> And I agree that the same can be done for LFS versions and P4
>> versions.  Only a handful tests in t/ are about these niches.
>=20
> Luckily for me, running a test script with a specific Bash version is
> as trivial as '/path/to/bash-vX.Y t9902-completion.sh'.  No
> modifications to the test scripts or to lib-bash.sh were necessary.
>=20
> OTOH, Git LFS and p4 tests, AFAICS, rely on git-lfs and p4 binaries
> being available in $PATH, and the p4 tests need two binaries.  So
> there is more work that has to be done, as we would need a way to
> override those binaries found in $PATH, either through an environment
> variable or a command line option.  Bonus points for a solution that
> would work equally well with LFS, p4 and Bash: then perhaps we could
> have a single unified block of Makefile metaprogramming, which could
> generate  all those test targets from a list of dependency-specific
> tests and a list of paths to different versions of that dependency.
> Then it might even be suitable for inclusion in git.git.

Thanks for sharing this! It's awesome! I will try to find a generic
solution based on your work that handles bash versions, LFS versions,
and P4 versions! Stay tuned :-)

Cheers,
Lars

>=20
>=20
>>> I think the best we can do is to keep this out of git.git and let
>>> (hope?) developers interested in a particular subsystem do this
>>> "multiple version compatibility" tests as they see fit.
>=20
>=20
