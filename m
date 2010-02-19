From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2010, #04; Wed, 17)
Date: Fri, 19 Feb 2010 21:55:20 +0700
Message-ID: <fcaeb9bf1002190655w4af9b244x964847c3d5c08c31@mail.gmail.com>
References: <7veikjefib.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 16:02:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiUN2-0005Ps-L2
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 16:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab0BSPCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 10:02:15 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:59429 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab0BSPCO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 10:02:14 -0500
Received: by pxi29 with SMTP id 29so78538pxi.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ocpF5/1O/Ud5cT/QkQLwwPpk8jtzHNG6tYqGMZtKkGU=;
        b=u89wjkloAa6+5ObHUKT0u2GhQY/f734PpdVCtsejGZNgRSgcrANHwVfcZpzC89ozRw
         XHedn6B/wnnTGU13kGN8aiJEuLrvkqkmh9aMnebkbQhRsMeo3Fzjw3yki4KsoTOuhqkv
         165FVijr2lT94/cYZvaGcC6PXF2Ujc1Fy4ONI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qmm3QRZKOAAMB9BTQ+xCM7DcyrE/FjEqnfDTNBDCyH/ipIJ6lfNexyldh3DFA5xjY5
         AsmDUm8RsbzxrDIwgwO5g7BIBJ7CtsET234xp172wEZhARQcpOcGAoO4Z1BStafnmfBu
         jEQl9O1IB11Fc/KstzBc8cOAbZTQLITuVxLIE=
Received: by 10.114.164.7 with SMTP id m7mr4324561wae.125.1266591320052; Fri, 
	19 Feb 2010 06:55:20 -0800 (PST)
In-Reply-To: <7veikjefib.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140454>

On 2/18/10, Junio C Hamano <gitster@pobox.com> wrote:
>  * nd/root-git (2010-02-14) 5 commits
>   - Add test for using Git at root of file system
>   - Support working directory located at root
>   - Move offset_1st_component() to path.c
>   - init-db, rev-parse --git-dir: do not append redundant slash
>   - make_absolute_path(): Do not append redundant slash
>
>  How does this interact with the much larger series to rework the set-up
>  codepath?

They fix different issues. This one fixes root dir issue. The other
one fixes some code path that tries to access repository when the
repository is not properly found. There is a small conflict in
setup_git_directory_gently(). I plan to split the larger series,
pushing "call setup_git_directory_gently() in run_builtin()" part
first, the rest may come later.
-- 
Duy
