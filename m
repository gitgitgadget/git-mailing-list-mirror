From: =?UTF-8?B?Sm/Do28gQ2FybG9zIE1lbmRlcyBMdcOtcw==?= 
	<jonny@jonny.eng.br>
Subject: Re: [PATCH 0/5 v2] Worktree/Gitdir at root directory
Date: Fri, 12 Feb 2010 11:05:45 -0200
Message-ID: <4B755229.6000502@jonny.eng.br>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com> <4B752BA1.9080105@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 14:05:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfvDa-0007kq-RF
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 14:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab0BLNFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 08:05:51 -0500
Received: from roma.coe.ufrj.br ([146.164.53.65]:56167 "EHLO coe.ufrj.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564Ab0BLNFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 08:05:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by coe.ufrj.br (Postfix) with ESMTP id B6C5F1FA1E4;
	Fri, 12 Feb 2010 11:05:48 -0200 (BRST)
X-Virus-Scanned: amavisd-new at coe.ufrj.br
Received: from coe.ufrj.br ([146.164.53.65])
	by localhost (roma.coe.ufrj.br [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lG2MwZuEmwXD; Fri, 12 Feb 2010 11:05:45 -0200 (BRST)
Received: from home.jonny.eng.br (unknown [187.14.9.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coe.ufrj.br (Postfix) with ESMTPSA id 98A3C1FA042;
	Fri, 12 Feb 2010 11:05:45 -0200 (BRST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090625)
In-Reply-To: <4B752BA1.9080105@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139705>



Johannes Sixt wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>> So here we go again. Changes are:
>>
>>  - Support DOS drives as root path (Thanks Hannes)
>>  - Fix one "broken" test that I was too lazy to do last time
>>  - t1509-root-worktree.sh will refuse to run under root permission
>>
>> I did not test it on Windows, so an Ack from someone who actually=20
>> tests it on Windows
>> is really appreciated.
>
> I don't see any regressions in may tests on Windows, but I actually=20
> don't know what to test (the chroot test doesn't work on Windows). I=20
> did test on the root of a partition
>
>    T:\> git init
>    T:\> cd foo
>    T:\foo> git add bar
>
> and it works as expected.

Beware: My first proposed patch "worked" at this level, but failed=20
completely when I wanted to commit.   Try more operations just to be su=
re.

The auto test routines include a ram-disk creation, for windows case,=20
but I'm not sure how portable this would be.
