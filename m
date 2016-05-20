From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Fri, 20 May 2016 15:19:49 +0200
Message-ID: <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
References: <nhlqd4$ekr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 15:20:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3kLb-0000YI-6R
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 15:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbcETNUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 09:20:03 -0400
Received: from mout.web.de ([212.227.15.3]:53480 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777AbcETNUB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 09:20:01 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LbrTY-1bTDBo2yJg-00jHmY; Fri, 20 May 2016 15:19:56
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <nhlqd4$ekr$1@ger.gmane.org>
X-Provags-ID: V03:K0:6Zl+/buXDeQmCG6hHVcIyscW1mXiOU5WfCVg8i4m/JPSawEURvD
 QpeyiVqMd8dhhrh046J3/sqIhNCUM7PbEam4mWcq1opjnhnjaiGc0R0PsX7fJtVOFtWzcE4
 KMYPUhPY2Jlef/Qj+5LsmtHGl9Yii6C7MQNCGvYk9gaE+CtUku9Pi0HwGm4dmu6NhJg2FPL
 eY9+pNgizMEN7zmaMK9Ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gli1MNEMY9M=:avk6vEtG+OIhcPTwbreO28
 14rPZMYVVhoF5MF+2c0Cy92pBov/JE1l+2yHMkdQlAh3C93dx4xUXIqKIvi7GgXrd+y9SoO5N
 GkhG8yh10zu74rzoqfPuUAAqa6o7iWr80oPTS/VR8pKr1tfDraDjd8fTSMSwtHQCM9Ar+pjys
 DwNuAFUcduh1xjpLHhBgKdabgxlWzaPpJc4wehlj71j/KjdeawILSPFSkp6hBb4FfrF8VhXSy
 R5Xrx7e8Tzb5i5KgiYQkLkMXzIhKSPoBhcigtyFvywyd6SdvmnUPVgCuJp3yDRTY7v7GqyHZg
 AMdIMLIU6QKapjSKu8TMcyhzsHRzqXcCYtRswPpkEX6fZFIraRrpZBolpc7GhsSXGD388qC4a
 /3l8bo0F5+XL5c+EOG5t1XNycwqZp39Gm8GyxlpZS0zOpP93/9wSW20IkqY6WkSf2nHdmd3ti
 u0PIvl9E+V9P7R8BaWios2o8KZorULzZZj4ULGm1fv3H2J6SBMudM1kJ8YcscCp7SQiAndqFD
 Yo+iKWuwOEVB04y4Hh/IYT4FlQJ78/QoajGIlXpV0tHgGjgCJjaxK9Nh1vYaKswh4BQ0oBFtZ
 JrR4AOp853yGzyA0kDy8w2YZ83iVvyx13Mdw1S7ywe8n4uvVl694f5qnkg0eCCKtgTTI5MVp8
 5TO/wcL6eOEVeq9h+5lBXlpBhIw/ER+c6bAPrAS0xVmUYZ+P7Z4a50UuTry9X0gkOQVaNY1Uh
 5n5KtMCdo9spwiWerd//jcBn3QTpOFFlQj3zG0sblLrPOulociz4Dnlk0peC+kE7e71SSMrp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295163>

On 20.05.16 03:48, Jon Forrest wrote:
> I'm running Git version 2.8.2 built from source on Ubuntu 16.04.
> I'm using a repository that's stored on Dropbox. I'm the only person
> accessing this repo. Everything works great.
> 
> For reasons unrelated to Git, I decided to try Git for Windows,
> so I installed "git version 2.8.2.windows.1" on Windows 10.
> When I run 'git status' on Ubuntu the list I see is exactly what
> I expect. However, when I run 'git status' on the
> same Dropbox repo on Windows, I see what I expect plus I'm told
> that every .pdf file and some .png files are modified.
To bring at least a little light into the story:

What does 
git diff
say ?

What does 
git config -l | grep core
say ?

And what does
git ls-files --eol
say?
