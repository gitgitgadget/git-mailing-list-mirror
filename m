From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: RFD: tables in documentation
Date: Sun, 02 May 2010 15:51:56 +0100
Message-ID: <1272811916.24767.16.camel@dreddbeard>
References: <4BDC74F3.2020206@drmicha.warpmail.net>
	 <20100502050622.GF14776@coredump.intra.peff.net>
	 <4BDD7E96.2050603@drmicha.warpmail.net>
	 <1272811394.24767.7.camel@dreddbeard>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 02 16:54:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8aYz-0005ZY-8P
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 16:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab0EBOwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 10:52:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65131 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab0EBOwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 10:52:16 -0400
Received: by wye20 with SMTP id 20so1150438wye.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=ju/b+sr9st1CyO61KsUBwSFyfMqkSpgr2sBznWgGjmk=;
        b=j/PH4vWepaRzwZ6Fs/k0gzboSUPX219s5I+mZTwb3P4Od9gB4K6U8GvoUameJH4Oiq
         VT4c3Xc3F7//+MTsXYojM4DjHX5GUcb3mz07ANs1qxchS0Ev6Kx0MpQ2/I8VXythINlD
         ldVcOhN/w/VuH9BWoJsHrEcB/k+R1IbOY4c+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=lMlXciqtSYNVs3NL/AQ8Nvyssh2JYf1bwlGlu54QAaO1si72cF/5AC8ivFMW4yPiet
         BZhl7pTjkJyEJMujdLHraFTInv9Brpxu6oZVaNEn/7AKVRd80uzhXmcN2xwbsVfRTr5z
         yEgQRbxKyFOa+jnfaapKsP/+jrzZRDGglPQmQ=
Received: by 10.216.86.19 with SMTP id v19mr6317020wee.218.1272811934897;
        Sun, 02 May 2010 07:52:14 -0700 (PDT)
Received: from [192.168.0.129] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id b2sm26885773wbb.20.2010.05.02.07.52.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 07:52:14 -0700 (PDT)
In-Reply-To: <1272811394.24767.7.camel@dreddbeard>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146179>

sorry about that, apparently "shift+enter" means "send" to this thing...

On Sun, 2010-05-02 at 15:43 +0100, Will Palmer wrote:
> On Sun, 2010-05-02 at 15:31 +0200, Michael J Gruber wrote:
> > Jeff King venit, vidit, dixit 02.05.2010 07:06:
> > > On Sat, May 01, 2010 at 08:37:39PM +0200, Michael J Gruber wrote:
> > > Did you put the source up anywhere? I didn't see it, but it would be
> > > interesting to see how painful it is to write.
> > 
> > http://repo.or.cz/w/git/mjg.git/shortlog/refs/heads/doc-use-tables
> > 
> > Tough guess, I know ;)
> > 
> > Michael
> 

that looks suspiciously like a format that's intended to be readable in
both plaintext and eventually-generated form. This is me speaking in
pure ignorance, but would something like (though I assume not exactly):

[cols="1,3*5,8"]
   |=====================
   |		   |I		 |H		|M		|Result
   |     0	   |nothing	 |nothing	|nothing	|(does not happen)
   |     1	   |nothing	 |nothing	|exists		|use M
   |     2	   |nothing	 |exists	|nothing	|remove path from index
.2+|	 3	.2+|nothing   .2+|exists	|exists, H == M |use M if "initial checkout", keep index otherwise
						 exists, H != M |fail
   |=====================

work as intended?


-- 
-- Will
