From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Tue, 11 Jan 2011 07:03:42 +0700
Message-ID: <AANLkTimh1RRnjXjg-fw_-RQxNW_fLbSYis8n2BvNaCc+@mail.gmail.com>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <AANLkTinc12H01Us1mkKieZo75hwjgTCZth_wFvRNscMq@mail.gmail.com> <4D2B3643.2070106@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Wyzer <john.wyzer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 11 01:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcRim-0004dc-1U
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 01:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab1AKAEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 19:04:15 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46912 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab1AKAEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 19:04:14 -0500
Received: by wyb28 with SMTP id 28so19942647wyb.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 16:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=9QW70nSkzKaYxRQ0INLok9sGp0YLH/3A0yWAa+chcl0=;
        b=aRMtotTq3fRAD0PXrP4o1vwRPaVsP8LaMWuqk1jlHtOE3v8wDtkf6f4Wwl5M3j0Ezu
         SFzIS+NNusuqk0YIuTFK5uo8gyB6VfBnQ1rVBDu9GA+kB9MF5v20d2I/64t47I8JIxRL
         Mdd015D0E7n6PNsfGTO0jx/Y6wz/GStTY13hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Rl3a5kKN6LIu18uKIOm4iltTyEGdIuj5LWDS03GdtiA+sxCK5aJzsHvl2S1UCvlCMn
         bzEjxJrMm23mAs3t19Pv2+Z2Nu+VTa+Jh89OiebxDM+StsMDU/mvgaODBASMle0kbiAL
         bU8syrCp56mmW9gzPmLoXI1xZnFEKt41vQVZo=
Received: by 10.216.52.134 with SMTP id e6mr199945wec.49.1294704253090; Mon,
 10 Jan 2011 16:04:13 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Mon, 10 Jan 2011 16:03:42 -0800 (PST)
In-Reply-To: <4D2B3643.2070106@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164904>

On Mon, Jan 10, 2011 at 11:39 PM, John Wyzer <john.wyzer@gmx.de> wrote:
> Why not provide an alternative mode for the git:// protocoll that instead of
> retrieving a big packaged blob breaks this down to the smallest atomic
> objects from the repository? Those are not changing and should be able to
> survive partial transfers.
> While this might not be as efficient network traffic-wise it would provide a
> solution for those behind breaking connections.

That's what I'm getting to, except that I'll send deltas as much as I can.
-- 
Duy
