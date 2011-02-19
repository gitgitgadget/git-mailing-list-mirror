From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Sun, 20 Feb 2011 00:05:39 +0100
Message-ID: <AANLkTikK+htiiZXMBtKjuy9ZpEEoVi-BG+c5_HzLdFUP@mail.gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie> <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <7vei75p3zr.fsf@alter.siamese.dyndns.org> <20110219111103.GA1841@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 00:06:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqvsw-00065l-CW
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 00:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab1BSXGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 18:06:32 -0500
Received: from mail-gw0-f52.google.com ([74.125.83.52]:62703 "EHLO
	mail-gw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab1BSXGb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 18:06:31 -0500
X-Greylist: delayed 2986 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Feb 2011 18:06:31 EST
Received: by gwb11 with SMTP id 11so2199214gwb.11
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 15:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=2mn2U6Z5vXix4m1WNkcR1OivGG8evPMKD5fBc4tPc/w=;
        b=U+W0pRxyxSqQBtI1Bz9IHKdy1txaBiFjojyqJjjLaYq160h5E1bvuPx7OxVOzWi8wL
         0/PFlDba5LNcNtAUwCf+pMauO+ugYZcJBUWFqyJbJaljR7vJkruIgL1sYV1stunUTf+O
         2LKxeyf8P3fmi5NThOMIAW4BsIwv8LtZftnf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=my2m9NDVlsDBWMlJC1Q8c5oD2a+SfZ5thkz11n1XXNF7rSnqw9020YUiqAStSejjYY
         3L85tZkkA/tdOjZCoZkEel+x4X5LPVrKk0+qmLPtfZcrFUFYWPBB0urUrN0jP5drAruV
         hPzrHJnl+lgf6p2rOoHGBCOHs34BAuP9pt9XY=
Received: by 10.150.100.11 with SMTP id x11mr2960558ybb.419.1298156779091;
 Sat, 19 Feb 2011 15:06:19 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Sat, 19 Feb 2011 15:05:39 -0800 (PST)
In-Reply-To: <20110219111103.GA1841@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167384>

Heya,

On Sat, Feb 19, 2011 at 12:11, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Side note: I am not sure I like the git_remote_helpers name. =C2=A0Wo=
uldn't
> a good goal be for these modules to be usable by other VCSes'
> import/export scripts, too?

The reusable code (the fast-import library) is already living in it's
own library on pypi, I don't think there's much other code that is
reusable accross VCSes?

--=20
Cheers,

Sverre Rabbelier
