From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #08; Fri, 20)
Date: Sun, 22 Apr 2012 18:05:42 +0300
Message-ID: <CAMP44s3yy9yQ+KDtcit2RQeCs1GXx3G4F=FZJ36Jt5jgO8ZsgQ@mail.gmail.com>
References: <xmqqobqmkkxv.fsf@junio.mtv.corp.google.com>
	<20120421102335.GA29660@goldbirke>
	<xmqq8vhomj7w.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 17:06:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLyMn-0000EB-4F
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 17:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab2DVPFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Apr 2012 11:05:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50333 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab2DVPFo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2012 11:05:44 -0400
Received: by eaaq12 with SMTP id q12so2926487eaa.19
        for <git@vger.kernel.org>; Sun, 22 Apr 2012 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VD8OYs/QDHVOqBs5PX22t4WFCPqCjS0ftc8q9BkDHCw=;
        b=tWexypTKyDKkf+OgtWZOk62ef+WzpNitSN042JSS0WWx3/50kspDVO1PAD7+M8A7ZP
         sZowZBSYlC0eMrExo0N4cD2XHbdgDEvj8PP+U5NidqlV323ZzCxb+0zaApeFq+splJ3v
         VcnpdIZUuwg2eAMTp0/bZ+92aUkE6bB51vRO2VXDy3lNgMv8aRzxROUuTdWfOPUDOGJv
         zxwy/D4W9UHsiHUFgx3+DyRiV0gZrrSFuPmEjFqGPM45eJ+p6u70C2CREkvF78/zdTOr
         UDKG2KYE0LhtodOamvWNfgywNuWVv9Oa5vahl/DNtj7oM5aBg8Hc43aamH55GlofmQXB
         BN0A==
Received: by 10.14.96.129 with SMTP id r1mr2085626eef.86.1335107142774; Sun,
 22 Apr 2012 08:05:42 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sun, 22 Apr 2012 08:05:42 -0700 (PDT)
In-Reply-To: <xmqq8vhomj7w.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196080>

On Sun, Apr 22, 2012 at 8:25 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> On Fri, Apr 20, 2012 at 05:06:20PM -0700, Junio C Hamano wrote:
>>> * fc/completion-tests (2012-04-18) 7 commits
>>> =C2=A0- tests: add tests for the __gitcomp() completion helper func=
tion
>>> =C2=A0- completion: fix completion after 'git --option <TAB>'
>>> =C2=A0- completion: avoid trailing space for --exec-path
>>> =C2=A0- completion: add missing general options
>>> =C2=A0- completion: simplify by using $prev
>>> =C2=A0- completion: simplify __gitcomp_1
>>> =C2=A0- tests: add initial bash completion tests
>>
>> Perhaps you could move 'tests: add tests for the __gitcomp()
>> completion helper function' from the top after 'tests: add initial
>> bash completion tests', to show that Felipe's 'completion: simplify
>> __gitcomp_1' doesn't break any of the tests.
>
> I don't mind. =C2=A0Felipe, what do you think?

=46ine by me.

--=20
=46elipe Contreras
