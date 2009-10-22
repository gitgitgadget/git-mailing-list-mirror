From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git describe is failing
Date: Thu, 22 Oct 2009 17:02:37 +0200
Message-ID: <200910221702.39452.trast@student.ethz.ch>
References: <76c5b8580910220747w709d2b41s4f7b121e421e843c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 17:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0zCD-000078-Fa
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 17:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887AbZJVPDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbZJVPDL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 11:03:11 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:3057 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754666AbZJVPDK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 11:03:10 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 17:03:13 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 17:03:13 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <76c5b8580910220747w709d2b41s4f7b121e421e843c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131024>

Eugene Sajine wrote:
> $ git describe
> 
> gives:
> 
> fatal: cannot describe 'SHA-1'

man git-describe:

DESCRIPTION
       The command finds the most recent tag that is reachable from a
       commit.
[...]
       By default (without --all or --tags) git describe only shows
       annotated tags. For more information about creating annotated
       tags see the -a and -s options to git-tag(1).

If there is no such tag, it refuses to work.  Annotate your tags, or
try --always.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
