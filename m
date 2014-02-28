From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 03:11:00 -0600
Message-ID: <8538j31u1n.fsf@stephe-leake.org>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:11:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJTh-0002jT-BO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbaB1JLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:11:25 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:33024 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750844AbaB1JLV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 04:11:21 -0500
Received: from [75.87.81.6] ([75.87.81.6:53582] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 3B/04-02678-7A250135; Fri, 28 Feb 2014 09:11:20 +0000
In-Reply-To: <530FBB1D.3050505@gmail.com> (Karsten Blees's message of "Thu, 27
	Feb 2014 23:24:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242914>

Karsten Blees <karsten.blees@gmail.com> writes:

> If I understand the issue correctly, the problem is that packed-refs
> are always case-sensitive, even if core.ignorecase=true. 

Perhaps that could be changed? if core.ignorecase=true, packed-refs
should be compared with case-insensitive string compares.

-- 
-- Stephe
