From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
 with no changes written
Date: Wed, 3 Feb 2010 00:15:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002030014100.4985@pacific.mpi-cbg.de>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>  <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>  <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>  <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
  <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>  <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>  <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>  <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com> 
 <32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com> <76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:09:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcRrl-0003f8-CE
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab0BBXI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:08:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:43971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756799Ab0BBXI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:08:58 -0500
Received: (qmail invoked by alias); 02 Feb 2010 23:08:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 03 Feb 2010 00:08:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SwDJFvJSSjMxT8KjN1V1XVX0R7M47KFtEy3M+eG
	ENZiF7mIgZ4uNf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.70999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138779>

Hi,

On Tue, 2 Feb 2010, Eugene Sajine wrote:

> Frankly, I think that "rebase -i" is the best example when exiting 
> without save should abort, not proceed.

That would be horrible! If the list of commits I want to apply happens to 
be exactly what I want without needing any reordering/removing, then it 
would abort, according to you.

Ciao,
Dscho
