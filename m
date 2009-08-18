From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 19:07:45 +0200
Message-ID: <3af572ac0908181007q7622091eqc78861e00c3a9e45@mail.gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <1250600335-8642-1-git-send-email-mstormo@gmail.com>
	 <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <mstormo@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org,
	kusmabite@googlemail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdSAu-0000H1-QK
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759398AbZHRRHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 13:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759326AbZHRRHr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:07:47 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:33963 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759241AbZHRRHq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 13:07:46 -0400
Received: by bwz22 with SMTP id 22so3155655bwz.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 10:07:47 -0700 (PDT)
Received: by 10.223.145.13 with SMTP id b13mr1302489fav.4.1250615265808; Tue, 
	18 Aug 2009 10:07:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126424>

On Tue, Aug 18, 2009 at 4:11 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:
>
>> =A0So, instead of rely on these vcproj files which *will* go stale, =
we can
>> =A0simply use the same Makefile system which everyone else is using.=
 :)
>> =A0After all, we're just compiling with a different compiler. The en=
d
>> =A0result will still rely on the *msysGit environment* to function, =
so we
>> =A0already require it. Thus, GNU Make is present, and we can use it.
>
> We can also use sed or perl to generate/modify the .vcproj files, or =
run
> CMake (once Pau got it to build), and package the stuff using zip (on=
ce I
> got that to build).

Re: package the stuff using ZIP, it's trivial to do with CPack (part
of the CMake chain). Just tell me what you want to get and I'll
implement it.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
