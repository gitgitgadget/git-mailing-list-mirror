From: Frans Pop <elendil@planet.nl>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 16:39:43 +0100
Message-ID: <201001271639.44167.elendil@planet.nl>
References: <201001270819.39819.elendil@planet.nl> <20100127101943.GA4470@progeny.tock> <E1Na9ca-0004x2-Gf@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dale Farnsworth <dale@farnsworth.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 16:40:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Na9zt-0003Vn-CR
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 16:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab0A0Pjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 10:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328Ab0A0Pjr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 10:39:47 -0500
Received: from cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:53625 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754777Ab0A0Pjq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 10:39:46 -0500
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML110.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 27 Jan 2010 16:39:44 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <E1Na9ca-0004x2-Gf@xyzzy.farnsworth.org>
Content-Disposition: inline
X-OriginalArrivalTime: 27 Jan 2010 15:39:44.0571 (UTC) FILETIME=[F2FE40B0:01CA9F66]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138159>

On Wednesday 27 January 2010, Dale Farnsworth wrote:
> I've been using the following.  It produces output only if the commit
> is NOT in HEAD.
>
> git rev-list -1 ^HEAD commitID

Nice. That does work.

Returns 0 in both cases and you'd need to allow for nonexisting commit IDs, 
so you'd get:
   test -z "$(git rev-list -1 ^HEAD <commit id> 2>/dev/null)"

Time needed looks to be slightly faster than Junio's test.

Thanks,
FJP
