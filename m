From: =?ISO-8859-2?Q?=22=C1kos=2C_Tajti=22?= <akos.tajti@intland.com>
Subject: restoring all branches from a bundle
Date: Fri, 24 May 2013 12:52:52 +0200
Message-ID: <519F4684.7010905@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 24 12:53:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfpcK-0001hW-2V
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 12:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab3EXKw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 06:52:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:49641 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab3EXKwz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 06:52:55 -0400
Received: from [127.0.0.1] (94-21-249-180.pool.digikabel.hu [94.21.249.180])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MXBSK-1V0i1p3jee-00WSYJ; Fri, 24 May 2013 12:52:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-Antivirus: avast! (VPS 130523-1, 2013.05.23), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V02:K0:c99AMMOtrA9YlJjjznGV5ALiZeysGUQzKejXmacUXOQ
 hwq7iTDr8ojyCeckFvMdvQpVtKVrzTrFeXfLoMc8TuMV3ZYQXX
 ys9/Koj8LPYe/zmVq6s7pMlkNCXA+1mytjRzjjkmKricaZLmk3
 M9yrdGCCWAh+FKP6xJ3NaSYYD0I1QN5oYJr3utGcJ55Fw8gkiw
 53u3wkZBTGH+HtxMyt/8Qvj3Ngy19p+nUtFxbWjr+PK6XU575o
 C/xLt1p2KI2hZNrotrUn1f4LyL0rjziNUf3Obu/S7rMzjs/ESa
 Et/Znyg7d1MjU9I0akiy9eIYP9ELuYqEpyxhL1sFWVxl9X6n/m
 27e2NVAe5bH1T5vIubxc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225345>

Dear List,

I created a dump from a repository. git bundle list-heads prints all th=
e=20
refs I meant to add. The problem is that after exracting the dump with=20
git bundle unbundle the target repository doesn't contain any branches=20
(git branch -a prints nothing). How can we exract a dump so that the=20
branches are also restored?

Thanks in advance,
=C1kos Tajti
