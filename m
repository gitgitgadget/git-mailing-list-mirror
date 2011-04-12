From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Converting merge to rebase in the presence of conflicts
Date: Tue, 12 Apr 2011 08:11:09 +0200
Message-ID: <4DA3ECFD.7060202@viscovery.net>
References: <BANLkTi=krC6JMEWj=a5CY1vRCcmh9b+BaQ@mail.gmail.com>	<4DA3182B.2030305@viscovery.net> <BANLkTinVUdmG56oPQXvMhFh6hLcFj3_jZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 08:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9WpG-0000gm-2K
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 08:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab1DLGLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 02:11:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18946 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932068Ab1DLGLO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 02:11:14 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q9Woh-0007We-N3; Tue, 12 Apr 2011 08:11:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 49D5F1660F;
	Tue, 12 Apr 2011 08:11:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTinVUdmG56oPQXvMhFh6hLcFj3_jZg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171370>

Please don't cull Cc list; use "Reply to all" in your MUA.

Am 4/11/2011 17:15, schrieb Hrvoje Nik=C5=A1i=C4=87:
> I still wonder why rerere is necessary here. After all, even without
> the rerere metadata, the information about conflict resolution is
> right there, in the merge commit, and rebase could conceivably make
> use of it. What am I missing?

The conflicts that you see during a merge may be attributed to several
different commits of the merged branch. Therefore, when you rebase the
branch, you will see different subsets of the conflicts for each rebase=
d
commit, and it is possible that you see conflicts that you did not see =
in
the merge. How can you expect rebase to "know" how to resolve them?

-- Hannes
