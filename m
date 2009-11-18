From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Wed, 18 Nov 2009 15:59:01 +0100
Message-ID: <200911181559.02873.trast@student.ethz.ch>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm> <200911151807.15726.trast@student.ethz.ch> <4B033D8F.1080309@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>,
	<gitster@pobox.com>, <skillzero@gmail.com>
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Nov 18 16:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAm1M-0008TI-VV
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 16:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZKRPAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 10:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbZKRPAT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 10:00:19 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:39437 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbZKRPAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 10:00:17 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 18 Nov
 2009 16:00:08 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 18 Nov
 2009 15:59:47 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <4B033D8F.1080309@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133181>

Raman Gupta wrote:
> 
> I *am* a native English speaker. Sadly, its the *only* language I
> speak, read, and write. However, additional comments would
> definitely be nice.

Oh, my apologies.  I just looked at the names and jumped to
conclusions from there.

> Agree. I reworded the sections to untangle the information
> somewhat. Let me know what you think.
[...]
>  * `git merge --ff-only master`
>  =====================================
>  
[...]
> +If the merge fails because it is not a fast-forward, then it is
> +possible some fixes on 'maint' were missed in the feature release.
> +This will not happen if the content of the branches was verified as
> +described in the previous section.

Yes, I think that is nicer.  It's no longer a repetition of what was
said above, but merely points out what could have gone wrong and where
to look for advice.  The last sentence sounds a bit like "ha ha we
told you so!" though ;-)

FWIW, you can add my

  Acked-by: Thomas Rast <trast@student.ethz.ch>

to the final (squashed) patch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
