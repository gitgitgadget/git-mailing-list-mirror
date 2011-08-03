From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE/RFC] cj-git-patchtool: a "rebase -i" with more interaction
Date: Wed, 03 Aug 2011 03:55:21 -0700 (PDT)
Message-ID: <m3d3gmrchz.fsf@localhost.localdomain>
References: <CAEjYwfUY9tF_9frkaS7Aw26CPJA02Cr3HDN5Qpkup1rfHYacXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Jaeger <chrjae@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 12:55:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoZ6n-0008EP-6o
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 12:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab1HCKzZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 06:55:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34626 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab1HCKzX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 06:55:23 -0400
Received: by fxh19 with SMTP id 19so541628fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=7BvU+DKMjrQ24KqowGbDdlTjNP21xS4+i/CW2guTY4o=;
        b=ueq3ZWZvs4rqptBToVak/33zI0UuUbDY0DrNv8Z21P2jkanfsgjEs9/5wcn5vMDgIe
         a0LqNDWBmqQ7IZXF4Afw7aURZrq3VmH1r6tOmzOqOwBZG7+i8o/KUvFYKKLgNhcatEmT
         xR2C2tw2IpbXYG98a5h8/eFPN3tSFh8v0xHaQ=
Received: by 10.205.35.129 with SMTP id sw1mr2249027bkb.285.1312368922035;
        Wed, 03 Aug 2011 03:55:22 -0700 (PDT)
Received: from localhost.localdomain (abvd21.neoplus.adsl.tpnet.pl [83.8.201.21])
        by mx.google.com with ESMTPS id x1sm2431667fah.2.2011.08.03.03.55.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 03:55:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p73AsrB7027738;
	Wed, 3 Aug 2011 12:55:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p73AsmGG027734;
	Wed, 3 Aug 2011 12:54:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAEjYwfUY9tF_9frkaS7Aw26CPJA02Cr3HDN5Qpkup1rfHYacXw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178558>

Christian Jaeger <chrjae@gmail.com> writes:

> So I've written a set of tools[1] that separates the acts of editing
> and applying history changes.
[...]
>=20
> For more information see the README on Github.[1]
[...]

I have added cj-git-patchtool to "Patch-management Interface layers"
section of "Interfaces, frontends and tools" page on Git Wiki:

  https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tool=
s#cj-git-patchtool

Please check if it is correct, and improve project description if
needed.

> I don't know whether there are other tools offering the same now.
> Also, I have written this "just for myself", and for this reason made
> use of a set of never-before released Perl libraries of mine. If
> there's general interest in this tool, I'll be glad to help get rid o=
f
> the dependency on these libraries (or clean them up and publish them
> properly, too).

I use one of patch management interfaces for that, namely StGit.  It
operates on stack of patches, which you can apply and unapply, going
back and forth and correcting them.

--=20
Jakub Nar=EAbski
