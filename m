From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Use the --submodule option for diffs
Date: Wed, 28 Oct 2009 15:03:20 +1100
Message-ID: <19175.49800.697048.349753@drongo.ozlabs.ibm.com>
References: <4AE70AC9.6040302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 05:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2zl4-0003LD-B0
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 05:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbZJ1ED1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 00:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbZJ1ED1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 00:03:27 -0400
Received: from ozlabs.org ([203.10.76.45]:37668 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbZJ1ED0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 00:03:26 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 17AC2B7BE2; Wed, 28 Oct 2009 15:03:31 +1100 (EST)
In-Reply-To: <4AE70AC9.6040302@web.de>
X-Mailer: VM 8.0.12 under 22.3.1 (powerpc-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131403>

Jens Lehmann writes:

> Instead of just showing not-quite-helpful SHA-1 pairs display the first
> lines of the corresponding commit messages in the submodule (similar to
> the output of 'git submodule summary').
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> 
> This patch applies to 'next' and uses the new --submodule option of git
> diff to achieve a more meaningful output of submodule differences in
> gitk.

(That sentence should have been in the commit message.)

> Any objections against making this the default?

What version of git is the first to have the --submodule option?
Since it's a new option we should make gitk use it only if the
underlying git is new enough, like we do with the --textconv option.

Also, the commit message is a bit sparse; it doesn't mention that this
affects the diff display, for instance.

Paul.
