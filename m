From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: FW: git over https and http 1.1
Date: Fri, 20 May 2011 00:02:34 +0800
Message-ID: <BANLkTin6LQ-UoaJObJ3pyJOp0TfeJXw9Qw@mail.gmail.com>
References: <BLU0-SMTP122315AAE364595FDA4A30AC78F0@phx.gbl>
	<alpine.DEB.2.00.1105181615180.26343@tvnag.unkk.fr>
	<BLU0-SMTP207861424D1FA595A51BBBEC78E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nir Friedman <nirfri@hotmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 18:02:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN5gO-0001kU-VQ
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 18:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435Ab1ESQCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 12:02:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40311 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733Ab1ESQCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 12:02:35 -0400
Received: by iyb14 with SMTP id 14so2209016iyb.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qVlbLDAKtVBExipoZYqPZpCe6lOw1MOvoMO9b++m/jg=;
        b=kpSqkWCpDPoBINP//oap6eNDgqVL6dZEcpTBIUe4T2tgeMlrOeI/Tpq9OrRgM1hBF7
         ApdJUQ4fB0EQz4GmTvA0O1lVT0dk6T29EP0i5jBTOYfOhcXMEdJM033rFrmGgxTWlZPp
         LvVEQsUuXTpNOnK4kmLtE5/Ia8+bRUMjeCi9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cAFcyNbttsCJv4/i7AcVWI7kFuMXoXSuXUKEHJAY0Hbzas9n5c1cdnr7OnTUz763zm
         8GleuNtNDa8jo/88oeUuWLDJiTeOV5CyvUYC7XeL/UOa7yTxI8bP81xEJyoijBwmY0Ly
         l0nPYqylc8fYMLSnmmesVSglak2ElmpLnDiIY=
Received: by 10.42.150.71 with SMTP id z7mr4024420icv.483.1305820954704; Thu,
 19 May 2011 09:02:34 -0700 (PDT)
Received: by 10.42.5.17 with HTTP; Thu, 19 May 2011 09:02:34 -0700 (PDT)
In-Reply-To: <BLU0-SMTP207861424D1FA595A51BBBEC78E0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173964>

On Thu, May 19, 2011 at 12:43 PM, Nir Friedman <nirfri@hotmail.com> wro=
te:
> < HTTP/1.1 200 OK
> < Date: Thu, 19 May 2011 04:37:40 GMT
> < Server: Apache/2.2.17 (Ubuntu)
> < Expires: Fri, 01 Jan 1980 00:00:00 GMT
> < Pragma: no-cache
> < Cache-Control: no-cache, max-age=3D0, must-revalidate
> < Transfer-Encoding: chunked
> < Content-Type: application/x-git-upload-pack-advertisement
> <
> *********************************************///////////POINT
> 1///////////**************************************
> * Connection #0 to host 10.1.30.61 left intact
> * Couldn't find host 10.1.30.61 in the .netrc file; using defaults
> * About to connect() to 10.1.30.61 port 80 (#0)
> * =A0 Trying 10.1.30.61... * connected
> * Connected to 10.1.30.61 (10.1.30.61) port 80 (#0)

=46rom where the pause is occurring, it seems the issue isn't one with
curl/transport. Can you try running the clone also with GIT_TRACE=3D1?

--=20
Cheers,
Ray Chuan
