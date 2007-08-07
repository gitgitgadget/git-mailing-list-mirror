From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 8 Aug 2007 01:20:14 +0200
Message-ID: <16E4650F-5046-4F8D-A88B-2AE48BC5E446@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net> <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com> <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> <alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org> <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 01:19:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIYKz-0001M5-0C
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 01:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbXHGXTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 19:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbXHGXTh
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 19:19:37 -0400
Received: from mailer.zib.de ([130.73.108.11]:34775 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbXHGXTh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 19:19:37 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l77NJSYE025586;
	Wed, 8 Aug 2007 01:19:28 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.245.91])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l77NJRTW006346
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Aug 2007 01:19:27 +0200 (MEST)
In-Reply-To: <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55286>

I apologize, I didn't check the size of the attachment
in the previous mail (which probably got blocked from
the list).

This time with a link to the logfile.


On Aug 8, 2007, at 12:46 AM, Steffen Prohaska wrote:

> The tests are running. t0000-basic and t0010-racy-git pass. I'll
> send a testlog later. It's running inside a virtual machine on a
> laptop, so it may take some more time.
>
> I suspect the tests will report a lot of errors. At least all
> tests that compare 'echo' output with precomputed sha1's or
> expected results that come with the tests should fail. I haven't
> fully understood the details of line conversion of cygwin. Some
> work may be needed to eliminate false fails from the tests, e.g. by
> adding 'd2u', and find the real problems.

I attached the log of a testrun on an textmode mounted directory
in cygwin with the two recently sent patches applied.

It doesn't look too bad, but it's far from perfect:

1470 ok to 637 FAIL

http://www.zib.de/prohaska/hidden/2007/git-cygwin-textmode/ 
testlog-2007-08-08.txt

	Steffen
