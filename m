From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] Support for arbitrary tags in commits
Date: Tue, 11 Jan 2011 13:40:50 +0100
Message-ID: <201101111340.50508.trast@student.ethz.ch>
References: <74b0628dffbd2bc0adabe5e8b0a10960.squirrel@webmail.hitco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Philipp Marek <philipp@marek.priv.at>
X-From: git-owner@vger.kernel.org Tue Jan 11 13:41:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcdWz-0001W0-FA
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 13:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab1AKMkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 07:40:53 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:25184 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab1AKMkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 07:40:52 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 13:40:48 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 13:40:50 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <74b0628dffbd2bc0adabe5e8b0a10960.squirrel@webmail.hitco.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164935>

Philipp Marek wrote:
> 
> The best way I've found (so far) is to put an additional header line in the
> commit header that references an additional blob.

This comes up every few months.  The last large discussion about this
that we had IIRC was

  http://thread.gmane.org/gmane.comp.version-control.git/138848

Can you please look through that thread and state in what way your
use-case invalidates the previous reasoning?

In particular, in what way do notes (as in git-notes(1)) fail to solve
your problem?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
