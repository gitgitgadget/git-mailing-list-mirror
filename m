From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git  log --grep=foo".
Date: Tue, 27 Jul 2010 17:40:50 +0900
Message-ID: <buohbjll3l9.fsf@dhlpc061.dev.necel.com>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTikGPMDvxQKjpKOBge8UwrC_GuC36_=C_tYR_ngr@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 10:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odfix-0005M8-TV
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 10:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab0G0IlO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 04:41:14 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:54708 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab0G0IlN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 04:41:13 -0400
Received: from mailgate4.nec.co.jp ([10.7.69.184])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o6R8esnU010891;
	Tue, 27 Jul 2010 17:40:54 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o6R8esi10013; Tue, 27 Jul 2010 17:40:54 +0900 (JST)
Received: from relay61.aps.necel.com ([10.29.19.64]) by vgate02.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
	id o6R8erT19593; Tue, 27 Jul 2010 17:40:53 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay61.aps.necel.com with ESMTP; Tue, 27 Jul 2010 17:40:53 +0900
Received: from dhlpc061 ([10.114.113.150] [10.114.113.150]) by relay51.aps.necel.com with ESMTP; Tue, 27 Jul 2010 17:40:53 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id A14DE124006; Tue, 27 Jul 2010 17:40:52 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <AANLkTikGPMDvxQKjpKOBge8UwrC_GuC36_=C_tYR_ngr@mail.gmail.com>
	(Sverre Rabbelier's message of "Tue, 27 Jul 2010 01:43:22 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151918>

Sverre Rabbelier <srabbelier@gmail.com> writes:
>> + =A0 =A0 =A0 } else if (!strcmp(arg, "--grep")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_message_grep(revs, optarg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
>
> This one makes a little less sense since to me '--flag' are always
> booleans, whereas '-m' can take an argument (such as '-m' from 'git
> commit'.

The fact that --grep requires the "=3D" is amazingly confusing if you'r=
e
used to standard GNU long-argument parsing (which many standard
utilities use, and which git's argument syntax is clearly modelled
after), where both forms are equivalent, and documentation typically
only refers to the "=3D" form, but implicitly allows the separate-args
form.

I'm continually getting tripped up by git's idiosynchratic argument
parsing, and it's nice to see it getting cleaned up a bit...

-Miles

--=20
The trouble with most people is that they think with their hopes or
fears or wishes rather than with their minds.  -- Will Durant
