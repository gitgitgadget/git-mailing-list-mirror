From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 0/3] nd/multiple-work-trees updates
Date: Fri, 13 Feb 2015 10:10:08 +0100
Message-ID: <1423818608.30155.1.camel@kaarsemaker.net>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
	 <xmqqlhk2pwle.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Mark Levedahl <mlevedahl@gmail.com>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 10:10:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMCGV-0000Zi-IV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 10:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbbBMJKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2015 04:10:17 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:59368 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbbBMJKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 04:10:13 -0500
Received: by mail-we0-f174.google.com with SMTP id w55so15318242wes.5
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 01:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=/8uwrgGR6XEMP+QpXQd3ajq8ROTp5Bsa6P9xi7RvUa4=;
        b=dBigutCEJcDdtAxuftpZdKiw+rvZGOmlCEuP3ayopBZtmzp0L71pd8nGOQT5FwiV5b
         C/DCUUfGsUaVWzZA4Hn3TPDTNBoqUeWMuOX+4qduDpWm26IO3rbka9i9Q0kgIKl8dJAZ
         UjZ7yGmDUYRQ0v2iVvT3VCJkBJgnNA9Lw7JaFQZQ/OtFCTan2UL3iCSNvUSGh2184rHa
         1lo9m0rOJniZ6c9akLgwjPscNKEZSi62BSaHbgIClDcyFxZrPD30dU6ClEmyEMZ5NQsE
         a7kVCLTsGcm0nmGtHi7caZ2CZBaQb1X4BSk8YJ5sgJpLtn1//I6EKr6xvfCieJAwTqCl
         4X6g==
X-Gm-Message-State: ALoCoQnwKGmYnLOes1xYEAUOH2rxNxaFkde3br3Y5xlKlRiFwPe3NCzPXhqmf2q1VqFnc+pO/rVS
X-Received: by 10.180.20.167 with SMTP id o7mr13905531wie.50.1423818611652;
        Fri, 13 Feb 2015 01:10:11 -0800 (PST)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id dt10sm2044764wib.23.2015.02.13.01.10.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Feb 2015 01:10:10 -0800 (PST)
In-Reply-To: <xmqqlhk2pwle.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263802>

On do, 2015-02-12 at 14:57 -0800, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > These patches are on top of what's in 'pu'. They add
> > --ignore-other-worktrees and make a note about current submodule
> > support status. I don't think submodule support is ready yet even
> > with Max Kirillov's series [1]. His 03/03 is already fixed in 'pu'
> > though, so only 01/03 and 02/03 are new.
> >
> > [1] http://thread.gmane.org/gmane.comp.version-control.git/261107
>=20
> With the understanding (perhaps a strongly-worded paragraph in the
> release notes) that this is not suitable for submodule users yet,
> is this in a good enough shape to go to 'next'?

I've been using this for a while and really like it. However, it needs =
a
few fixups to merge with next as there are a few merge conflicts.

(A version of this branch that I stuck on top of next last week can be
found at https://github.com/seveas/git/tree/nd/multiple-work-trees )
--=20
Dennis Kaarsemaker
http://www.kaarsemaker.net
