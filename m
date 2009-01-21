From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 15:02:09 +0200
Message-ID: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 14:04:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPck4-0007NO-Sp
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 14:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbZAUNCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 08:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbZAUNCM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 08:02:12 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:44723 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbZAUNCM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 08:02:12 -0500
Received: by bwz14 with SMTP id 14so12648573bwz.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ybNL1hIklRp90ZGpTjliqqYTWp1EBsDskjueLpRikqk=;
        b=WRqFhy4f7Hzaa9UTPsKbuJcw2utySREnO/srgBxd6tFjpuYDV5Sq0dChrGpZXgLRmp
         pxy3BMXAjfD2PfqVoIiZam2QKRzfsSs8CeCmSLH3H/EklXx5m4QEHw7X+W5uCI3tcMmX
         pCFBaajM6aL2IBIpddPMLwnj1iulcpgZoizFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=u75d8OG+o+YGbcn+/csJc/Wna0vVRByV9xLOVzqZqsHlZq8D/unbRlUmGwNLHtRpTe
         x2MdiAdpkn5B8rRtmuUQyBpKw2iBZjIkeKmZAZW88Muds3QDtrEz0c9Gvh9lpcOrByOR
         55dV5I5ZAN2NtN/HnwSexjnTbQ5vBhO0yJb1A=
Received: by 10.86.68.2 with SMTP id q2mr1288447fga.3.1232542929860; Wed, 21 
	Jan 2009 05:02:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106603>

Hi

I deleted a remote branch which was pointed by HEAD, this way: "git
push origin :master"

Then for almost every git command, I get this error: "error:
refs/remotes/origin/HEAD points nowhere!".

I found this situation non-friendly. Fortunately, I could understand
what's going on. But a new user might be confused.

Shouldn't the remote HEAD branch be updated or "protected" in some
ways? Or should the "error" be considered as a "warning" (silently?)

What do you think?

regards,

--=20
Marc-Andr=E9 Lureau
