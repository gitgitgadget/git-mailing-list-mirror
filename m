From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] rebase -i: handle fixup of root commit correctly
Date: Tue, 31 Jul 2012 23:47:05 +0100
Message-ID: <20120731224704.GD2823@arachsys.com>
References: <20120724121703.GG26014@arachsys.com>
 <5017A1E4.1070800@kdbg.org>
 <20120731111938.GD19416@arachsys.com>
 <20120731124824.GC14028@arachsys.com>
 <50183A4C.9080706@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 00:47:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLDg-0002pZ-2I
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 00:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab2GaWrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 18:47:11 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:34394 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab2GaWrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 18:47:10 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SwLDZ-0000pF-2m; Tue, 31 Jul 2012 23:47:09 +0100
Content-Disposition: inline
In-Reply-To: <50183A4C.9080706@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202689>

Johannes Sixt <j6t@kdbg.org> writes:

> One subtlety to watch out for is when commit messages are edited. That is,
> if you edit the proposed message at 'rebase --continue' after the first
> squash failed, is the new text preserved until the last squash? I *think*
> that previously that was the case.

Hi. Yes, doing this seems to work fine both in the original code, and after
my patch. I've just checked to be certain using my previous test case of
four conflicting squashes again, editing the message at each stage and
ensuring the edits are all retained in the final commit.

Best wishes,

Chris.
