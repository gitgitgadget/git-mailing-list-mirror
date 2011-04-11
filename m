From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Converting merge to rebase in the presence of conflicts
Date: Mon, 11 Apr 2011 17:03:07 +0200
Message-ID: <4DA3182B.2030305@viscovery.net>
References: <BANLkTi=krC6JMEWj=a5CY1vRCcmh9b+BaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 17:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Ie8-0005Lm-V3
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 17:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab1DKPDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 11:03:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25201 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab1DKPDL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 11:03:11 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q9Idw-0007PZ-L4; Mon, 11 Apr 2011 17:03:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E778C1660F;
	Mon, 11 Apr 2011 17:03:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTi=krC6JMEWj=a5CY1vRCcmh9b+BaQ@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171332>

Am 4/11/2011 16:13, schrieb Hrvoje Nik=C5=A1i=C4=87:
> Is there a way to rebase the branch without redoing conflict
> resolution?

git config --global rerere.enabled true

-- Hannes
