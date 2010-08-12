From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Low-level repository inspection (Re: Where do I stick development
 documentation?)
Date: Wed, 11 Aug 2010 22:17:56 -0500
Message-ID: <20100812031756.GD19174@burratino>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
 <20100812023922.GB19174@burratino>
 <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 05:19:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjOKI-00077p-Gy
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 05:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759574Ab0HLDT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 23:19:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43318 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759210Ab0HLDTZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 23:19:25 -0400
Received: by gwb20 with SMTP id 20so250193gwb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2ZauGgJUov08cENtev3uGOkh99+0BqzTiNyS3S7nhYs=;
        b=ejtEhg/77e05vckqA6LeHAaqYd8edodBIhNtKehocozhzRbEWru7Sog/ADrTpdWb3/
         gGkGCt0UA8pP4nhMoDIkTYzX4icaXeFoeAJNADJRG5ThghbWS4uimuS5mqGq+XT1VewN
         k/PdqOP9oNAQpxohtEu5MHDOnqM22HDy739Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HbuFK9YpBtk4NMVXWMoDZCVSQr7XHQ0RPCrp+/05TujyGPMQrxbrhwJB5oUvAVKBTl
         q/zMeCTA93zCpBCNCDbICOCQnlFlQRk4LplESgU2sL8pqZt/BVmaSN0clWn36Bb26830
         sBwFsDI0zBFMDURHElDcd8c8BcqdhgG6fLGoA=
Received: by 10.100.8.11 with SMTP id 11mr22827600anh.66.1281583164321;
        Wed, 11 Aug 2010 20:19:24 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i25sm1283518anh.37.2010.08.11.20.19.23
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 20:19:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153333>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It'd also be very neat if we had tools to print out any object in its
> raw form, --pretty=3Draw is partly there, but it's more pretty than
> raw.

How about git cat-file (and other =E2=80=9Cinterrogation commands=E2=80=
=9D listed in
git.1)?
