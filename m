From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable Items
Date: Wed, 18 Feb 2009 23:19:15 +0100
Message-ID: <bd6139dc0902181419n504dde97y8b3a8862b3f081cc@mail.gmail.com>
References: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com>
	 <20090218163002.GB22848@spearce.org>
	 <200902182159.51027.robin.rosenberg.lists@dewire.com>
	 <20090218214859.GN22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 23:21:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZumc-0001Ar-Kp
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 23:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbZBRWTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 17:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZBRWTS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 17:19:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:61075 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZBRWTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 17:19:17 -0500
Received: by fg-out-1718.google.com with SMTP id 16so996887fgg.17
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 14:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=dftA3dDmDEDDuXc6vC8nv9+UdlpjA5q4qbY7Yuh/LTg=;
        b=Jh3n0IXbjVZTMKcMuv3mc4nzRhpEc1CAua7Bvx2HRLcLkbaObDmJJgTaldZw/cTg5T
         x8nd5rOfOQDvXtMPRTy5Sbg/rA9sGwCFa7aUQ9Rx2EyKP0Vw2mjp5rcTvUU/cWxISTTJ
         2lYbWeyYuYcVuR1XfXGLVsR3UX4suInI7uf7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CFqgy1YjrT1m7bDqGu86WM2LmrylXsPYGG4PI8GCQVSd9DscldpJfXPIWN3BPRqQDN
         F090duA+SMsunGbBfByNR5BmY0alkn3Fgmjp4Ss6/l2dn0b1wpzRm8708C3syKlTZuEZ
         iwT49wdSTr5rzchXK9e8SwmKtfVJYY2Wg2C1A=
Received: by 10.86.53.8 with SMTP id b8mr3026380fga.58.1234995555520; Wed, 18 
	Feb 2009 14:19:15 -0800 (PST)
In-Reply-To: <20090218214859.GN22848@spearce.org>
X-Google-Sender-Auth: e05a5ef07d7449ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110587>

On Wed, Feb 18, 2009 at 22:48, Shawn O. Pearce <spearce@spearce.org> wrote:
> Non-Java reading a Java serialization stream?  Seriously?

That would be a contender for UJSFWIINI :P (with JS standing for Java
Serialization).

-- 
Cheers,

Sverre Rabbelier
