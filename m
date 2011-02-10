From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [1.8.0] Remove deprecated commands
Date: Thu, 10 Feb 2011 20:42:44 +0100
Message-ID: <4D543FB4.1040709@lsrfire.ath.cx>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D4852EE.6080605@lsrfire.ath.cx> <20110202005748.GA13803@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 20:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PncPm-0004Rm-DW
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 20:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab1BJTmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 14:42:49 -0500
Received: from india601.server4you.de ([85.25.151.105]:33280 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab1BJTms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 14:42:48 -0500
Received: from [192.168.2.103] (p4FFDAF81.dip.t-dialin.net [79.253.175.129])
	by india601.server4you.de (Postfix) with ESMTPSA id E90BC2F804F;
	Thu, 10 Feb 2011 20:42:46 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110202005748.GA13803@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166495>

Am 02.02.2011 01:57, schrieb Jonathan Nieder:
>>     git-lost-found   2007-11-08       git fsck --lost-found
>
> It can stay in contrib/examples for inspiration.

Sure.

>>     git-peek-remote  2007-11-24       git ls-remote
>
> No one seems to be using it
> (github.com/gitpan/App-GitHub-FindRepository.git uses it as a fallbac=
k
> when ls-remote is not present).

How did you search for current usage?  How comprehensive are the result=
s?

>>     git-repo-config  2008-01-17       git config
>
> giggle[1] still uses it --- see libgiggle-git/giggle-git-config-read.=
c
> and giggle-git-config-write.c.
>
> Likewise darcs2git[2] and the stgit testsuite.
>
> webkit's VCSUtils.pm only uses repo-config as a fallback when git
> config is not present.

Well, the release notes for 1.5.4 promised that the "next feature=20
release will remove it".  Perhaps notifying the developers of the=20
projects you discovered is enough?

That said, the benefit for final removal of this command, which is=20
effectively just an alias, is the smallest of the four.

>>     git-tar-tree     2007-11-08       git archive
>
> Already prints a deprecation notice.  WWW::PkgFind from CPAN uses it
> but doesn't seem to be maintained.
>
> pilgrim[3] uses tar-tree in its "make dist" target.  I wouldn't be
> surprised if some other projects use it in a similar way.

Possibly, and this shows that deprecation warnings don't fully solve th=
e=20
problem of educating users to switch to the replacements.

I think it's relatively safe to remove the command anyway because the=20
users in this case are developers and packagers, i.e. the ones who put=20
the command in the Makefile in the first place.  They should be able to=
=20
cope easily.

Ren=C3=A9
