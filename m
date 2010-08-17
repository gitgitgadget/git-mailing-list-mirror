From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 13/24] merge script: tweak unmerged files message to match builtin
Date: Tue, 17 Aug 2010 07:36:37 +0000
Message-ID: <AANLkTi=CTzhzO+mZ9hw4pbVaEpegZCt56bo0FzHgie36@mail.gmail.com>
References: <20100817065147.GA18293@burratino>
	<20100817070336.GM22057@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 09:36:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGjA-00030B-UE
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab0HQHgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 03:36:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47635 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab0HQHgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 03:36:50 -0400
Received: by gyg10 with SMTP id 10so2262937gyg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PYQjZzMDi6F99Kijgf68IevcQzCSmEqCp3RiCGipXiU=;
        b=AImPnsGE6avRDRMT1dCtPpeWADRvGN3KZpalAvWJM7nH2Y1+qW8beTv798k3fF5Pmk
         +yHSxBZxumO8uTjpvhFs/grlF3InMGNOwxUxNAAKIHQHwJCGaZ8TJ/Gx379/lfOBoAnQ
         8mm++LMK5k/HJhDmMnpK/6FmipqYk4GxQMWtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=phA2JRlaJDrqEwVjebVtIphkSchbIDROdlzxbylF/iAzrW6dWoagD7OWG0W2erwwh4
         Nu5GPjetNab5ZkwHEoD6N26e5hfm2anleo0sCtrpqGTLSl/DsIPp6l0Kvmn+zpJj/JCS
         7POXZ5QEsMlEk3c6MFLgCjZ/SmdVg18/1VNiQ=
Received: by 10.231.183.134 with SMTP id cg6mr6941963ibb.197.1282030597810;
 Tue, 17 Aug 2010 00:36:37 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Tue, 17 Aug 2010 00:36:37 -0700 (PDT)
In-Reply-To: <20100817070336.GM22057@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153729>

On Tue, Aug 17, 2010 at 07:03, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Before:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0You are in the middle of a conflicted merg=
e.
>
> After:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Merge is not possible because you have unm=
erged files.
>
> I prefer the old message.

I prefer the new one, thanks :)
