From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: RFC: Between git-subtree and git-submodules
Date: Sun, 25 Jul 2010 02:28:04 +0200
Message-ID: <AANLkTikwpruLt-D0tYn+eP5JpB1h0RD55+xr_7S+RfOa@mail.gmail.com>
References: <AANLkTi=tDRfgzzcbp0jV=+hQ+Cs2fhNF0vK8JL1COoFu@mail.gmail.com> 
	<AANLkTinyjinsGS2ddyMOW=3zDN1ThJcpF+dc4cBE6L9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 02:28:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocp57-0008Oi-AG
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 02:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab0GYA20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 20:28:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36539 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab0GYA2Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 20:28:25 -0400
Received: by fxm14 with SMTP id 14so5613493fxm.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 17:28:24 -0700 (PDT)
Received: by 10.103.40.6 with SMTP id s6mr913813muj.111.1280017704164; Sat, 24 
	Jul 2010 17:28:24 -0700 (PDT)
Received: by 10.102.58.11 with HTTP; Sat, 24 Jul 2010 17:28:04 -0700 (PDT)
In-Reply-To: <AANLkTinyjinsGS2ddyMOW=3zDN1ThJcpF+dc4cBE6L9D@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151691>

> With #3, I can see that you want something different than I do; you
> want to silently revert your own patches out of the submodule's
> history, when you upgrade the submodule to a new version. =A0Personal=
ly,
> I find this concept a bit objectionable (it's like "git merge -s
> ours"), but okay, it's pretty easy to implement, and you've submitted
> a patch to git-subtree that does it. =A0My question is: why would you
> want this? =A0Isn't it clearer to 'git revert' the patches you don't
> want?

While writing the docs for the --prune option I've found this sentence =
in
git-subtree.txt:

	'git subtree merge --squash'
	always adjusts the subtree to match the exactly
	specified commit, even if getting to that commit would
	require undoing some changes that were added earlier.

I think this is not true, and it contradicts with what you've just said=
=2E Or I
don't understand it correctly.

Thanks,
Santi
