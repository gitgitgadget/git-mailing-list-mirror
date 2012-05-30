From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv3 1/2] wt-status.*: better advices for git status added
Date: Wed, 30 May 2012 13:09:14 +0200
Message-ID: <20120530130914.Horde.CK7IZHwdC4BPxf-ak9fkbPA@webmail.minatec.grenoble-inp.fr>
References: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7v4nqy4wrz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 13:09:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZgmI-0000rz-OB
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab2E3LJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 07:09:18 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:46235 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752687Ab2E3LJR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 07:09:17 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id EC90B1A02F3;
	Wed, 30 May 2012 13:09:14 +0200 (CEST)
Received: from wifi-028110.grenet.fr (wifi-028110.grenet.fr
 [130.190.28.110]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Wed, 30 May 2012 13:09:14 +0200
In-Reply-To: <7v4nqy4wrz.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198800>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>>  		Advice shown when you used linkgit:git-checkout[1] to
>>  		move to the detach HEAD state, to instruct how to create
>>  		a local branch after the fact.
>> +	statusHelp::
>> +		Directions on how to end the current process shown
>> +		in the output of linkgit:git-status[1].
>> +
>>  --
>
> Have you read the existing entries in the same section you are
> touching to see if the patch result as a whole makes sense and the
> new entry fits well in the context?
>
> It strikes me odd that this is not listed next to statusHints, and
> it also makes me wonder if we even need to invent a new one, or it
> is better to just make the output more verbose when statusHints is
> not being declined.

Yes, we first thought that we could use statusHints to protect the
new messages warnings. But users that disabled statusHints and still
wished to know what to do during am/rebase/bisect etc. won't be
able to. On the other hand, if they want to hide the new advices, they
can see in the doc the presence of the advice.statusHelp and disable it=
=2E
