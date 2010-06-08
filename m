From: demerphq <demerphq@gmail.com>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Tue, 8 Jun 2010 10:18:59 +0200
Message-ID: <AANLkTinCq1lzD8_RTQVKOcEkDh_Yw41WXpYQsJVgkJRn@mail.gmail.com>
References: <20100605110930.GA10526@localhost>
	<vpqljas5e33.fsf@bauges.imag.fr>
	<20100606164642.GA10104@localhost>
	<buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
	<20100607185439.GB17343@localhost>
	<vpqzkz6fy9m.fsf@bauges.imag.fr>
	<20100607193226.GA19789@localhost>
	<4C0DFA55.8070800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 10:19:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLu1l-0006yG-PV
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 10:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab0FHITJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 04:19:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61869 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab0FHITB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 04:19:01 -0400
Received: by fxm8 with SMTP id 8so2652567fxm.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xATMV0fNrTVoO2E8OA3cvvQRH9LhWv95MrdpqWQwjJo=;
        b=rnYdgx3xTi5n4XM+GSJmDfAE/vPfUboHhirTqBMcjSreFJprdlG5zxzPUwF/yu/7Ha
         u4dAjtIjo76aWWviO9JdjFhlqZu7sHzHoKXNvsa/hgSz5eH0GOZxw33W+8UPFyaNnEgs
         xi8rIijCzxp5bF8jn0SurhlLb0YFOoeaqZe7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mUtOeAtSeOsePPXQtJ4q+3f24zwqM6flM8WdOE4YOh/ZNEAqD/hv0g1DK/5AAFepEt
         U41UuBJa1WbZXM5eGbHqvkPgSBtJLePPsCYxO8/w46WKYWTqi1411lKj4ZDUq7jooLol
         EjeGHrWHgaXkLP3+mBciqLPeNK2LCwpaVnXh8=
Received: by 10.239.193.141 with SMTP id j13mr1099245hbi.69.1275985139675; 
	Tue, 08 Jun 2010 01:18:59 -0700 (PDT)
Received: by 10.239.143.140 with HTTP; Tue, 8 Jun 2010 01:18:59 -0700 (PDT)
In-Reply-To: <4C0DFA55.8070800@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148654>

On 8 June 2010 10:07, Michael J Gruber <git@drmicha.warpmail.net> wrote=
:
> Clemens Buchacher venit, vidit, dixit 07.06.2010 21:32:
>> On Mon, Jun 07, 2010 at 09:17:25PM +0200, Matthieu Moy wrote:
>>> Clemens Buchacher <drizzd@aon.at> writes:
>>>
>>>> But this is supposedly a feature which helps users who type "git
>>>> checkout <branch>" by mistake, when they really wanted to do "git
>>>> checkout -t <remote>/<branch>".
>>>
>>> Not sure what's the argument here, but aren't the two commands
>>> equivalent? Do you prefer the second syntax "git checkout -t
>>> <remote>/<branch>"? It's already a DWIM for "git checkout -b <branc=
h>
>>> -t <remote>/<branch>", and I find this one far more confusing:
>>>
>>> git checkout =A0 =A0<remote>/<branch> =3D> detaches HEAD
>>> git checkout -t <remote>/<branch> =3D> creates a local branch autom=
atically
>>
>> The intent with -t is clear. It is used only when you create a new
>> branch. Also, you specify the remote branch you're going to create
>> a new branch from.
>>
>> "git checkout <branch>", on the other hand, will create a branch
>> based on a remote branch, even though you neither asked for a new
>> branch, nor did you specify any remote at all.
>
> You're making a very important point here:
>
> The existing DWIMery executes *different commands* depending on the
> circumstances (<branch> existing or not). "checkout" and "checkout
> -t/-b" really are different commands.

"checkout a branch" is the command. The rest is just bookkeeping.

Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
