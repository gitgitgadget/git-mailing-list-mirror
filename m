From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 10:04:52 -0400
Message-ID: <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGbIX-0003xv-7A
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 16:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbXHBOFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 2 Aug 2007 10:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbXHBOFA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 10:05:00 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:46421 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752532AbXHBOE7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 10:04:59 -0400
Received: (qmail 46088 invoked from network); 2 Aug 2007 14:04:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=P7CfmftgSNQDZfsUO8mf112O7QQ2T101v95YxoIfesuMxcsYDNydnKAd46zJ9gH5tWdUBzOhzK2fvmcBBTUY8vCXlMvzo41vH9vPMI4z4V/l/zcXYbMl9Cl00Fi7mdAMYMn0Z+sb6zjIPEov2x+VbUJahXr1IzFBjqwoSe6rNMg=  ;
Received: from unknown (HELO ?192.168.3.33?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp110.mail.mud.yahoo.com with SMTP; 2 Aug 2007 14:04:56 -0000
X-YMail-OSG: xgRSKpgVM1mgnfo7JEXfZyFxVcroPUK77UHDImL4ujeA50hfOqnnjezm.nYCeqvCqnFSahiPcA--
In-Reply-To: <Pine.LNX.4.64.0708021147110.14781@racer.site>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54551>

I find comments like this to be counter productive.
Admin it, git porcelain still has some work to be done.  We can't =20
expect new users to know the git internals workflow before they can =20
use git effectively.  We can expect new users to read the man pages, =20
but not necessarely expect them to understand all the plumbing =20
implied by what they read.  Here I think M.Moy understand the =20
plumbing and could silently deal with it.  But instead he decided to =20
help improve git and decided to raise a flag about inconsistencies he =20
faced.  We should never answer request for improvement with ' Just do =20
X and be done with it'.  This is a 'geek' answer to a legitime comment.

I know the goal of git is not to reign over the world of vcs, but =20
it's not a reason to refuse to improve it when constructive comments =20
are made about it.

- jfv

Le 07-08-02 =E0 06:48, Johannes Schindelin a =E9crit :

> Hi,
>
> On Thu, 2 Aug 2007, Matthieu Moy wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Thu, 2 Aug 2007, Matthieu Moy wrote:
>>>
>>>>> If the feature still makes sense in the modern world is a
>>>>> different story, but I do find it useful.
>>>>
>>>> I understand that it can be usefull, but I really don't like =20
>>>> having it
>>>> by default (is there a way to deactivate it BTW?).
>>>
>>> Yes.  Just call "git status" and be done with it.
>>
>> That's not what I mean (my original message mentionned that already
>> BTW). By "deactivate", I mean "make git-diff never show empty diffs"=
=2E
>> I don't want to run two commands where I need only one.
>
> Then don't touch the files you do not want to touch!  Or if you =20
> want to
> have it convenient, and have a script that touches everything, even =20
> if it
> does not change the contents, just add "git add -u" at the end of the
> script".  Not that difficult.
>
> Ciao,
> Dscho
