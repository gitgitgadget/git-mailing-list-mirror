From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: CMake, was Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 21:54:23 +0200
Message-ID: <3af572ac0908171254i539318d0p555a1c622e4d513f@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
	 <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
	 <alpine.DEB.1.00.0908172147240.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171251y355a1e2bjf2d10192bc3eca2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8Hy-0004mN-14
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529AbZHQTyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 15:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756844AbZHQTyY
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:54:24 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:48239 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829AbZHQTyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 15:54:23 -0400
Received: by bwz22 with SMTP id 22so2522867bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 12:54:23 -0700 (PDT)
Received: by 10.223.143.79 with SMTP id t15mr930479fau.13.1250538863643; Mon, 
	17 Aug 2009 12:54:23 -0700 (PDT)
In-Reply-To: <3af572ac0908171251y355a1e2bjf2d10192bc3eca2e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126267>

On Mon, Aug 17, 2009 at 9:51 PM, Pau Garcia i
Quiles<pgquiles@elpauer.org> wrote:
> On Mon, Aug 17, 2009 at 9:48 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
>> On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:
>>
>>> What about having a CMake build system, which would work on every
>>> platform (including cross-compiling), and would produce an appropri=
ate
>>> config.h and makefiles/vcproj/Eclipse projects/XCode projects/whate=
ver
>>> is fit for each platform? If it's OK to include such a build system
>>> upstream, I'm volunteering to implement it.
>>
>> And reap in another dependency?
>>
>> First Python, then CMake, what tomorrow? =A0Is it the month of addin=
g
>> dependencies?
>
> I'd say it's the month of getting problems solved.
>
> CMake would make git a lot easier to build on Windows, particularly
> with Visual C++. Replace autotools with CMake and suddenly you need t=
o
> maintain a single build system for every platform and compiler git
> supports/will support. That's a sound advantage to me.

I forgot to say CMake would be a build-dependency, not a runtime
dependency, in case anyone is wondering.

More info about CMake:
http://www.cmake.org

Tutorial:
http://www.elpauer.org/stuff/learning_cmake.pdf

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
