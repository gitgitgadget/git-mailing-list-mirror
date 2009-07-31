From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 11:22:20 -0400
Message-ID: <eaa105840907310822m57cc29a4q84aa4eb274bd01aa@mail.gmail.com>
References: <20090726232154.29594.qmail@science.horizon.com>
	 <20090731104602.15375.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 17:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWtwF-0005ZC-4H
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 17:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZGaPWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 11:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZGaPWW
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 11:22:22 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:52822 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbZGaPWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 11:22:21 -0400
Received: by ewy10 with SMTP id 10so1584259ewy.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=8fHBeW4ZzvI0p2d7XHzSqJGJUU/t90T/aM7aR30cLFc=;
        b=xuiaA7R9m6P4laJYGTFBI+TK/H6Pba9Vt2g4X8rMuBO709T6rlCcumCh1I/eG2e1dN
         3pjNgQQPR5D1j8KKA519BWWRHLmY1cEFXKj2K+PM6ZjGZ6xjrUAqmdSRGvqPgg4UnhG4
         ztpjZL5MayEtLi/rl93f4tEmMZkYq83IcBEMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=TnBUe/BtljNAMJPlkdC2wVFpuJ8UenLSoCeKTYk5AoS3dkotnOewNygNvdruahP9Rh
         A2MytdLdUohLjQLNR/B/FGv5nME0TAmJ7UUICg/w5rSmXALY2iYp0pzU9us/8x5zRdFP
         /byo6fcj5HWXlsOuQ8vX5yC74LIwtzWndHBDI=
Received: by 10.210.77.13 with SMTP id z13mr3325280eba.26.1249053740698; Fri, 
	31 Jul 2009 08:22:20 -0700 (PDT)
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
X-Google-Sender-Auth: 24c290f24dddb4a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124568>

On Fri, Jul 31, 2009 at 6:46 AM, George Spelvin wrote:
> Could someone do some benchmarking for me? =A0Old (486/Pentium/P2/P3)
> machines are also interesting, but I'm optimizing for newer ones.

My Geode isn't old in age, but I admit it's old in design (and the
vendor switched to Atom right after I bought it...)

Best of three runs:

586test: 26.536597 s
x86test: 26.111148 s

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 10
model name      : Geode(TM) Integrated Processor by AMD PCS
stepping        : 2
cpu MHz         : 499.927
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de pse tsc msr cx8 sep pge cmov clflush mmx
mmxext 3dnowext 3dnow
bogomips        : 1001.72
clflush size    : 32
power management:

Peter Harris
