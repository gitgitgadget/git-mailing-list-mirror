From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: need to create new repository initially seeded with several branches
Date: Wed, 31 Aug 2011 19:48:08 +0200
Message-ID: <4E5E73D8.4040104@kdbg.org>
References: <1314804325568-6746957.post@n2.nabble.com> <201108311540.p7VFen5S015756@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "ryan@iridiumsuite.com" <ryan@iridiumsuite.com>,
	git@vger.kernel.org
To: in-git-vger@baka.org
X-From: git-owner@vger.kernel.org Wed Aug 31 19:48:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyotf-0000U5-5c
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 19:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976Ab1HaRsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 13:48:13 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:51517 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756923Ab1HaRsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 13:48:13 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8E16A1000F;
	Wed, 31 Aug 2011 19:48:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 62D0119F43F;
	Wed, 31 Aug 2011 19:48:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.20) Gecko/20110804 SUSE/3.1.12 Thunderbird/3.1.12
In-Reply-To: <201108311540.p7VFen5S015756@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180498>

Am 31.08.2011 17:40, schrieb in-git-vger@baka.org:
> # Cause git to delete all files in the internal index
> git read-tree --reset -i 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> # Cause git to delete all files in the working directory
> git clean -dfx
> ...
> The only "magic" is the read-tree/git-clean stuff.  The 4b82=E2=80=A6=
 value is
> the SHA of an empty tree.  It could be replaced by...

=2E.. a simple

  git rm -rf .

-- Hannes
