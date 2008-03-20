From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Two bugs with renaming
Date: Wed, 19 Mar 2008 21:30:17 -0500
Message-ID: <200803192130.17649.jgoerzen@complete.org>
References: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org> <7vwsnyz07y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 03:31:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcAYs-0003Io-PF
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 03:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbYCTCai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 22:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbYCTCai
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 22:30:38 -0400
Received: from b01s02mr.corenetworks.net ([64.85.160.192]:46304 "EHLO
	glockenspiel.complete.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYCTCah (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 22:30:37 -0400
Received: from 63-245-179-205.kitusa.com ([63.245.179.205] helo=erwin.lan.complete.org)
	by glockenspiel.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(TLS peer CN erwin.complete.org, certificate verified)
	(Exim 4.63)
	id 1JcAXu-0004zD-C8; Wed, 19 Mar 2008 21:30:29 -0500
Received: from katherina.lan.complete.org ([10.200.0.4])
	by erwin.lan.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(No TLS peer certificate)
	(Exim 4.67)
	id 1JcAXq-0006Lt-3j; Wed, 19 Mar 2008 21:30:18 -0500
Received: from jgoerzen by katherina.lan.complete.org with local (Exim 4.69)
	(envelope-from <jgoerzen@complete.org>)
	id 1JcAXp-0004k0-Ls; Wed, 19 Mar 2008 21:30:17 -0500
User-Agent: KMail/1.9.7
In-Reply-To: <7vwsnyz07y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Spam-Status: No (score 0.2): AWL=0.163
X-Virus-Scanned: by Exiscan on glockenspiel.complete.org at Wed, 19 Mar 2008 21:30:29 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77615>

On Wednesday 19 March 2008 7:51:45 pm Junio C Hamano wrote:
> John Goerzen <jgoerzen@complete.org> writes:
> > # Now here comes bug #1...
>
> Please try 1.5.5-rc0 or newer.  I think Linus's unpack_trees() updates,
> even though it was sort of a rocky road to get there, addresses this.
>
> Namely, v1.5.5-rc0~25 was the commit that fixed this issue.

Correct, bug #1 is gone with current git master.

>
> > # Set up bug #2
>
> This hasn't been addressed, I think.

Also correct.  Bug #2 is still present with current git master.  It shows:

jgoerzen@katherina:/tmp/testrepo$ git merge master
error: Entry 'files.upstream/delete.me' would be overwritten by merge. Cannot 
merge.
fatal: merging of trees 5cec043802758b3a4cd617905c395a9f12bf89a2 and 
9671b5181cb0649f39cfae372af1aed56a24010d failed
Merge with strategy recursive failed.

Is there any other information I can provide to assist with tracking that one 
down?

-- John
