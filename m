From: Nix <nix@esperi.org.uk>
Subject: Re: [PATCH na/strtoimax] Compatibility: declare strtoimax() under NO_STRTOUMAX
Date: Sat, 05 Nov 2011 15:38:22 +0000
Message-ID: <87ty6i1swh.fsf@spindle.srvr.nix>
References: <4EB5583E.2030306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 17:25:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMj3Q-0002DS-47
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab1KEQZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:25:05 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:51411 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab1KEQZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:25:04 -0400
X-Greylist: delayed 2795 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Nov 2011 12:25:04 EDT
Received: from esperi.org.uk (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.5/8.14.5) with ESMTP id pA5FcMPP024189;
	Sat, 5 Nov 2011 15:38:22 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.14.5/8.14.5/Submit) id pA5FcMq3011090;
	Sat, 5 Nov 2011 15:38:22 GMT
Emacs: anything free is worth what you paid for it.
In-Reply-To: <4EB5583E.2030306@kdbg.org> (Johannes Sixt's message of "Sat, 05
	Nov 2011 16:37:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.90 (gnu/linux)
X-DCC-URT-Metrics: spindle 1060; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184858>

On 5 Nov 2011, Johannes Sixt said:

> Commit f696543d (Add strtoimax() compatibility function) introduced an
> implementation of the function, but forgot to add a declaration.

Oh, my apologies. (How did my testing miss that? No -Wall, I bet.)

-- 
NULL && (void)
