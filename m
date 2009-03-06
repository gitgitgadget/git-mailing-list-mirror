From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or  configured
Date: Fri, 06 Mar 2009 07:27:35 -0800 (PST)
Message-ID: <m3mybyisa1.fsf@localhost.localdomain>
References: <20090305221529.GA25871@pvv.org>
	<fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>
	<200903052322.02098.markus.heidelberg@web.de>
	<200903052325.44648.markus.heidelberg@web.de>
	<fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
	<alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de>
	<7v4oy7szze.fsf@gitster.siamese.dyndns.org>
	<20090306114812.GA19534@pvv.org>
	<43d8ce650903060426y776474fi10acc5495b88fa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 16:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfbz3-0005St-UX
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbZCFP1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 10:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbZCFP1l
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:27:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:14016 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZCFP1k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 10:27:40 -0500
Received: by fg-out-1718.google.com with SMTP id 16so552597fgg.17
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=e7btQryL9O+8CTxmYipSYaKKmQ96bQpiMlGLX55ving=;
        b=bcZoRZfzwV7j9kIbJ28Qt6bgnFaAu0AWeuxeGuogZKzXXwjM2WW+pg7PW1dy3Zhps6
         mh4MaYtblffy5in4k5CqEppHh92nhaZI5ofghZ/HYcNMoTyNXl2xJysAIizWm+CB47o0
         bPWzBT5N9XPhU++JFn582xA/BRPCX4CZifhoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=C34qBHkvMdNbo2zM/hFse9eO5MvJk+RApqjTsiS/7K9Jq0Ec9uYlKCVJHf1YgjhP0j
         B16nNEKUGB1xBDBNtGBf9siALD4QXeC9DGeexe2zjU5CvUQNsVzPbdlJvValyDd2ytiQ
         eLZG02IvHderevm1nLi0qOsBhX3MRHGExCne4=
Received: by 10.86.53.8 with SMTP id b8mr1964372fga.10.1236353256992;
        Fri, 06 Mar 2009 07:27:36 -0800 (PST)
Received: from localhost.localdomain (abwf107.neoplus.adsl.tpnet.pl [83.8.229.107])
        by mx.google.com with ESMTPS id 4sm826491fgg.56.2009.03.06.07.27.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 07:27:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n26FTU1O021349;
	Fri, 6 Mar 2009 16:29:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n26FTQn0021346;
	Fri, 6 Mar 2009 16:29:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <43d8ce650903060426y776474fi10acc5495b88fa7@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112448>

John Tapsell <johnflux@gmail.com> writes:
> 2009/3/6 Finn Arne Gangstad <finnag@pvv.org>:
>> On Fri, Mar 06, 2009 at 02:32:53AM -0800, Junio C Hamano wrote:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>> On Thu, 5 Mar 2009, Sverre Rabbelier wrote:
>>>>
>>>>> On Thu, Mar 5, 2009 at 23:25, Markus Heidelberg
>>>>> <markus.heidelberg@web.de> wrote:
>>>>>> Oh, I confused "config option" with "command line argument"...
>>>>>
>>>>> Right, I'd like to be able to do:
>>>>> $ git config push.iamnotretarded true
>>>>> $ git push
>>>>
>>>> LOL! =A0Sverre, you have a way to crack me up...
>>>
>>> I found it amusing, too.
>>>
>>> It may have some correlation with how well organized your work habi=
t is,
>>> but I do not think it has much correlation with being retarded. =A0=
It is
>>> more about "'matching refs' is the perfect default for _my_ use pat=
tern,
>>> don't mess with it, please".
>>
>> So here is my current WIP suggestion for a new "push.default"
>> variable, I am not sure if a single entry can express all useful
>> choices, or if it is a good idea to introduce more default choices
>> other than "nothing" (with the goal of making it the default in a
>> later release).
>>
>> I think all the values here make sense as a --option to git push
>> though (except --nothing...)
>>
>> Suggested new entry in config.txt:
>>
>> push.default::
>> =A0 =A0 =A0 =A0Defines the action git push should take if no refspec=
 is given
>> =A0 =A0 =A0 =A0on the command line, no refspec is configured in the =
branch, and
>> =A0 =A0 =A0 =A0no refspec is implied by any of the options given on =
the command
>> =A0 =A0 =A0 =A0line.
>> +
>> =A0 =A0 =A0 =A0The term `current remote` means the remote configured=
 for the current
>> =A0 =A0 =A0 =A0branch, or `origin` if no remote is set. `origin` is =
also used if
>> =A0 =A0 =A0 =A0you are not on a branch at all.
>> +
>> * `nothing` do not push anything
>> * `matching` push all matching branches to the current remote.
>> =A0All branches having the same name in both ends are considered to =
be
>> =A0matching. This is the default value.
>> * `same-remote` push all matching branches that are configured to us=
e
>> =A0the current remote. Branches with no remote configuration are not=
 pushed.
>> * `tracked` push all branches that are tracking a branch on the curr=
ent
>> =A0remote to their counterpart.
>=20
> How about 'current', to simply push the current the branch.  It could
> even prompt if it's not tracked yet.

Note that if you have configuration for <remote>, you can simply add
"remote.<remote>.push =3D HEAD" for pushing current branch only, and
"remote.<remote>.push =3D :" for current matching behavior.  Perhaps
"remote.<remote>.push =3D " works for push nothing?
=20
> Most (all?) other revision control systems have this 'current'
> behaviour by default.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
