From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 07:43:49 +0200
Message-ID: <A9C84864-8F7C-4B0D-A304-A95399559149@zib.de>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com> <20080416200107.GG3133@dpotapov.dyndns.org> <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com> <20080416203923.GH3133@dpotapov.dyndns.org> <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com> <20080416223739.GJ3133@dpotapov.dyndns.org> <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 07:44:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmMum-0002vV-Md
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 07:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYDQFnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 01:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbYDQFnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 01:43:09 -0400
Received: from mailer.zib.de ([130.73.108.11]:35746 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbYDQFnI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 01:43:08 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m3H5h3c7003838;
	Thu, 17 Apr 2008 07:43:04 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db97598.pool.einsundeins.de [77.185.117.152])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m3H5h2HT021810
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 17 Apr 2008 07:43:03 +0200 (MEST)
In-Reply-To: <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79767>


On Apr 17, 2008, at 1:07 AM, Nigel Magnay wrote:

> In a perfect world I'd be able to switch all files int the repo to LF,
> but that's not going to happen any time soon because of the majority
> of developers, still on svn, still on windows.


If you want Git's autocrlf to convert to the native line endings on  
Windows and Unix, you need to convert everything to LF in the repo.   
This is what we did and now everything runs smoothly.

I have no recommendation, though, how to use svn and git together.  I  
do not use git-svn.

	Steffen
