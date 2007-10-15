From: "Shun Kei Leung" <kevinlsk@gmail.com>
Subject: Re: git-fast-import crashes
Date: Mon, 15 Oct 2007 12:53:38 +0800
Message-ID: <e66701d40710142153o70a7b696r928491be437ac6d@mail.gmail.com>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com>
	 <20071013032916.GL27899@spearce.org>
	 <20071013033407.GM27899@spearce.org>
	 <20071013073640.GC7110@artemis.corp>
	 <20071013075027.GD7110@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 06:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhHxh-0004pY-1o
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 06:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbXJOExl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 00:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXJOExl
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 00:53:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:62476 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbXJOExk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 00:53:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1165298nfb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 21:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=t+P8ZpAkyvkBXxpQHm+ACSnARIU9oThH2uakdm4vp3E=;
        b=iLWYBPncFGjtItikrbCnSOK2+g03k/AGEJCLJyEIGZ0dZMykON29fzpLsuf7fFkXdYGiV6nyFoEw43K1epQRHdLIiVyGxxaXIMWRkLt2fhwMftooosvdj8C/e5iNTovVTMOH34rV44NQs6r5G1y1CubTAJvIBjuiVp2LvaOvSVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b/PL/bhy0/ppz3R/dfl5avc6LR4R2xo7AZBSJ31+rd4raKjAL7Y9+e0GZVWtvPq2aVUfIaWBvWN/QmKIqW4ISNfEIoDYVF/zhe2bCkVtwtcXzVUILEdQJKTDkEMMbGNzBxm7II7G34/RTErblQ4D1oKw0FpcKl0WmpUeyFjo+MA=
Received: by 10.78.200.3 with SMTP id x3mr3690294huf.1192424019021;
        Sun, 14 Oct 2007 21:53:39 -0700 (PDT)
Received: by 10.78.132.20 with HTTP; Sun, 14 Oct 2007 21:53:38 -0700 (PDT)
In-Reply-To: <20071013075027.GD7110@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60944>

Hi,

Sorry for the late reply. I was away from my computer in the weekend.


Hi Pierre,

I didn't try:
http://git.madism.org/?p=git.git;a=commit;h=7406e83342cd445ac38c1753c5fce75377737e2f

because the bad commit turns out to be b449f4c according to `git bisect'.


Hi Shawn,

I include the output of `git count-objects -v' for your information:

count: 104
size: 552
in-pack: 10652
packs: 12
prune-packable: 0
garbage: 0


Regards,
Kevin Leung
