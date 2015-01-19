From: Maximilian Held <maximilian.held83@gmail.com>
Subject: git --recurse-submodule does not recurse to sub-submodules (etc.)
Date: Mon, 19 Jan 2015 21:19:12 +0100
Message-ID: <CACgLhq_kMv2cj4RHr8Yx5tnYup5enCJVMrZf9Yt9Y5-bkfozLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 21:20:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDInn-0001Xi-6B
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 21:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbbASUT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 15:19:56 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:43946 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbASUTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 15:19:54 -0500
Received: by mail-lb0-f179.google.com with SMTP id z11so30132428lbi.10
        for <git@vger.kernel.org>; Mon, 19 Jan 2015 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=PoFTNhFS1Ly7KlUvQy8SDUmWD8t4MTwwd+SPc3nozD8=;
        b=rfO357Tpv1pGCI/jZ0zE/GhcTpg9X1PzxBKBYKHYOh2IAXcp8vtyxezjrylbP3Kpvn
         LbmH68L0TFSZmqbUzMfovgjtj0TXV2t3q1+JaEDSSafp23LBneie5KzfLNsr+1Tb3DnN
         AiADoQ5pIB0LBmmwcL5QM3cbl/D3lu9nLDlaEBGxvrax/DGUstARoWH5PO3NnBM5j6ti
         2XA8GHzptXNEdhht9oaXT+66b8z9inGbMT/DFsOly9Yklt9834hmzdEMIUKQlikTrfrC
         tHLLJL5Tti3gY/GulqKPdDuSCv26VO/WBmVrPFKKO56bJwApdK/d9Vrmk7CDEBuGeZ9D
         DmOA==
X-Received: by 10.152.7.180 with SMTP id k20mr20680841laa.4.1421698792604;
 Mon, 19 Jan 2015 12:19:52 -0800 (PST)
Received: by 10.25.129.203 with HTTP; Mon, 19 Jan 2015 12:19:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262642>

I have a directory with nested submodules, such as:

supermodule/submodule/sub-submodule/sub-sub-submodule

When I cd to supermodule and do:

"git push --recurse-submodule=check" (or on-demand),

git only pushes the submodule, but not the sub-submodule etc.

Maybe this is expected behavior and not a bug, but I thought it was
pretty unintuitive. I expected that git would push, well, recursively.

Best
Max

http://www.maxheld.de
