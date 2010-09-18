From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] smart-http: Don't change POST to GET when following redirect
Date: Sat, 18 Sep 2010 17:00:25 -0400
Message-ID: <AANLkTimwkXTs==+zT=Ue3jFNyRLL+7A1FFhoDuF-5zZ3@mail.gmail.com>
References: <877hijvff7.fsf@catnip.gol.com> <20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi>
 <m262y3cvpy.fsf@whitebox.home> <m21v8rcua1.fsf_-_@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Sep 18 23:01:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox4Ws-0000UH-SJ
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 23:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab0IRVA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 17:00:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55427 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0IRVA4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 17:00:56 -0400
Received: by vws3 with SMTP id 3so2356460vws.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jZ6i25er4ALQQbfwvQpvBTw74B9EFcEzAWBXOIIPvVM=;
        b=UUCBbPMLfxxkqQsGorNPtjXJJGqqYvC6aS6Stgj1TmhdURE33GEtKBIb50FDn7xCle
         L0IQ84W6K86cn1dNtIUMR2i4K9Dxyl35RZQvuS+eBADvm0+0CJ6RQw5rTOhRNZWuPRPa
         oh1cxWCjgIj9IZTSHOlSeMEkYqlmevQjR9Vbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IUQ8/YlOW/I3Slnr3Bnbuitgoo1I0tSuAwruo3ZRrr8IfJYRnxIqW/9RbTr6JOUMVV
         AjoisBI6A6KGXfMjonY+lbt9IIkTVnwNZPxPa38/tDvvdYSaFI+5on5/HJWu6TTGpgty
         pDLc/MH2ZNm+wv98e6DFBc3ekJx+RlUkf+DaU=
Received: by 10.220.50.94 with SMTP id y30mr386754vcf.48.1284843655230; Sat,
 18 Sep 2010 14:00:55 -0700 (PDT)
Received: by 10.220.70.141 with HTTP; Sat, 18 Sep 2010 14:00:25 -0700 (PDT)
In-Reply-To: <m21v8rcua1.fsf_-_@whitebox.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156474>

On Sat, Sep 18, 2010 at 4:47 AM, Andreas Schwab <schwab@linux-m68k.org>=
 wrote:
> + =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(slot->curl, CURLOPT_POSTREDIR=
, CURL_REDIR_POST_ALL);

Not sure what git's minimum supported libcurl is, but this define was
added in 7.19.1 (November 5 2008).

j.
