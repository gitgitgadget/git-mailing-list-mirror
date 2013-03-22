From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH] t7600: merge tag shoud create a merge commit
Date: Fri, 22 Mar 2013 15:56:15 +0100
Organization: OPTEYA
Message-ID: <831c87ad325075b6049ef52c24477da2@meuh.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vr4j78p8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 15:56:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3Oo-0006MH-Iz
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 15:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933845Ab3CVO4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 10:56:23 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:58384 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933754Ab3CVO4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:56:19 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1UJ3OB-000G5M-84; Fri, 22 Mar 2013 15:56:15 +0100
In-Reply-To: <7vr4j78p8a.fsf@alter.siamese.dyndns.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218807>

Le 22.03.2013 15:48, Junio C Hamano a =C3=A9crit=C2=A0:
>>
>> It's not in final shape: the line
>>
>>     EDITOR=3Dfalse test_must_fail git merge signed
>
> Because test_must_fail is a shell function, single-shot environment
> assignment like this should not be used.

It's used throughout the test. The test 'merge --no-edit tag should=20
skip editor' is using it.

Before posting my half useful test, I used "EDITOR=3Dfalse test_must_fa=
il=20
set" in --verbose mode to find if EDITOR was correctly defined passed=20
test_must_fail, and it was.

So it's still not clear why it's failing at failing. And it's making me=
=20
angry.

Regards.

--=20
Yann Droneaud
OPTEYA
