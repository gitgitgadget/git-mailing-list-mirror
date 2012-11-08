From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 08 Nov 2012 10:42:03 +0100
Message-ID: <509B7E6B.1030407@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:42:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWOd0-00009J-Sf
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 10:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab2KHJmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 04:42:11 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:57737 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751267Ab2KHJmI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2012 04:42:08 -0500
X-AuditID: 1207440c-b7f616d00000270b-b2-509b7e6f0ff4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DD.54.09995.F6E7B905; Thu,  8 Nov 2012 04:42:07 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA89g4Sw031520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 8 Nov 2012 04:42:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsUixO6iqJtfNzvAoHG/jcXxp9dZLNY+u8Nk
	0XWlm8miofcKs8Wlz+tZLRqfFFmsfnyH3eL92f/MDhweO2fdZfeY+OU4q8fFS8oenzfJeRy4
	/JgtgDWK2yYpsaQsODM9T98ugTuj7dpvxoL/QhXHV01mamBcxd/FyMkhIWAiMXt+AxuELSZx
	4d56IJuLQ0jgMqPEr5a5rCAJIYFjTBKLXhuB2LwC2hJnfxwAi7MIqEosufySCcRmE9CVWNTT
	DGaLCoRJrNlziAmiXlDi5MwnLCC2iIC7xNe/q5lAFjALHGKSOLZxBViRsICzxMo5O5ggNq9g
	lGh69hwswSkQKHHz1m2gkziAOtQl1s8TAgkzC8hLNG+dzTyBUWAWkh2zEKpmIalawMi8ilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMk/Hl2MH5bJ3OIUYCDUYmHV4hldoAQ
	a2JZcWXuIUZJDiYlUd5D1UAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzLnIFyvCmJlVWpRfkw
	KWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJ3pxaoEbBotT01Iq0zJwShDQTByfIcC4p
	keLUvJTUosTSkox4UKTGFwNjFSTFA7T3XQ3I3uKCxFygKETrKUZ7jqNv5j5k5PjYOA9IXtq/
	EEg2dCx6yCjEkpeflyolzisDslUApC2jNA9uKSwhvmIUB4aBMK8vSBUPMJnCzX4FtJYJaG3x
	tRkga0sSEVJSDYySJ65Zmfgf/r1ElXdTVovbc4fTHYfZd9Q1y8ZsT1G7sN2vYNuN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209151>

On 11/07/2012 10:47 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Jul 20, 2012 at 12:01 PM, Michael Haggerty <mhagger@alum.mit.=
edu> wrote:
>> On 07/14/2012 08:59 AM, mhagger@alum.mit.edu wrote:
>>>
>>> Add a new Python script, contrib/hooks/post-receive-multimail.py, t=
hat
>>> can be used to send notification emails describing pushes into a gi=
t
>>> repository.  [...]
>>
>>
>> Thanks to everybody for your feedback.  I will try to incorporate it=
 in a
>> new version of the script, which I will put forward as a replacement=
 for
>> contrib/hooks/post-receive-email rather than as an alternative.  But=
 I have
>> very little open-sourcing time these days, and will be on vacation n=
ext
>> week, so please be patient (or feel free to lend a hand if you are s=
o
>> inclined).
>=20
> I'm curious as to whether you got around to this? I'd be interested i=
n
> updates on this script.

Thanks for asking.  I have made many of the changes that were requested
and/or I had planned:

* Tentatively renamed the system to git-multimail

* Store the configuration in namespace "multimailhook.*" instead of
"hooks.*".

* Reinstated (optional) support for including shortlogs since the last
tag in announce emails.

* Script to migrate post-receive-email configuration to the equivalent
git-multimail config.

* Better documentation (including of the migration process).

* Made it easier to use Python code to customize the script's behavior
(by allowing it to be imported as a Python module), plus a demo script
showing this usage.

* Some primitive testing tools to generate a test git repository and
generate many kinds of notification emails (though the emails still hav=
e
to be checked manually for correctness).

But I haven't submitted the new version because I just haven't had a
good block of time to really wrap it up and call it a "final" version.
One remaining question is how to fit it into the git source tree along
with its supporting materials (or even whether to maintain it as a
separate project).

Nevertheless I think that the script is quite usable as it is and it
would be great if other people could try it out, give feedback, and eve=
n
submit patches.

So I just created a github repository containing my current version:

    https://github.com/mhagger/git-multimail

Enjoy!

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
