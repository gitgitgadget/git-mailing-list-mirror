From: Junio C Hamano <gitster@pobox.com>
Subject: Re: still getting 'It is a submodule!" in 1.6.2.5
Date: Mon, 04 May 2009 23:43:50 -0700
Message-ID: <7vy6tc2gnt.fsf@alter.siamese.dyndns.org>
References: <gtnjq8$317$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Olsen <tim@brooklynpenguin.com>
X-From: git-owner@vger.kernel.org Tue May 05 09:05:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1Eie-00038Z-Jr
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 09:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbZEEHFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 03:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbZEEHFT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 03:05:19 -0400
Received: from fed1rmpop111.cox.net ([68.230.241.15]:43774 "EHLO
	fed1rmpop111.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbZEEHFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 03:05:18 -0400
X-Greylist: delayed 1285 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2009 03:05:17 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090505064353.TLGZ20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 May 2009 02:43:53 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id nijs1b00B4aMwMQ04ijs0n; Tue, 05 May 2009 02:43:52 -0400
X-Authority-Analysis: v=1.0 c=1 a=8WGyEpsri2sA:10 a=SlXtjvdOSMcA:10
 a=N0RfpVYEAAAA:8 a=3yxCBVDzN5hyDYD6Ae8A:9 a=KBwNTxmxrMdf91B3QRuKN3mWEAAA:4
 a=3-d7yPayk80A:10
X-CM-Score: 0.00
In-Reply-To: <gtnjq8$317$1@ger.gmane.org> (Tim Olsen's message of "Mon\, 04 May 2009 16\:39\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118280>

Tim Olsen <tim@brooklynpenguin.com> writes:

> Clemens replied with a patch [2], but I don't think it got into git's git.
>
> Junio replied with two versions of a patch [3, 4], of which one of them
> appears to have made it into git's git as commit
> 7dae8b21c2fe39a59661c709f0dc17090dafa5a4
>
> 1.6.2.5 was then released yesterday which has commit
> 7dae8b21c2fe39a59661c709f0dc17090dafa5a4.

But that is not the one you want.  7dae8b2 (diff -c -p: do not die on
submodules, 2009-04-29) is to allow viewing of such a merge correctly; To
make the merge automatically, you'd need 0c44c94 (merge-recursive: do not
die on a conflicting submodule, 2009-04-29), which is on 'master', but not
on 1.6.2.X (and likely will never be).

Could you be running 1.6.3-rcX instead of 1.6.2.X?  In general, the tip of
the 'master' is always as stable as any released version, if not more.
