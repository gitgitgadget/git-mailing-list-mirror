From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 2 Oct 2008 16:08:53 +0200
Message-ID: <200810021608.54287.jnareb@gmail.com>
References: <alpine.DEB.1.00.0810021541470.22125@pacific.mpi-cbg.de.mpi-cbg.de> <1222955278-16908-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:13:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOsd-0002iZ-K1
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbYJBOJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752508AbYJBOJA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:09:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:55929 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbYJBOI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:08:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so425077nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JCaz2FUI4Mofe8sRtk70j8oT/Ch2RN6PFTMe3CuLTFk=;
        b=lsy5mxh4SKIhU+G2Lgo8ok8pYGRjZdz+2n9GZj2pkkfNQw/+e3jcW/IUnenM5c2VAv
         Kxs+QqPHdYFdD/HMJ83Ly+s660SjW7RVHeGoFt/+wlCvKanPI3sKGg/mL7bFiDE4bTC8
         2muUlunrcBYlusK09KQdpGal0cRW41UWf8bZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e79i1nZmaA0taIYbp05gitqH2gjZAW6URx1QPYBi77Pl/GcLtu9yZIYzed30KUfmmZ
         GWRA06x/UudJQZ8ChQWRDuPepAG1heGfy7LsFUGUwaD5Bv/bNOAqrTWPCz24i1QuAjQh
         AGCzdwSAL+ppiJDNm85f9fMzFllsliA3SKzWo=
Received: by 10.210.113.16 with SMTP id l16mr11468180ebc.85.1222956537913;
        Thu, 02 Oct 2008 07:08:57 -0700 (PDT)
Received: from ?192.168.1.11? (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id z33sm1913421ikz.0.2008.10.02.07.08.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 07:08:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222955278-16908-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97336>

Giuseppe Bilotta wrote:
> format-patch is most commoly used for multiple patches at once when

s/commoly/commonly/;

I'm not sure about 'most' there...

> sending a patchset, in which case we want to number the patches; on the
> other hand, single-patches are not usually expected to be numbered.
> 
> The typical behavior expected by format-patch is therefore the one
> obtained by enabling autonumber, which should therefore be the default.
> 
> Users that want to disable numbering for a particular patchset can do so
> with the existing -N command-line switch. For users that want to change
> the default behavior we provide a 'noauto' option for the
> format.numbering config key.

Nice. I like it.
-- 
Jakub Narebski
Poland
