From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 1/3] gitweb: fix #patchNN anchors when path_info is enabled
Date: Fri, 18 Mar 2011 18:18:53 +0100
Message-ID: <201103181818.59901.jnareb@gmail.com>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost> <201103181359.46600.jnareb@gmail.com> <7v7hbwxt7e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 18:19:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0dKd-000576-0k
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 18:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209Ab1CRRTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 13:19:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40954 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139Ab1CRRTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 13:19:17 -0400
Received: by bwz15 with SMTP id 15so3527286bwz.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jx9jSpfIAunF6XsXkwPaaTvQeLroPBt7+bt0QFmJKCA=;
        b=S5+MiUDoXK/y6YMRQlzVb0zJyNYySTQsfdJKimVEHCAU/h1M4ngEi5cdGq7w125gWz
         DGNtYMFoFFZ2wDxXf75w0xsfiodmnSW3Sns0AQObTETfE1X8fGIwbSnPZXlsn2XgDvU3
         msiLMZHJjTdivMK1FC3uDWFIdsLogMyFPfRGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e7q7KdUcNR07mzSvt/VdFAJAlMxOMaatkHDXqtMQIv1+eoTCj8FIMRzPm9X1iwT0/q
         juS/O4jnPidmju99x8ZrBCY/mp7j9jsjc2oABbSAglZ/SFq1xBBW8EMaAnapYkrlj1uQ
         L+yy2hxp/tPOtrFDLeQUJ9+3A/vhU16o/LZTo=
Received: by 10.204.19.10 with SMTP id y10mr1176632bka.190.1300468755713;
        Fri, 18 Mar 2011 10:19:15 -0700 (PDT)
Received: from [192.168.1.13] (abuz4.neoplus.adsl.tpnet.pl [83.8.197.4])
        by mx.google.com with ESMTPS id b6sm2297771bkb.10.2011.03.18.10.19.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 10:19:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7hbwxt7e.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169340>

Junio C Hamano napisa=B3:

> Anyway, thanks for the clean-up. =A0Applied.

I hope you applied amended version - this one has stupid bug in it.

--=20
Jakub Narebski
Poland
