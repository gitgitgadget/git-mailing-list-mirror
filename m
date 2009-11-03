From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: Use the --submodule option for displaying diffs
 when available
Date: Tue, 3 Nov 2009 22:32:16 +1100
Message-ID: <19184.5312.712632.894685@cargo.ozlabs.ibm.com>
References: <4AE70AC9.6040302@web.de>
	<19175.49800.697048.349753@drongo.ozlabs.ibm.com>
	<4AE82DBD.5070202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 12:33:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Hdg-00020U-BO
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 12:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbZKCLdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 06:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbZKCLdJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 06:33:09 -0500
Received: from ozlabs.org ([203.10.76.45]:56770 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbZKCLdH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 06:33:07 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 50E0BB7B9C; Tue,  3 Nov 2009 22:33:08 +1100 (EST)
In-Reply-To: <4AE82DBD.5070202@web.de>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131965>

Jens Lehmann writes:

> Instead of just showing not-quite-helpful SHA-1 pairs in the diff display
> of a submodule gitk will display the first lines of the corresponding
> commit messages (similar to the output of 'git submodule summary') when
> the underlying git installation supports this. That makes it much easier
> to evaluate the changes, as it eliminates the need to start a gitk inside
> the submodule and use the superprojects hashes there to find out what the
> commits are about.
> 
> This patch applies to 'next' - which will be 1.6.6 or 1.7.0 when merged -
> and uses the new --submodule option of git diff when a version of 1.6.6 or
> higher is detected to achieve a more human readable output of submodule
> differences in gitk.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>

Thanks, applied.

Paul.
