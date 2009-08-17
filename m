From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 01:00:28 +0200
Message-ID: <3af572ac0908171600s7aa7b21ftf95fde92246bf75f@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
	 <4A899495.8050902@gnu.org>
	 <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>
	 <alpine.DEB.1.00.0908172255140.8306@pacific.mpi-cbg.de>
	 <3af572ac0908171359o33f6ca70n599bdc27be74784a@mail.gmail.com>
	 <alpine.DEB.1.00.0908172306080.8306@pacific.mpi-cbg.de>
	 <4A89D909.9050700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:01:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBCP-000630-Cf
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbZHQXA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 19:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbZHQXA2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:00:28 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:44749 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZHQXA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 19:00:27 -0400
Received: by bwz22 with SMTP id 22so2603588bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 16:00:28 -0700 (PDT)
Received: by 10.223.127.195 with SMTP id h3mr981400fas.57.1250550028233; Mon, 
	17 Aug 2009 16:00:28 -0700 (PDT)
In-Reply-To: <4A89D909.9050700@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126312>

On Tue, Aug 18, 2009 at 12:26 AM, Johan 't Hart<johanthart@gmail.com> wrote:
> Johannes Schindelin schreef:
>
>> Having said that, a CMake-based system _in addition_ to what is
>> tried-and-tested to be able to support all those different kinds of
>> Microsoft Visual Studio (took me 3 attempts to write that without a
>> Freudian) would be welcome, _if_ you succeed in making it compile out of the
>> box on msysGit.
>
> That would require (I think) that CMake is build by the msysgit gcc tools
> available in msysgit, since CMake can't be build by VS right? Pau do you
> think that is possible?

CMake can certainly be built by VC++ but you need CMake to do that,
VC++-CMake cannot be bootstrapped.

Would it be OK to download a binary version of CMake instead of / in
addition to the source? (I'm not familiar with the 'release.sh' stuff
yet)

> It would be fun. Download the msysgit netinstaller, set it up, install it,
> and after that, CMake is bootstrapped, and the visual studio .vcproj files
> are generated and everyone (VS developers and msys developers) are ready to
> go!

That'd be right, if I have understood what the netinstaller does (I've
never used it yet).

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
