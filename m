From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: serious performance issues with images, audio files, and other 
	"non-code" data
Date: Tue, 18 May 2010 01:33:35 +0200
Message-ID: <AANLkTikAoZgvYXN-iGPGjMP-vdgrOuKp3_gJzGYaojec@mail.gmail.com>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net> 
	<4BED47EA.9090905@puckerupgames.com> <20100517231642.GB12092@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John <john@puckerupgames.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 18 01:34:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE9ov-0003wl-Nh
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 01:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab0EQXd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 19:33:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48146 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab0EQXd4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 19:33:56 -0400
Received: by gyg13 with SMTP id 13so2498128gyg.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hBzlHfpjznTXcH1+5KgTYH/MRjDs7c8Ccqb5N25Wy6Q=;
        b=KK3ujsT99Kz7bpC7O1yLr0JUs+uW3owRXQhykYJSvsEvTsJAhPV4uehXqb/dmeo7Da
         FhVFSVEE/Mj+UunAuTv2Nm2tOpEXlIrtwzKNsexaL9I1kB+dCgu3DpRPRC+S3vMhaMd1
         5TA82S+p4gr/FX9haDN9+Nb3WsTmJMnOz/W+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RTl8OTc4Q0xJ1YljMaSrbAMLYQwOcpCBV8tynIPMa49HcocqbZcyy8uBM8sDxn2wA/
         Ih60A7vaj1cur1Pi/+LO08NJ/sxi6WhY9uuboWNkiGIRMU7cxm84zE6iPNkiIqZAox5D
         II1ySjhc35CnvtVlx+3GNnDXdl6dmFhhttUZQ=
Received: by 10.150.94.18 with SMTP id r18mr3742033ybb.320.1274139235180; Mon, 
	17 May 2010 16:33:55 -0700 (PDT)
Received: by 10.151.125.11 with HTTP; Mon, 17 May 2010 16:33:35 -0700 (PDT)
In-Reply-To: <20100517231642.GB12092@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147266>

Heya,

On Tue, May 18, 2010 at 01:16, Jeff King <peff@peff.net> wrote:
> =C2=A01. Use "git commit -q" to avoid wasting time on the commit diff
> =C2=A0 =C2=A0 summary (we should perhaps have a commit.quiet config o=
ption for
> =C2=A0 =C2=A0 repos like this where you would almost always want to s=
uppress it).

Do we respect the .gitattributef and not try to generate the diffstat
for files that are uncompressable?

--=20
Cheers,

Sverre Rabbelier
