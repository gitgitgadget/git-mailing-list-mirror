From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC/PATCH 8/8] user-manual: simplify the user configuration
Date: Mon, 23 Mar 2009 01:07:03 +0100
Message-ID: <984D312E-12B8-4A8C-B567-EF5AF1DDD3D6@wincent.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-9-git-send-email-felipe.contreras@gmail.com> <0A3F8ECD-EEFA-4DB0-AFED-AEE7DAFE8DB3@wincent.com> <94a0d4530903221601hb3bf8aelf98b22ee560dfb7b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:08:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlXii-0001Mp-60
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 01:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbZCWAHM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 20:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbZCWAHL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:07:11 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:48056 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbZCWAHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 20:07:09 -0400
Received: from cuzco.lan (207.pool85-53-9.dynamic.orange.es [85.53.9.207])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2N073vn018175
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 22 Mar 2009 20:07:05 -0400
In-Reply-To: <94a0d4530903221601hb3bf8aelf98b22ee560dfb7b@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114208>


El 23/3/2009, a las 0:01, Felipe Contreras escribi=F3:

> On Mon, Mar 23, 2009 at 12:42 AM, Wincent Colaiuta <win@wincent.com> =
=20
> wrote:
>> El 22/3/2009, a las 19:05, Felipe Contreras escribi=F3:
>>
>>> This is shorter, avoids the burder to think about the format of the
>>> configuration file, and git config is already used in other places =
=20
>>> in
>>> the manual.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>> Documentation/user-manual.txt |    8 +++-----
>>> 1 files changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/user-manual.txt b/Documentation/user-=20
>>> manual.txt
>>> index b7678aa..c6ed940 100644
>>> --- a/Documentation/user-manual.txt
>>> +++ b/Documentation/user-manual.txt
>>> @@ -1015,13 +1015,11 @@ Telling git your name
>>> ---------------------
>>>
>>> Before creating any commits, you should introduce yourself to =20
>>> git.  The
>>> -easiest way to do so is to make sure the following lines appear =20
>>> in a
>>> -file named `.gitconfig` in your home directory:
>>> +easiest way is to use the linkgit:git-config[1] command:
>>>
>>> ------------------------------------------------
>>> -[user]
>>> -       name =3D Your Name Comes Here
>>> -       email =3D you@yourdomain.example.com
>>> +$ git config --global user.name "Your Name Comes Here"
>>> +$ git config --global user.email you@yourdomain.example.com
>>> ------------------------------------------------
>>>
>>> (See the '"CONFIGURATION FILE"' section of linkgit:git-config[1] fo=
r
>>> --
>>> 1.6.2.1.352.gae594
>>
>> See this lengthy thread:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/106634
>
> I've obviously seen that thread because I started it.

Yeah, I noticed that only after sending my message. I hadn't realised =20
at first because the patch really looked like it was written by =20
someone who hadn't ever seen the thread, as it doesn't address the =20
points raised in the thread at all.

> Can you write more than one line to explain your point?

I was thinking mostly of Junio's comments:

http://article.gmane.org/gmane.comp.version-control.git/106667

'I am moderately against changing this part to use "git config". We =20
traditionally introduced how to set configuration variables first by =20
editing it in an editor, and this was quite deliberate, in order to =20
show how the configuration file looks like, to demonstrate that there =20
is no deep magic in the file format, and to explain that it is =20
perfectly Ok to edit it without using "git config" command. I actually =
=20
wish this section appeared a lot earlier in the document, but
that is a separate issue.'

If you expect him to apply your patch, you'll probably want to address =
=20
those concerns (and possibly others raised in referenced thread) in =20
the commit message.

Cheers,
Wincent
