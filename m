From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Fwd: Git Directory Diff for submodule
Date: Fri, 07 Feb 2014 21:38:25 +0100
Message-ID: <52F54441.6090209@web.de>
References: <CAN-m_UmNudmxJnA95h1nYqi7GGxtzKqqpgFHmJZ+MTnxRoEd6g@mail.gmail.com>	<CAN-m_UnQ7Yzuq7n6mxmsd3XcfLSVxMdnLiGFDiN1Ph3ZiFqwew@mail.gmail.com> <CAN-m_U=eYSEXfVBcD1Rfx-YvGx5Wu+hB2uAc=6xX_HO7bS0FUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?G=E1bor_Lipt=E1k?= <gabor.liptak@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 07 21:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBsC3-0000vS-PJ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 21:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbaBGUic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Feb 2014 15:38:32 -0500
Received: from mout.web.de ([212.227.15.3]:52942 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbaBGUib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 15:38:31 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0M9ons-1W5Jgy1ghU-00B6pD for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 21:38:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAN-m_U=eYSEXfVBcD1Rfx-YvGx5Wu+hB2uAc=6xX_HO7bS0FUg@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:xWUAipZcWkHJKj39AzBycQmIw3l1raWjUwhducFgEuJGp/70UDG
 SNAYwaslZtxgNe6m9NipvkcNeJKNWUYierzCfXh38oHmmTYTaqZgV3LAFYAaafu7Q7pUV5C
 EzrLaRNDh+3tIlBFXrOJ+/AsLPV1UUEuFaEqkZyYV89CX+VOfPEYb+2ad09rudicLQ4ms3j
 2nEbaQCAQdfOIPo8dhrvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241794>

Am 07.02.2014 10:15, schrieb G=E1bor Lipt=E1k:
> I think I have found a bug related to submodules and directory diff.
> See the details at hXXp://stackoverflow.com/q/21623155/337621.

Let's inline the recipe one finds after decrypting this link:

~/Projects/MAINMODULE/platform/SUBMODULE [master]$ git difftool -tool=3D=
meld --dir-diff --cached
  fatal: Could not switch to '../../../../platform/': No such file or d=
irectory
  diff --raw --no-abbrev -z --cached: command returned error: 128
~/Projects/MAINMODULE/platform/SUBMODULE [master]$ cd ..
~/Projects/MAINMODULE/platform [master]$ cd ..
~/Projects/MAINMODULE [master]$ git difftool -tool=3Dmeld --dir-diff --=
cached
  // NO PROBLEM, works.
~/Projects/MAINMODULE [master]$ git version
  git version 1.8.4


> If you need any further details, just ask.

- Does this only happen when you use difftool? E.g. what does
  "git status" inside the submodule say?

- What does "git config core.worktree" print when run in the
  submodule?
