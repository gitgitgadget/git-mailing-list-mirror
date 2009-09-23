From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Add scripts to generate projects for other buildsystems (MSVC 
	vcproj, QMake)
Date: Wed, 23 Sep 2009 08:04:53 -0700 (PDT)
Message-ID: <72888219-5bab-4964-9faf-0d40b4770e2c@o35g2000vbi.googlegroups.com>
References: <cover.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com, j6t@kdbg.org,
	lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com
To: msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 17:05:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqTOw-0004QE-LV
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 17:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZIWPEv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2009 11:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbZIWPEu
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 11:04:50 -0400
Received: from mail-yx0-f165.google.com ([209.85.210.165]:50317 "EHLO
	mail-yx0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZIWPEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2009 11:04:50 -0400
Received: by yxe37 with SMTP id 37so740116yxe.33
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 08:04:54 -0700 (PDT)
Received: by 10.150.44.14 with SMTP id r14mr290431ybr.8.1253718293997; Wed, 23 
	Sep 2009 08:04:53 -0700 (PDT)
In-Reply-To: <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com>
X-IP: 91.64.214.160
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.3) 
	Gecko/20090824 Firefox/3.5.3,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128982>

On Sep 16, 10:20=A0am, Marius Storm-Olsen <mstormo@gmail.com> wrote:

> These scripts generate projects for the MSVC IDE (.vcproj files) or
> QMake (.pro files), based on the output of a 'make -n MSVC=3D1 V=3D1'=
 run.
>
> This enables us to simply do the necesarry changes in the Makefile, a=
nd you
> can update the other buildsystems by regenerating the files. Keeping =
the
> other buildsystems up-to-date with main development.

I know I'm a little late with my comments as this patch set has
already been merged to master. However, for future reference I'd like
to point out that something similar could be archived by using e.g.
CMake, and only maintaining the CMake project file. I'm not suggesting
to actually switch to CMake at this time, but I wanted to point out
that a guy called Pau Garcia i Quiles already seems to have created a
preliminary CMakeLists.txt file for Git [1], and also tried to build
Git for Windows using his CMake-generated MSVC project files.

[1] "CMake-ifying git", http://www.elpauer.org/?p=3D324

--
Sebastian
