From: =?windows-1252?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git grep -F doesn't behave like grep -F?
Date: Fri, 18 May 2012 14:37:00 +0200
Message-ID: <4FB6426C.7040202@lsrfire.ath.cx>
References: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Torne (Richard Coles)" <torne@google.com>
X-From: git-owner@vger.kernel.org Fri May 18 14:37:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVMQf-0008Qg-OJ
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 14:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965342Ab2ERMhD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 08:37:03 -0400
Received: from india601.server4you.de ([85.25.151.105]:60909 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab2ERMhB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 08:37:01 -0400
Received: from [192.168.2.105] (p4FFD9588.dip.t-dialin.net [79.253.149.136])
	by india601.server4you.de (Postfix) with ESMTPSA id 76C852F806F;
	Fri, 18 May 2012 14:36:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197952>

Am 18.05.2012 13:00, schrieb Torne (Richard Coles):
> Hi folks,
>
> git grep -F is documented as: "Use fixed strings for patterns (don=92=
t
> interpret pattern as a regex)."
>
> whereas grep -F is documented as "Interpret PATTERN as a  list  of
> fixed  strings,  separated  by newlines,  any  of  which is to be
> matched."
>
> This accurately describes how they behave, which means that git grep
> -F with a pattern containing newlines never matches anything (at leas=
t
> as far as I can see). Is this intentional, or an oversight? The
> ability to grep -F for a list (e.g. the output of another grep) is
> pretty handy...

You could use -f- (read patterns from stdin).

That said, it looks like a missing feature to me -- at least I didn't=20
know that grep -F takes newline separated lists of search strings.  And=
=20
this doesn't seem to be restricted to invocations with -F, only; a plai=
n=20
grep with regexps does it as well.

Ren=E9
