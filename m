From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Fri, 14 Nov 2014 11:24:23 +0100
Message-ID: <20141114102423.GB24351@paksenarrion.iveqy.com>
References: <20141113111444.GA15503@aepfle.de>
 <20141113154457.GA31624@aepfle.de>
 <20141113160325.GA24351@paksenarrion.iveqy.com>
 <20141114101427.GA1548@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Fri Nov 14 11:18:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpDx6-0002wr-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 11:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934378AbaKNKSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2014 05:18:00 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33272 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049AbaKNKR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 05:17:59 -0500
Received: by mail-lb0-f171.google.com with SMTP id b6so12569212lbj.16
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 02:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pbRw89z5a5vyhuSpCFz8DoztueKbvIDjAL7Dxw6ukdE=;
        b=I1yhktrvixyaMXBz0xuYDaNXDQPJG3Y+NvXlu8uXfTYw3/eeF1OOzUpBaFrIe6dpjU
         DfuAkmX6XPKsFsCPFpAFXRs/7Lq6FN+x6yYhhQMw9BSb4ZpAagW/4oYO0V8pl1R+z1Rm
         HhtB+0ienszd8rw+4Ovw2MgmKwcv2NNzYPDenKWzawm52x4sal6EE0o7WPk5uPVMdwYo
         MwmpBgMIJJ4LleP3CydmF/cr9ubaNsTJ1bIx4yBUdk+MyKyJn0ZmYsvM/3tMp8cUNHIv
         +8GeCfWDjJZsWexfyWN4Ygi4fpPcPIrN/1wHy9kXDoCZXFhSYSSnI1GsfVVRY6e9aHB3
         jmhg==
X-Received: by 10.152.120.133 with SMTP id lc5mr7477448lab.62.1415960277488;
        Fri, 14 Nov 2014 02:17:57 -0800 (PST)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id g2sm8108641lbd.35.2014.11.14.02.17.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2014 02:17:56 -0800 (PST)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1XpE3E-0002x0-0V; Fri, 14 Nov 2014 11:24:24 +0100
Content-Disposition: inline
In-Reply-To: <20141114101427.GA1548@aepfle.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 11:14:27AM +0100, Olaf Hering wrote:
> So my repo-master is now "bare". I pushed from repo-branchA into
> repo-master and see my commits in both repos. But pushing from
> repo-master to the remote fails because repo-master does not have
> outstanding remote commits. However, git fetch doesnt do anything:

Are you mixing up your branches? So that you're updating one branch in
your master repo but trying to push an other branch to your remote repo=
?

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
