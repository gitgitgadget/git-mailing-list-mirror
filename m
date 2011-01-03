From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitattributes don't work
Date: Sun, 2 Jan 2011 19:11:13 -0600
Message-ID: <20110103011113.GF30506@burratino>
References: <ifr610$3kl$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Marcin =?utf-8?B?V2nFm25pY2tp?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 02:11:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZYxL-0005EF-LJ
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 02:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab1ACBLX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jan 2011 20:11:23 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42230 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1ACBLW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jan 2011 20:11:22 -0500
Received: by qyj19 with SMTP id 19so15411337qyj.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 17:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tUcms1Uglq2h5jUrYnyyCacNWRQSt0/Hx+4hwBuwm/M=;
        b=uN8nmr3JFoNFJP+9V3TcVgnaiGN7JImHUKq+YHcGiZyjt4BuFUJLGEFUAwE4BEZvrz
         ZSVB/UBB1KFxjkPYWpqxWF0nZ5MlyaznRTu6lhbWG+EPkZBhptwCyz08dGZ23nMgMkJy
         9hsxPtTD3h1FxwGlx1E1yvfh59/nlFfoEEO50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RReZOGnlyMGT5LR3ty107PXF/diuBZRDdAB3ZnI2Go8ZSmtMovLoI6AFHKwu8mE/WF
         G3OGX/8fT5jZr1eCw5ebvm3qY+R9CRXR78IaC8/DJo2ngB91dv5k4rNRvQIl0S7mUGlu
         pvA+YoLOGKJh8Fj0xo1/jLikbx5omb2LRs62g=
Received: by 10.229.217.79 with SMTP id hl15mr16530301qcb.111.1294017081166;
        Sun, 02 Jan 2011 17:11:21 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id t7sm10490507qcs.16.2011.01.02.17.11.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 17:11:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ifr610$3kl$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164435>

Marcin Wi=C5=9Bnicki wrote:

> I'm trying to exclude certain paths (those that contain "xmac/gen/") =
from=20
> diff output using .git/info/attributes (not .gitattributes).

Tricky.  Have you tried

 xmac?gen? -diff

?  You might also be interested in the nd/struct-pathspec branch:

 git clone git://repo.or.cz/git.git
 cd git
 git log --grep=3Dnd/struct-pathspec

for some work and explanation on patterns used to specify paths.

Regards,
Jonathan
