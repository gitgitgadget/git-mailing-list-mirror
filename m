From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: CMake, was Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 21:51:48 +0200
Message-ID: <3af572ac0908171251y355a1e2bjf2d10192bc3eca2e@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
	 <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
	 <alpine.DEB.1.00.0908172147240.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:51:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8FJ-0003da-9r
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbZHQTvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 15:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbZHQTvt
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:51:49 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:62331 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbZHQTvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 15:51:48 -0400
Received: by bwz22 with SMTP id 22so2521651bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 12:51:49 -0700 (PDT)
Received: by 10.223.143.79 with SMTP id t15mr930080fau.13.1250538708832; Mon, 
	17 Aug 2009 12:51:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908172147240.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126265>

On Mon, Aug 17, 2009 at 9:48 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:

> On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:
>
>> What about having a CMake build system, which would work on every
>> platform (including cross-compiling), and would produce an appropria=
te
>> config.h and makefiles/vcproj/Eclipse projects/XCode projects/whatev=
er
>> is fit for each platform? If it's OK to include such a build system
>> upstream, I'm volunteering to implement it.
>
> And reap in another dependency?
>
> First Python, then CMake, what tomorrow? =A0Is it the month of adding
> dependencies?

I'd say it's the month of getting problems solved.

CMake would make git a lot easier to build on Windows, particularly
with Visual C++. Replace autotools with CMake and suddenly you need to
maintain a single build system for every platform and compiler git
supports/will support. That's a sound advantage to me.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
