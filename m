From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Add ls-files --eol-staged, --eol-worktree
Date: Mon, 19 Oct 2015 07:23:11 +0200
Message-ID: <56247E3F.40804@web.de>
References: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
 <xmqq4mhoatna.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, philipoakley@iee.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 07:23:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo2ut-0007ma-TR
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 07:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbbJSFXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2015 01:23:23 -0400
Received: from mout.web.de ([212.227.15.4]:51536 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbbJSFXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 01:23:22 -0400
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MdLcJ-1a6OqT2Ebb-00IXRo; Mon, 19 Oct 2015 07:23:18
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <xmqq4mhoatna.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:EsQvd5TYVmEg9DsgAHp13eo1U4I2ywy4RCV/Rn8dnFIvvf5Czo7
 lIUDC8U6TJ74NP99suIj8UtGKNa8OWThBawK50oex95Ol8vkuWX3G05/TDkP8rjCu1PFcTo
 KJ5Z3stJQdZpb9jHu+9hiJsonV3XTO/g9ZS4pYqKmR/+L5goG6fKgVODG4xIAhDwFRUBU0z
 2vPnS+GdoKYLJ34Wz/dXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZRz7bIpAzDg=:v0ZzEPwPgUkIwPGda4xh/M
 qXHVE1prIrZfk8uiNL+V+eU9tQLADGhb7eGjVpOdlms2OtwlCJDTwvzNMar0I9fW6f3+RnEFk
 rWuBzb9Nox0oEK1h3c+rpLy1x2IufJbHR6XxKZ61/LvCAOSK2Api4MbN6nDcYHkHnZPX0Wa/e
 D8x5p/m6/OfsUAS9dqNzIktl1zwagGGS7RoSkcf4oHWM3grakEgLUwEQW1vWBfdvCHC3dTKUO
 pT8Qzmijt6wdO4LLKaj39YtDvZDFJUSp9jJeUwCVr61QqUKIhJg3k5HAtSRdYutekq7Az43XZ
 uG9nvJCjOWsWrUTI97T0jiFT2uf20ggQOIk5Cz7MMdHzVBqITUJ4dL5ozKANBtlu6LeBoT4JB
 FSbknzjW37N75uqWJv2mgmHU7YHzxwy1W7pHin7P07c9/hBJJ+eJq4diCIcQTwSIr1FAtnvs1
 GEE1gMJ3k2Ma287WekG1E7tkrm5ngNFx2Dqr6I4dHxorjVWxtqFw+PQMZDAAIi9Wfk4Uz686P
 zhN0SSHTJwqnMYrdAS6CWozZR2/LXqKmvW7CoEJjWpQVet6cloNjUb+y6+HnJk9L/CiQS13fO
 A67t12o3IFhMcv9qOVH083At+32o3tfj4JzJNQZsBiTna24iPi8C7rZczFONr3lwOp7NFx35j
 S7+qbyeRIXShXhhS5kDBx66JYCSKmWl+yJUSjvjZorl1IBpiWHpgp+elE1yn9EL6bdgLozUCK
 gy84+pYCrvkLFzdnQ/tG21N6GXI3Yd84C/xQVavkqo/+KQ7zx/XCCGEE0roH33k1b+lrkaBl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279828>



On 18/10/15 21:00, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Make it possible to show the line endings of files.
>> Files which are staged and/or files in the working tree:
>>
>> git ls-files --eol-staged
>> git ls-files --eol-worktree
> Two unrelated (to the issues raised in other review responses)
> issues in the UI:
>
>   - While I can see how the new feature would be useful, I am not
>     convinced that it is a good idea to add it to ls-files.  Does the
>     option work well with other existing options like -s, -t, etc?
>     Does it make sense to combine it with other options like -m, -d,
>     etc?  I have this suspicion that "check-attr", "check-ignore",
>     etc.  may give a better model that fits this feature better,
>     i.e. "git check-eol".
>
(This should answer all comments, thanks everybody
@Erics Sunshine: Thanks for the review, dropped you from cc list becaus=
e web.de=20
can't find an MX record)


I like this idea:

binary
text
crlf
mixed
lf


----------------
$ git ls-files --eol-staged -s
  [snip]
  100644 981f810e80008d878d6a5af1331c89dc093c5927 0       txt-lf worktr=
ee.c

---------------------
$ rm  Documentation/RelNotes/2.7.0.txt
$ echo "/* */" >>builtin/ls-files.c
$ ls-files -m --eol-worktree
   empty    Documentation/RelNotes/2.7.0.txt
   txt-lf   builtin/ls-files.c
-----------------------
(The empty is a bug, thanks Eric)
------------------------------
$ ./git-ls-files --eol-worktree -t
[snip]
$ H txt-lf   zlib.c
-------------------------
My understanding is that the eol options work togther with the existing=
 option,
as long as it makes sense (but see below)

"git check-attr" will even report attributes for a file, that doesn't e=
ven exist.
"git ls-files is a command which by default operates on the staged area=
, unless=20
I mis-understand it.

And that is the main purpose:
Tell me how which line endings your staged files have, and I can tell y=
ou that=20
you may
consider to normalize these files because "git status", "git blame" con=
sider=20
these files as changed.

(From that point of view,
"git ls-files --eol" could be the way to report the staged eols.
But then users would ask:
but why can't you tell me what I have in my worktree ?

"git ls-files --eol-worktree" could be the answer (or "git ls-files -o=20
--eol-worktree" )

I was thinking about adding "git check-eol", but didn't want to introdu=
ce just=20
another command,
as the syntax and options (-z, -o -x -X) overlap much with ls-files

Is it the common understanding to add a new command is the best solutio=
n ?
