From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using Transifex in git.git
Date: Wed, 15 Jun 2011 10:22:11 +0200
Message-ID: <4DF86BB3.4070906@op5.se>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com> <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com> <4DF74EEC.1050506@op5.se> <BANLkTikCB7t4DhCxjLT-JABsUuksPBhkLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 10:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWlMj-0001dE-1V
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 10:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab1FOIWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 04:22:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64274 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab1FOIWP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 04:22:15 -0400
Received: by fxm17 with SMTP id 17so215316fxm.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 01:22:13 -0700 (PDT)
Received: by 10.223.5.212 with SMTP id 20mr255854faw.40.1308126133323;
        Wed, 15 Jun 2011 01:22:13 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id q10sm79725fan.8.2011.06.15.01.22.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 01:22:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <BANLkTikCB7t4DhCxjLT-JABsUuksPBhkLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175811>

On 06/15/2011 09:33 AM, Ramkumar Ramachandra wrote:
> Hi Andreas,
> 
> Andreas Ericsson writes:
>> Historically, a translation for one language has been considered "one
>> logical change" in that respect. I think it's safe to assume that if
>> we want translators to stick around they shouldn't need to divide their
>> changes on a per-message or per-command basis. Especially since such
>> divisions wouldn't be very easy to do if all you've got to go on is
>> a pot-file.
> 
> Fair point.  How do we work around this?
> 1. Can we relax the requirements for contributing translations?  To what extent?

Probably at least a bit. It doesn't affect core functionality in any
way so it's unlikely it will cause bugs that requires deep diving in
the history, so changes needn't be so isolated and commit messages
are less important than for code changes.

> 2. It think one commit per edit-session per language sounds sane.

Yup.

>  If
> people just go around translating some random strings that they like
> (which is often the case), what is the sense in asking them to write a
> commit message? Maybe we can write one ourselves before committing it,
> provided they signoff on all the commits? Maybe there should be an
> auto-signoff option too?
> 

No and no. No auto-signoff, and no auto-message. That will just leave
us with a long string of auto-signoffs and automatic messages, and
that's horrible.

The "no auto-signoff" rule is from Junio btw, and I doubt he's changed
his mind regarding that. The "no auto-message" is just my gut feeling
that everyone will really hate to see changes without an explanation.
Something simple like "5 out of 6 of the large scm's (in terms of
userbase) uses 'blarg' instead of 'fnurg' for commits, so let's call
it that in our examplinitian translation too" is enough and will be
quite helpful when it comes to explaining why a change is made.

Otoh, "Updated translations for new release" will probably be the
most common message, and that's fine too if that's what happened.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
