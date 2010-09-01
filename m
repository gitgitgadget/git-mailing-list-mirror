From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: Large pack causes git clone failures ... what to do?
Date: Wed, 1 Sep 2010 11:23:23 +0930
Message-ID: <AANLkTik2Ms6qjQAaa_H8GGwmTG1fsk+8GR2y7ZmLviY-@mail.gmail.com>
References: <AANLkTi=1iLx=-9gxkGzuhrbpA005VPSp0itkAkOG4D4z@mail.gmail.com>
	<20100831180247.GF32601@spearce.org>
	<AANLkTi=O5SbLRttzR0YwrHVEMz5gxtdTo9Z5C6V1yE1e@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 03:53:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqcW3-0007LX-C0
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 03:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0IABx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 21:53:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64526 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab0IABxZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 21:53:25 -0400
Received: by wyb35 with SMTP id 35so8613721wyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=yS2vw29VDHXtzZlQVTY/K/sI3CTtfzpFo4RtwDDiE9I=;
        b=G6rLlJu0NX3Gzl/FPnKq3V7RE81Ko3DnGj4u/SNnBjWBxoycLDGUtjy9TY0RcxJwUw
         pZASB+VQNbV1s2qYONVV++d9D+ciBb2gXHlIyk3ol+fyiqJb4QrP3yjBZwq8XarMqIhf
         gsppTQMwFp70oq0vBqMN3U/LjREJA8Km9IT4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=t4Mtqj3nQVSRgot0DKVv24mccdGC/0JT1wtPWJRtQ/gFIP1oTyrTbU/lPCO2oqUoca
         PPIB8Mg5exOdopXGJHEhARDP+YAKyoiLyQMJtkK46/XRAV18xSrohK1aYyfLVtNb6unc
         BbYuxNNVrLpFTuqyRMs7q0SXv9UGhBrR4eamg=
Received: by 10.216.10.77 with SMTP id 55mr7213953weu.17.1283306003893; Tue,
 31 Aug 2010 18:53:23 -0700 (PDT)
Received: by 10.216.164.19 with HTTP; Tue, 31 Aug 2010 18:53:23 -0700 (PDT)
In-Reply-To: <AANLkTi=O5SbLRttzR0YwrHVEMz5gxtdTo9Z5C6V1yE1e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155001>

On Wed, Sep 1, 2010 at 7:33 AM, Geoff Russell
<geoffrey.russell@gmail.com> wrote:
> Thanks Shawn,
>
>...
>> You really needed to run:
>>
>> =A0git repack --max-pack-size=3D.. -a -d
>>
>> The -d flag tells it to remove the old packs once the new packs
>> are ready, and the -a flag tells it to reconsider every object
>> in the repository, rather than just those that are loose.
>
> Ok, will try.

The repack failed with a "fatal: Out of memory, malloc failed", perhaps=
 I
just need to try a machine with more memory!

I'm still interested in whether clone from a client take note of the
pack.packSizeLimit if I set it
on the server? Or does it use the client value?

Cheers,
Geoff
