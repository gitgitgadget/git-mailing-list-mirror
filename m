From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] add csharp userdiff tests
Date: Sun, 27 Apr 2014 22:12:44 +0200
Message-ID: <535D64BC.8060403@kdbg.org>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org> <3A0D05C9-C222-463E-BCD4-CD38F216E352@xamarin.com> <535D2E0C.40101@kdbg.org> <CF7066B0-539D-4FAB-8845-8ED60DF1F17E@xamarin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marius Ungureanu <marius.ungureanu@xamarin.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:12:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeVRV-0005JQ-1q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 22:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbaD0UMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Apr 2014 16:12:48 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:56407 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750993AbaD0UMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 16:12:47 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A5E13130054;
	Sun, 27 Apr 2014 22:12:45 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B45B219F42F;
	Sun, 27 Apr 2014 22:12:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CF7066B0-539D-4FAB-8845-8ED60DF1F17E@xamarin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247223>

Am 27.04.2014 18:46, schrieb Marius Ungureanu:
> Is it okay though if I add a few tests to show what is broken?
>=20
> I think this can=92t be solved at a regex level.

It's OK to add tests that show breakages even if there is no immediate
solution.

>> You can mark a userdiff test case that demonstrates a breakage by
>> including the work "broken" somewhere in the file. See
>> http://www.repo.or.cz/w/alt-git.git/commitdiff/9cc444f0570b196f1c516=
64ce2de1d8e1dee6046

You add tests including broken cases first, and then in the follow-up
patch that fixes the broken ones, you also mark the tests as fixed, lik=
e
I did in the follow-up patch of the above example:
http://www.repo.or.cz/w/alt-git.git/commitdiff/8a2e8da367f7175465118510=
b474ad365161d6b1

-- Hannes
