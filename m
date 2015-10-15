From: Sven Helmberger <sven.helmberger@gmx.de>
Subject: Re: Alternative to manual editing with git add --patch
Date: Thu, 15 Oct 2015 15:37:22 +0200
Message-ID: <561FAC12.5020007@gmx.de>
References: <561E6FBB.7060302@gmx.de>
 <xmqqk2qp8hlj.fsf@gitster.mtv.corp.google.com> <561EE700.3020002@gmx.de>
 <alpine.DEB.1.00.1510151152470.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 15 15:37:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmiiu-000858-6d
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 15:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbbJONh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 09:37:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:54859 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbbJONhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 09:37:25 -0400
Received: from [192.168.2.61] ([79.245.214.86]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M7Y9j-1aX8lg0sfH-00xHUF; Thu, 15 Oct 2015 15:37:23
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <alpine.DEB.1.00.1510151152470.31610@s15462909.onlinehome-server.info>
X-Provags-ID: V03:K0:v+Xw9pPFVXo84cnQ0HjxJupF7GqsV2kmPuG0at6VDQYZ3G8Hgcn
 JQsFNlbJeDX26HZq+NYGon8eGzsLKmHyz9mUqA7av0EktrEIPAHQ08K8Ov0HTow7NYcto42
 shTraX13vIO1uI0RxTDVOryeTlY8OWsNExQv/Fsu+GAaM1M5R3OZuPbEQ0HMu72tB9S0++x
 jRb6/6Yai+ipQ+lHg1faw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HtGAHO4I/iI=:1zIYDwX+sdgZqlwAcZfffP
 QpLX2hHkwT4flf67I3iy/Vxcq65hUOL4tO8o9C+gPkfKG5Zi75yKc2RBeJszbWLuEP3jIAlt1
 aI1VV20CZl6Jt2YDjRUnOdegK8dXlH/3zsAoNUAF0/hxN7BYVAujz2q8KGRB7PjCspfi7cmMb
 sNuo83/zbIjslU0cBsXGRwk+22jZr/pSdwjww10WoKJ70CGRHCJNknTgeAItCRylD2OEzWiWH
 bnNfHlkKePc1NCzLRki6US+5s2AHdAj7+vZCR6iwzLVqC0SKr1fDf++2NYf9MXO/Brb+XWC6t
 M9qnA/s3/XRias6fNxk+xIAJnvnJfJ8JHXeRAC/9T7N2JCasMCrd/SfVslnzuQeSQi08dU7HT
 rbgNKsD1b4FD04REmCPN8tlC4K6o7KNUPr6QFR4LjAYqV2DemU1tbwyFBuAlvTfFhJijJXPcc
 9iAhuApW0VysON/MvQeL3PV7ZfRJS+Ctzsv9Quxe16nqjvmi/RubqO1PG3zwTELtExSqRKhVd
 9TCquPAA2+2gniT1a599GUCRPTqqxZm7CFQhg8hTPc85/rJJ63DBawtenHy4oPa3zxOlphrXO
 RNAaV2MQ2lSVmPYxANutKa33Eh1/CfVN/4iN+v1mVAkpHcLlYu2pIyJyo9nBIXWXuvurSDjhf
 kRdfO6511213s5xzpZs8VXLFqTB619Si6ztdSda7R5pDkkHmkADeAIgQ73YWTUIH4sJMB4WjO
 VBVWEx61yglWKpjWJM5naWXIEPVpIRviFI29xrogdBukgEshLaJ+rP4COd1KKsp9/htFRTA5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279666>

Am 15.10.2015 um 12:11 schrieb Johannes Schindelin:
> 
> This is all technically sound. From a usability perspective I would wish
> more for a way to exclude or filter the lines by a pattern. 

Why not do both?

The only thing that is unfortunate is that the "/" already is a command.

Which would point to either a solution along the lines of "s<range>"
being the split-by-line and "s/" being the split-by-regex?

Or is this an argument for introducing yet another interaction mode
entered when "s" fails to split further -- with simple "/" and "<range>"
being the options in that mode.

Regards,
Sven Helmberger
