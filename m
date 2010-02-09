From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Support working directory located at root
Date: Tue, 9 Feb 2010 09:49:54 +0700
Message-ID: <fcaeb9bf1002081849m5aacc55fo52e5119548d8d704@mail.gmail.com>
References: <1265640810-6361-1-git-send-email-pclouds@gmail.com> 
	<7v8wb3pqqw.fsf@alter.siamese.dyndns.org> <fcaeb9bf1002081818s53f8646ev80afbaa37f039e50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 03:50:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NegBD-0004fH-9D
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 03:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab0BICuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 21:50:16 -0500
Received: from mail-px0-f202.google.com ([209.85.216.202]:43340 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab0BICuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 21:50:14 -0500
Received: by pxi40 with SMTP id 40so6996548pxi.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 18:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=b7wxoiHG9jlo9R3RK1CUoDCDH4h8WSlTS2z/cjPZksk=;
        b=eowJl0dJvQshAV0DMhCd3LqfVpmiP3BcwelKwlZuVuuxFWZmV4vsHGWVz7N2NpiaNn
         rnrg4ylSRNgPxKV2i70m7IRV4CHXBOToUgnBRzRwNkAC/A0ulVXGuVmlgjSzp0szd5Cz
         xfYSATW/zCekwBFN0WpTCkimNmy/FeMcQrMPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EJQuqEAmK7N4Vtbjfa4ueAptIiJ051H/03aGon6cnUa89BAIy6A6Xp7XMSqEAiOs85
         ibUElxRDxP78LN/068zVeAVd3LsguV3m85Xh7WvBL0Qyf3HALzmYdjbKlQc9rs1R8Zfd
         quub8sPXU8ArUzsN743Jps4HqRX3Pk2DXJO/Q=
Received: by 10.115.38.27 with SMTP id q27mr5016900waj.58.1265683814109; Mon, 
	08 Feb 2010 18:50:14 -0800 (PST)
In-Reply-To: <fcaeb9bf1002081818s53f8646ev80afbaa37f039e50@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139349>

2010/2/9 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> But I suspect my change in this code is not enough and caused
> the problem (on msys?) for Hannes. If the worktree somehow is '//' and
> sanitized is '/etc/resolv.conf', then we could end up eating two
> chars, leading to "'tc/resolv.conf' not match" error.
>
> Hannes, can you put a "printf("%s\n", work_tree);" in prefix_path() to
> see if it's the case?

Silly me. You used relative path, so that code path was untouched.
-- 
Duy
