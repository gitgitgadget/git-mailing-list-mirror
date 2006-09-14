From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 19:08:49 +0200
Organization: At home
Message-ID: <eec2aa$9c9$2@sea.gmane.org>
References: <45084400.1090906@bluegap.ch>	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>	<450872AE.5050409@bluegap.ch>	<9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>	<4508EA78.5030001@alum.mit.edu>
	<20060914155003.GB9657@spearce.org>	<eebuih$u32$1@sea.gmane.org>
	<9e4733910609140927y30ecaa42wae0ff0597b8c3842@mail.gmail.com>
	<45098AE0.6030409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8Bit
Cc: dev@rapidsvn.tigris.org, git@vger.kernel.org
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 19:09:39 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNuiM-0005SP-5H
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 19:09:26 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNuiL-0004mr-KD
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 13:09:25 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNuiH-0004mH-Sf
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:09:21 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNuiG-0004kf-Ak
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:09:21 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNuiG-0004kX-73
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:09:20 -0400
Received: from [80.91.229.2] (helo=ciao.gmane.org)
	by monty-python.gnu.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.52) id 1GNukF-0003mh-2l
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:11:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNuhr-0005Ks-E2
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 19:08:55 +0200
Received: from 193.0.122.19 ([193.0.122.19])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <monotone-devel@nongnu.org>; Thu, 14 Sep 2006 19:08:55 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <monotone-devel@nongnu.org>; Thu, 14 Sep 2006 19:08:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: monotone-devel@nongnu.org
Followup-To: gmane.comp.version-control.monotone.devel
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27015>

Michael Haggerty wrote:

> Alternatively, there was a suggestion to add heuristics to guess which
> files' "unlabeled" branches actually belong in the same original branch.
>  This would be a lot of work, and the result would never be very
> accurate (for one thing, there is no evidence of the branch whatsoever
> in files that had no commits on the branch).
> 
> Other ideas are welcome.

Interpolate the state of repository according to timestamps, with some
coarse-grainess of course.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
