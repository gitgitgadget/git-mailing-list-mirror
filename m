From: Nix <nix@esperi.org.uk>
Subject: Re: Possibly-spurious 'not uptodate. Cannot merge'
Date: Sun, 14 Dec 2008 23:15:07 +0000
Message-ID: <87bpve73ic.fsf@hades.wkstn.nix>
References: <874p16puuq.fsf@hades.wkstn.nix>
	<7vwse21rh6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0CW-0004xF-6a
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYLNXPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbYLNXPW
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:15:22 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:47704 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbYLNXPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:15:21 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id mBENFEuA001160;
	Sun, 14 Dec 2008 23:15:14 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id mBENFCcJ012469;
	Sun, 14 Dec 2008 23:15:12 GMT
Emacs: because you deserve a brk today.
In-Reply-To: <7vwse21rh6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun, 14 Dec 2008 11:33:57 -0800")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-sonic.net-Metrics: hades 1117; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103104>

On 14 Dec 2008, Junio C. Hamano said:
> Ancient git, whose "git merge" was a scripted command, refreshed the index
> before starting, but it lost that when the command was rewritten in C soon
> after v1.5.6 by 1c7b76b (Build in merge, 2008-07-07), and nobody noticed
> it until 76c3fb1 (Merge branch 'mv/merge-refresh', 2008-10-09).  In other
> words, the tip of 'master' (and upcoming 1.6.1) already has the fix.

Excellent! I do love this precognitive bugfixing thing.

(It's not as if the update-index workaround is terribly onerous, but
it's annoying and not something a git newbie might think of.)
