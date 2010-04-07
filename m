From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 02:37:20 -0700 (PDT)
Message-ID: <m31veriozm.fsf@localhost.localdomain>
References: <loom.20100406T161552-321@post.gmane.org>
	<vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
	<4BBB53F5.9010106@op5.se>
	<q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
	<v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
	<alpine.LFD.2.00.1004061705390.7232@xanadu.home>
	<4BBC1E15.9040403@gmail.com>
	<20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
	<4BBC3EEC.6010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Vitaly <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 11:37:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzRhT-0003X3-VQ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 11:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab0DGJh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 05:37:27 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:43780 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab0DGJhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 05:37:25 -0400
Received: by bwz1 with SMTP id 1so628729bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=tBU+1ply5C4NrbogMukvJIz7Zgwj37kIwfnXpLcjWcw=;
        b=d6zqRjpAGVfHKNlO/tdw1l7kuCnMiuYwA86QpEBfdud+oDIgid/AHogJcCDNHPV6y2
         GbTS+Y8giKLBOdwOYu2auXxm3NQ06R+Dm6pEHn4gNDYs15ukSiKGPjx2sG5Jz5X4qdNy
         x4eA+Y0ZvuWILTdPvZqepP0fcAY0Txmgx87FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OTERibpJ07MuEky/aGTD6Qicg8NammScVWh5CAttopVPfddPvFv1jLHmYUxQ4qzgZp
         dKXG3lSbNuwiZAmMwtSODXhGD5gm579b0N37/XEJ/BVphyPg/FaAI4W9OFB7triZoOZZ
         EHWy7bXgerV50aj62OTDsPziNgJXY9N80WTew=
Received: by 10.204.137.81 with SMTP id v17mr1198094bkt.93.1270633042900;
        Wed, 07 Apr 2010 02:37:22 -0700 (PDT)
Received: from localhost.localdomain (abvp11.neoplus.adsl.tpnet.pl [83.8.213.11])
        by mx.google.com with ESMTPS id 15sm7158433bwz.8.2010.04.07.02.37.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 02:37:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o379aP6F005782;
	Wed, 7 Apr 2010 11:36:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o379Zv1L005777;
	Wed, 7 Apr 2010 11:35:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BBC3EEC.6010702@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144209>

Please do not toppost.

Vitaly <vitaly.berov@gmail.com> writes:

> Too bad..
> Yes, we really have a very large repo with binary files.
> 
> So, as far as I understand, the fastest way is to use rsync or smth
> like this instead of "git clone".
> 
> P.S. Btw, how can I ask for a feature of incorporating hashes into
> transport stream in trusted environments?

If you have very large binary files, perhaps git-bigfiles fork would
help you: http://caca.zoy.org/wiki/git-bigfiles

-- 
Jakub Narebski
Poland
ShadeHawk on #git
