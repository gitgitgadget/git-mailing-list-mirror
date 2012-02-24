From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [BugReport] git tag -a / git show
Date: Fri, 24 Feb 2012 20:27:09 +0100
Message-ID: <4F47E48D.4080501@in.waw.pl>
References: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?IlJvbWFpbiBWaW1vbnQgKMKub20pIg==?= <rom@rom1v.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S10o7-0004YG-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 20:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465Ab2BXT1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 14:27:48 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55076 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757437Ab2BXT10 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 14:27:26 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S10na-0003lW-TS; Fri, 24 Feb 2012 20:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191446>

On 02/24/2012 11:24 AM, Romain Vimont (=C2=AEom) wrote:
> $ git log --pretty=3Donline
> 0ef41513d0b6d0ad28f21d0ac1da7096ad1dc6ff This is the last commit
> a4702c69c28484d357179166cf3b116764da20a4 This is a commit
>
> Now, I edit some files (for example in a config file "mock_data=3Dtru=
e"),
> then I want to tag without commiting this change.
>
> $ git tag -a v0.1 -m 'My v0.1 with mock data'

> And it shows the diff between a4702c69c28484d357179166cf3b116764da20a=
4
> and 0ef41513d0b6d0ad28f21d0ac1da7096ad1dc6ff (the two last commits).

Hi Romain,
git tag attaches the tag to the last commit, 0ef41513 in your case.=20
Dirty changes in your tree are ignored by the tag command. You would=20
have to commit them first, and attach the tag to this new commit.

zbyszek
