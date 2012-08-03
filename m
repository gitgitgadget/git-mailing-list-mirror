From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC 0/16] Introduce index file format version 5
Date: Fri, 3 Aug 2012 11:13:47 +0200
Message-ID: <87pq785odw.fsf@thomas.inf.ethz.ch>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <mhagger@alum.mit.edu>, <gitster@pobox.com>,
	<pclouds@gmail.com>, <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 11:13:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxDxD-00082Q-OP
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 11:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab2HCJNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 05:13:51 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:55993 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab2HCJNu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 05:13:50 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 11:13:42 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 11:13:47 +0200
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Thu, 2 Aug 2012 13:01:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202824>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> [PATCH 01/16] Modify cache_header to prepare for other index formats
> [PATCH 02/16] Modify read functions to prepare for other index
> [PATCH 03/16] Modify match_stat_basic to prepare for other index
> [PATCH 04/16] Modify write functions to prepare for other index
> [PATCH 05/16] t2104: Don't fail when index version is 5
> [PATCH 06/16] t3700: sleep for 1 second, to avoid interfering with
> [PATCH 07/16] Add documentation of the index-v5 file format
> [PATCH 08/16] Make in-memory format aware of stat_crc
> [PATCH 09/16] Read index-v5
> [PATCH 10/16] Read resolve-undo data
> [PATCH 11/16] Read cache-tree in index-v5
> [PATCH 12/16] Write index-v5
> [PATCH 13/16] Write index-v5 cache-tree data
> [PATCH 14/16] Write resolve-undo data for index-v5
> [PATCH 15/16] update-index.c: add a force-rewrite option
> [PATCH 16/16] p0002-index.sh: add perf test for the index formats

I haven't had time for more than a cursory look yet, but good job on the
splits.  This is a large improvement over what you had in Zurich!

One thing that you need to be more careful about is attribution of the
source code.  Credit is very important because it's the only thing
people get for their OSS work.  For some patches you received lots of
input and help by many people.  For example, the documentation patch
that casts the format in stone (or will, when it's finished), should
have "Helped-by:" for *at least* Michael, Junio, and Duy.  You should
dig in the ML archives for other people who may have contributed ideas.

Also, anything that contains nontrivial code from me needs my S-o-b; off
the top of my head that's just 16/16, which AFAICS is even completely
unchanged (!) and needs to come with a From (and my S-o-b).  (I'm not
going to be anal about any of the work we did in Zurich, let's just
classify that as "help" like above.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
