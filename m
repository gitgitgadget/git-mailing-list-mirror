From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 15/18] http*: add http_get_info_packs
Date: Fri, 29 May 2009 22:39:22 +0800
Message-ID: <be6fef0d0905290739s125296f1m5eedfde8299f27e9@mail.gmail.com>
References: <20090524222003.7da46ff8.rctay89@gmail.com>
	 <7veiuetenn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 16:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA3FF-00072p-SF
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 16:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760408AbZE2OjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 10:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759485AbZE2OjW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 10:39:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:11337 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760285AbZE2OjV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 10:39:21 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1263144wah.21
        for <git@vger.kernel.org>; Fri, 29 May 2009 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g7WAZGgso9ojdmsIo6K6VFCkXr1qrlqngpH4Qmtrv4A=;
        b=xsBK3h2JYf13T5tAikAWB0PmxYxiigq5p+cBT8qc3FdnQfR7mG51tyVDONd5nDeRLZ
         yKDpwwIa3/qUiq1W4WvbyXUUWv9OJChmu5S3ZdiZlFjQtHDT1OGBnRtLESzrfY79M7Kh
         PF8O4xN5rfmKStb6FMw+C5N8ZR0bByVTBUpdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CP/1lELxBh3lcoiBoXxKzMnnhujFH7kP9PZJBJrj+A32Fk+SdM786YRJL2R7afyYHz
         Rdmd+2+GCXLaKKpfB6m6BWykkQiXGImBjbdhdO83Paxh5hhRbXI0n4k4ans5xdrfoba1
         Jiff6gjL63q7YUAKxxhyHQiiaUlYSPuLr6URw=
Received: by 10.115.47.13 with SMTP id z13mr4111730waj.108.1243607962493; Fri, 
	29 May 2009 07:39:22 -0700 (PDT)
In-Reply-To: <7veiuetenn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120282>

Hi,

On Mon, May 25, 2009 at 4:43 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> It makes me wonder if fetch_index(), even though it is static to http=
=2Ec,
> should be renamed somehow to reduce confusion between it and
> fetch_http_pack_index().

Indeed. What I'm now doing is

fetch_index --> fetch_pack_index
setup_index --> fetch_and_setup_pack_index

> You have decl-after-statement and a handful of variable that are no l=
onger
> used. =A0Please squash this in when rerolling.
>
> =A0http-push.c =A0 | =A0 =A02 --
> =A0http-walker.c | =A0 =A01 -
> =A0http.c =A0 =A0 =A0 =A0| =A0 10 +++-------
> =A03 files changed, 3 insertions(+), 10 deletions(-)

Thanks for including a patch.

--=20
Cheers,
Ray Chuan
