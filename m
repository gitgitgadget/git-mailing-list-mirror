From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for
 merges
Date: Mon, 03 Jun 2013 01:47:38 +0200
Message-ID: <51ABD99A.2030303@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx> <CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com> <51AB86BB.3080203@lsrfire.ath.cx> <CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com> <51ABAA84.8090301@lsrfire.ath.cx> <CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com> <51ABD00C.7080503@lsrfire.ath.cx> <CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 01:47:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjI05-0005Dq-2L
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 01:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab3FBXrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 19:47:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:58196 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab3FBXro (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 19:47:44 -0400
Received: from [192.168.2.105] (p579BEDD3.dip0.t-ipconnect.de [87.155.237.211])
	by india601.server4you.de (Postfix) with ESMTPSA id 9DB191FD;
	Mon,  3 Jun 2013 01:47:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226197>

Am 03.06.2013 01:23, schrieb Felipe Contreras:
> I didn't say we should do 'if (ce) free(ce);' instead of 'free(ce);' =
I
> said we should do 'if (cd && ce !=3D o->df_conflict_entry)' instead o=
f
> 'if (ce !=3D o->df_conflict_entry)'.

I did assume you meant the latter.

> There's no reason not to.

Only the minor ones already mentioned: More text, one more branch in=20
object code, no benefit except for some hypothetical future case that's=
=20
caught by the test suite anyway -- or by code review.

I wonder if we already reached the point where we spent more time=20
discussing this change than the time needed by the envisioned developer=
=20
to find and fix the NULL check that suddenly became necessary. :)

Ren=C3=A9
