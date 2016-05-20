From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Fri, 20 May 2016 16:19:25 +0200
Message-ID: <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
References: <nhlqd4$ekr$1@ger.gmane.org>
 <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
 <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jon Forrest <nobozo@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 16:19:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3lH5-0000aa-Sf
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 16:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbcETOTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 10:19:31 -0400
Received: from mout.web.de ([212.227.17.11]:62721 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947AbcETOTa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 10:19:30 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LwHxK-1bdil60hDi-017zOs; Fri, 20 May 2016 16:19:26
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
X-Provags-ID: V03:K0:0cNzLOwSYOk5nBXVmSIsRh8TJQg7/tEBOuJ6GQhDA/4vRkBsilv
 jgMlXVv/8L6RguZxCTQRbOA5LLp4XDuFc5p4qwDhAUJW01qOdfsXI0xExcHQFtQLkg5Xk+8
 +YmZ3Cu0Y/fDhcQv0C0uhxZrP44N1l64rOaCe0E1aY3bcJEp3ab3UUydI4+nrQp0rwb7iiz
 b74hD6VALXFW5tQzntS6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DwSyttQaPhY=:NwS6pk9056RjoyFI94ax0R
 rAWhql4D6g4QyOIaclkscjXon3hU5w72DWKupEUqtgqYbbjgW4hdfYSpvsmnAoRPBd4ZA4eMx
 LGdXxu+yikJRVIopniwUsZFPEN71gb6Z8WaxEwhRgr4rJw+dutM6hFoFQ0ukguAbYJgRl9qip
 wzVzyTQQ3lD1yuVG3/oSOYPjTcJci3hMl+ULh2Tm3jRabx/YbhlTWkzDvMFDT2xv5z3YhB/N4
 ccUfME3G1t03CXGQrwPZg69quVvBViL+nYqTNjsItG3l+g8YOqGFtKfCdQpGBp27Wy4w9eO0n
 SSJWcz5CaZq28nIxItOU8aErVG1UNEnP78kqvHahvmN3lBcXJgr+Z3XOs+ZCUwjOsQ7AzwhJn
 8H5O7Oy6GAEN4xkFZQ6Wyn5dfuxlI4phmKXdi6yuXvCBX/yCd5e+lQ7s2avJHmq7Ejzyel0lT
 CQ5snYhVo29p/gfbRyB6FsZlmnAEVC4v8ROrt46ipX2W/Ol2y4wJr3beqOIWE0i7BPCQQ2crS
 qfjfNRynrtZ/dpk1L8EkGaoJ911IqD25mnV85NQj01S/v34BwYXxv93Ls5cOibJkOSHdeYYUB
 c/CttebtR/zjzggI7mvL/3gy8dhofUWRaS1e4+0REyBqqwHjjpyf2gVKXYatxuugjSUo7uU5+
 SrDX+wVy7vLg9ob57FaOSYNlcrUqZUgZLBhNUnWJ6pL0MFohxSnUqXQy70jubJTUcU3zjrYXQ
 TyipjYvqWkoXwG6WA5X2XXJJsqzHWewv3Sgt//hLKcp/tOfcusDlMaOeCrbxzckGb8AKHnHE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295167>

On 20.05.16 15:48, Jon Forrest wrote:
>=20
>=20
> On 5/20/2016 6:19 AM, Torsten B=C3=B6gershausen wrote:
>> On 20.05.16 03:48, Jon Forrest wrote:
>>> I'm running Git version 2.8.2 built from source on Ubuntu 16.04.
>>> I'm using a repository that's stored on Dropbox. I'm the only perso=
n
>>> accessing this repo. Everything works great.
>>>
>>> For reasons unrelated to Git, I decided to try Git for Windows,
>>> so I installed "git version 2.8.2.windows.1" on Windows 10.
>>> When I run 'git status' on Ubuntu the list I see is exactly what
>>> I expect. However, when I run 'git status' on the
>>> same Dropbox repo on Windows, I see what I expect plus I'm told
>>> that every .pdf file and some .png files are modified.
>> To bring at least a little light into the story:
>>
>> What does
>> git diff
>> say ?
>=20
> Great question. For all the unexpected files it says the
> same thing:
>=20
> old mode 100755
> new mode 100644

So the solution is to run
git config  core.filemode false
