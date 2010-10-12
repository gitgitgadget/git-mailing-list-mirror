From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/7] Teach fast-import to print the id of each imported commit
Date: Tue, 12 Oct 2010 20:57:35 +0200
Message-ID: <AANLkTikyc8qv6SCewrZLvZccOX5giqRPqQBtrf8o9Mtb@mail.gmail.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-2-git-send-email-david.barr@cordelta.com>
 <AANLkTinRDoSHhzYnnvckPYyiZrsOX1mJECBMb5bNbMJ=@mail.gmail.com> <20101012184856.GA16103@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 20:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5k30-0005Wz-M3
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 20:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102Ab0JLS55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 14:57:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42917 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab0JLS54 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 14:57:56 -0400
Received: by iwn7 with SMTP id 7so1086836iwn.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Ky23UuOhdbQ7t5RpZwnlqfdWs93EZ2IAYnzOMPoR8ew=;
        b=a9sVf7y27dB4LrXj2sJLGnBh1hxdy7aDfV2ZiYrWeE0AazVupDaX+Hnxf45FDV4dmr
         a4FsAjLJofCqp/f9zzdXWrSn4hB/eBgo5FeNftiDRQKLpDNd+oTv/5iqE6yHTha1OFHc
         OucEfjh6GGLMGzlEoXQBQ8CpMnAKXIpgv9oHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TkpALvalHv3nmjbGa/hJHNNomG4UTx0mzrNj52kPnOwJc7+LLxFwSoTHSACKSfvWeL
         xtYazN7thrX1Hr32A3S14flwNtBiCUiVzufeMFlmk9q4FgIUL9/PdCSoQqJtLPYSPOLW
         YJ0T7OZVlSuS8me1bWm20cXIQSQhfiM3sONFQ=
Received: by 10.42.175.136 with SMTP id ba8mr34390icb.35.1286909875560; Tue,
 12 Oct 2010 11:57:55 -0700 (PDT)
Received: by 10.231.32.74 with HTTP; Tue, 12 Oct 2010 11:57:35 -0700 (PDT)
In-Reply-To: <20101012184856.GA16103@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158867>

Heya,

On Tue, Oct 12, 2010 at 20:48, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Thanks for the reminder. =C2=A0I still think Sam is right fwiw.

Perhaps we can instead make '--report-fd' have a default value of
'stdout'? I don't see why we would want to _disallow_ the value from
being specified in stream (we allow import/export-marks in-stream
too), as long as they can be overruled by the commandline.

--=20
Cheers,

Sverre Rabbelier
