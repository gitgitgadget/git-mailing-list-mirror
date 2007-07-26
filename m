From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 22:56:26 -0700
Message-ID: <46A8378A.6050201@xs4all.nl>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com> <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com> <7vps2fc196.fsf@assigned-by-dhcp.cox.net> <20070726031838.GO32566@spearce.org> <7v6447bxc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707260614500.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 07:56:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwL2-00039u-Gp
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbXGZF4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbXGZF4h
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:56:37 -0400
Received: from main.gmane.org ([80.91.229.2]:54493 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbXGZF4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:56:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IDwKw-00051a-Sp
	for git@vger.kernel.org; Thu, 26 Jul 2007 07:56:34 +0200
Received: from c-24-6-173-165.hsd1.ca.comcast.net ([24.6.173.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 07:56:34 +0200
Received: from hanwen by c-24-6-173-165.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 07:56:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-6-173-165.hsd1.ca.comcast.net
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <Pine.LNX.4.64.0707260614500.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53774>

Johannes Schindelin wrote:
>> If that is the case, "Git for Windows" probably should package MSYS as 
>> part of it, I would think, to match the expectation of the users there.  
>> I know two Johannes'es and Han-Wen spent quite a lot of effort on 
>> Windows port and packaging, but perhaps that little (well, I should not 
>> be judging if that is a little or huge, as I do not do Windows) 
>> finishing touch would make Windows users much happier?
> 
> Windows users are only happy when they can bug developers.
> 
> Seriously again, the biggest problem with Han-Wen's installer was that it 
> insists on cross-compiling _all_ the packages.  This makes it easy for 
> Han-Wen to upgrade packages and compile the thing on Linux in one go.  
> However, it never worked with bash, and I could not fix it: I can read 
> Python, but not _that_ Python.
> 

The problem is not really the python. If you supply me with a shell
script that will x-compile bash, I'll hapily code the python spec. IMO
the real problem is that bash is a unix shell (tied to unix internals)
and therefore, compiling it for something as horrid as windows is far
from trivial.

fwiw, I briefly tried compiling msys, but I couldn't even find its
sources, so I quickly gave up.

A second option is that someone supplies me with an unpacked, installed
tree of msys' bash shell. I can easily package that up along with the
rest of the installer, if it doesnt' require further trickery (setting
registry entries, etc.)
