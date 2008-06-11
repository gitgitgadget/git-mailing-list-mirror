From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: clone git over http fails - Unable to find 1f405709e7341c27e20c0159fb7c17efbf85975c
Date: Wed, 11 Jun 2008 20:47:18 +0200
Message-ID: <237967ef0806111147v4dc82d24sbe02338d428a4287@mail.gmail.com>
References: <1033a22d0806110758mdec211dr21e0115e0eb1fb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Yesberg" <john.yesberg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6VMs-0004zC-Td
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 20:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757930AbYFKSrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757917AbYFKSrV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 14:47:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:58622 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900AbYFKSrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 14:47:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1602538rvb.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XCCdpXKGuu99XJJGGcL+0xRw0wDygOfIQ9EPVEKefAM=;
        b=fZFVlRxjrjq3i/P5xdtCzQ1jkOScqRgMXk4SA3rAlgxhcVE5MLlZxW/sCLQlD55BBn
         WLJnMCJS2YBCYerCG++8WxO1PvLbaB64boD9Mg0PmwoT57ix5p/Nvvy4yDm3//koAtue
         LzK10Si360Ppc/EYkra8pw11luBLMDVcu2naM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CUzxndd6/OvAE9HBCd1pV7txIuzzeL9UA6G9ZYDvgCfspaAG3j4TXZxgPpXlwp78eB
         uY52HlbSJVvQdQMA9Ip1uyc11jYZIRcUcVyQVwNydl6YBRaai/sJVQloR9BT9mrVDzWr
         Ao3r2Ph0VaPXaLyJPDXpWa6V0l/3+xse+K2ys=
Received: by 10.141.211.13 with SMTP id n13mr186452rvq.184.1213210038424;
        Wed, 11 Jun 2008 11:47:18 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Wed, 11 Jun 2008 11:47:18 -0700 (PDT)
In-Reply-To: <1033a22d0806110758mdec211dr21e0115e0eb1fb2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84637>

2008/6/11 John Yesberg <john.yesberg@gmail.com>:
> Hi,
>
> I'm trying to clone the git repository, but I'm behind an http proxy.
> I'm using v1.5.5.1015.g9d258 (the msys distro)
>   $ git clone http://www.kernel.org/pub/scm/git/git.git
> seems to collect files in a different order each time, but always
> fails at some point with:
>   error: Unable to find 1f405709e7341c27e20c0159fb7c17efbf85975c
> under http://www.kernel.org/pub/scm/git/git.git
>
> Am I doing something silly?

IIRC, there was some bug in the http clone code some time ago, maybe the
msysgit repo is still based of some commit where it wasn't fixed yet. Or
it could be something completely different of course.

-- 
Mikael Magnusson
