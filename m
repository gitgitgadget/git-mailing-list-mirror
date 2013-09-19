From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git issue / [PATCH] MIPS: fix invalid symbolic link file
Date: Thu, 19 Sep 2013 21:49:50 +0200
Message-ID: <523B555E.2070508@kdbg.org>
References: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com> <20130919133920.GA22468@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree@vger.kernel.org, git@vger.kernel.org,
	steven.hill@imgtec.com, mmarek@suse.cz, swarren@nvidia.com,
	linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
	james.hogan@imgtec.com
To: Ralf Baechle <ralf@linux-mips.org>
X-From: git-owner@vger.kernel.org Thu Sep 19 21:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMkEh-0004FD-1R
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 21:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab3ISTtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 15:49:55 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:20213 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab3ISTty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 15:49:54 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E9564CDF8B;
	Thu, 19 Sep 2013 21:49:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4F8D019F3F7;
	Thu, 19 Sep 2013 21:49:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130919133920.GA22468@linux-mips.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235027>

Am 19.09.2013 15:39, schrieb Ralf Baechle:
> The original patch that introduced the symlink with the \n is kernel
> commit 3b29aa5ba204c62b3ec8f9f5b1ebd6e5d74f75d3 and is archived in
> patchwork at http://patchwork.linux-mips.org/patch/5745/  The patch
> file contains a \n at the end - but one would expect that from a
> patch file that has been transfered via email, so I'm not sure how this
> is supposed to work with emailed patches?!?

The mbox file I downloaded from this link looks like this:


arch/mips/boot/dts/include/dt-bindings | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 arch/mips/boot/dts/include/dt-bindings

\ No newline at end of file

diff --git a/.../include/dt-bindings b/.../include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/mips/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings


but it should look like this:


arch/mips/boot/dts/include/dt-bindings | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 arch/mips/boot/dts/include/dt-bindings

diff --git a/.../include/dt-bindings b/.../include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/mips/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file


Whoever or whatever moved the '\ No newline at end of file' line above
the patch text is to blame.

-- Hannes
