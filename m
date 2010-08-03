From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] nd/fix-sparse-checkout v2
Date: Tue, 3 Aug 2010 16:16:33 -0500
Message-ID: <20100803211632.GA2645@burratino>
References: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 23:18:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgOs4-0003vE-3O
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 23:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab0HCVRz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 17:17:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62606 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0HCVRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 17:17:54 -0400
Received: by vws3 with SMTP id 3so3453808vws.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M8R5xfmGFxUWOKLOMafqvL0eJALHGnaz7zz8dXRM1eU=;
        b=I/6J6VSXXnbd/sXMppiHZVDoslJk8XKLPGiFPSzaiFpXxrfxkJpVM8QFGbBbjGQsRl
         o6n/6DEhTXTYyQqxtqqrudxPWLNFl/5vxJlTjvPw+4ppV7hOlXdUFNOSrfmpfFzl2BcK
         KxE8krz02LzAluwq/9BVpvcErJN9n8JDF3WCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xTb5EztGx2MXNWsARsunUIGV1X6wiAbiwH83N0MbS6DICZ/lqY0df5bEXyqT7I/db0
         VB8rUw6m4Uq5rFZJd8e4dJ753ru9Y4s2CBxPv4+afBAY68tNPPoSn1BJWvjPzW2kPz5n
         uoKWN4Ohko65W8kZ+CuyoURcEbvwohb4cScec=
Received: by 10.220.71.16 with SMTP id f16mr5589776vcj.139.1280870272582;
        Tue, 03 Aug 2010 14:17:52 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id q12sm3749097vcf.35.2010.08.03.14.17.50
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 14:17:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280556869-707-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152541>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Discussion of patch 1/3 from the first series resulted in 2/5 in this
> series. 2/3 and 3/3 from the former have commit messages revised,
> code change remains the same.
>=20
> Jonathan Nieder (1):
>   t1011 (sparse checkout): style nitpicks
>=20
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
>   unpack-trees: only clear CE_UPDATE|CE_REMOVE when skip-worktree is =
always set
>   unpack-trees: let read-tree -u remove index entries outside sparse =
area
>   unpack-trees: do not check for conflict entries too early
>   unpack-trees: mark new entries skip-worktree appropriately

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the explanations.
