Received: from germ.lanvaux.fr (germ.lanvaux.fr [184.68.159.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0680E6FC3
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.68.159.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672389; cv=none; b=HwSjN2BZeoEq/QfrYpWZhIdEzEQFWoRoDmDxAk5J6g9OpC0+ksNJ0x1fkv27wImj9Ndw+MmAcps+nSduKF4xPfYaq9dIazV38XXqoWlwjGYgfTBS+gH10TAdzc5SGJvIC/N4TaQ1tfsLZCJEVOjkXG7RQZjYqexVZhm7YBu+7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672389; c=relaxed/simple;
	bh=V1VxtCLH/Knrqvlfh886dLcXD+Zm6cT9xrLQpmY8/n4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:Content-Type; b=ERZmOhx6/UcQ2/wGmwLHMR69iGVFb1OY6X7Gfk6qk1ISpbBf3gIcaGt2y1KVKTnMukfR5hoDki1Fcyc1QH7uni57EwFCDklj2dgmQk2yLRDTB56c4cEOqdASrBEvOT5+5mvklwHndu7qIAzAVVfYmUojU6LoFD7dHnKCBBr7uSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanvaux.fr; spf=pass smtp.mailfrom=lanvaux.fr; arc=none smtp.client-ip=184.68.159.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanvaux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanvaux.fr
Received: from germ.lanvaux.fr (localhost [IPv6:::1])
	by germ.lanvaux.fr (Postfix) with ESMTP id 9CB22270659
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:25:51 -0700 (PDT)
Received: from Asus ([207.35.73.116])
	by germ.lanvaux.fr with ESMTPSA
	id T/vPHo8KBmY1PAAAg0nwow
	(envelope-from <germain.lechapelain@lanvaux.fr>)
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:25:51 -0700
Date: Thu, 28 Mar 2024 17:23:30 -0700
From: Germain <germain.lechapelain@lanvaux.fr>
To: git@vger.kernel.org
Subject: File resolution on Windows in gitk
Message-Id: <20240328172330.7fe89edb6efb59b99085da0b@lanvaux.fr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi there!

I am a big fan of=20
 . Windows
 , Git
 . Resolving conflicts (in no particular order.)

I find the out-of-the-box experience of resolving conflicts to be a disaste=
r on Windows:

 o P4Merge doesn't install for me
 o Meld worked (seemingly so far.)  But I do get a big fat error from `gdbu=
s.exe' (whatever this is:) `Procedure DllMain not found in something-libMel=
d' (from my recollection.)

I can have a look on my side,
Sorry to complain I realize those two issues are certainly within there res=
pective other software packages (I complained separately to Helix.)

But I had most fine `WinMerge' installed and redo to go.  And I understand =
this software is `the thing' for file comparison under MS Windows=AE.

Oh and also, I had to add the path to `Meld' in my `PATH' environment varia=
ble. :'(.

Arrivederci!
Hope everyone is having a blast aside from that
Kindest regards,
--=20
Germain <germain.lechapelain@lanvaux.fr>
