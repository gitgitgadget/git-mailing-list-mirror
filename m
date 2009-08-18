From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 19:06:15 +0200
Message-ID: <3af572ac0908181006n2e00b561x374007bff2e2d31f@mail.gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <1250600335-8642-1-git-send-email-mstormo@gmail.com>
	 <4A8AD561.1020303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdS8h-0007nA-U2
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759373AbZHRRGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759275AbZHRRGQ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:06:16 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:43205 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759237AbZHRRGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:06:16 -0400
Received: by fxm11 with SMTP id 11so413209fxm.39
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 10:06:16 -0700 (PDT)
Received: by 10.223.4.209 with SMTP id 17mr1271613fas.85.1250615175677; Tue, 
	18 Aug 2009 10:06:15 -0700 (PDT)
In-Reply-To: <4A8AD561.1020303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126423>

On Tue, Aug 18, 2009 at 6:22 PM, Johan 't Hart<johanthart@gmail.com> wrote:
> Marius Storm-Olsen schreef:
>>
>> From: Marius Storm-Olsen <mstormo@gmail.com>
>>
>> By using GNU Make we can also compile with the MSVC toolchain.
>> This is a rudementary patch, only meant as an RFC for now!!
>>
>
> Would this mean that only the MSVC toolchain is used to build git in batch?
> Or does GNU Make create a .vcproj file like CMake?

That patch uses GNU Make but invoking the MSVC compiler, linker, etc
instead of the GNU compiler, linker, etc. It'd be the same if you
wanted to use the Intel compiler, the Sun compiler, etc.

> Because that ofcource is
> the whole purpose of using CMake. One can use the Visual Studio IDE to hack
> on git.

CMake is also useful to create installers/tarballs (see CPack), run
tests (see CTest; it's NOT a unit test library but a tests launcher on
steroids) and submit the results of compilation, tests and
installation to a dashboard where you can easily see what (if
anything) went wrong (see CDash, formerly Dart).

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
