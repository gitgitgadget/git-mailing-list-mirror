From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/7] fast-import: Let importers retrieve the objects being written
Date: Wed, 13 Oct 2010 15:10:45 +0200
Message-ID: <AANLkTi=p6KyW4dupXw7C0VXB3EyW5TdgR_qe1rZUmkH-@mail.gmail.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-3-git-send-email-david.barr@cordelta.com>
 <20101012223827.GB15587@burratino> <AANLkTi=MWyK=_7jK7B_0+GD4fWJcyjk7n+zAP2eKKw2H@mail.gmail.com>
 <20101013000741.GK15587@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 15:12:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6182-00010z-OD
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 15:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab0JMNMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 09:12:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47089 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0JMNMM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 09:12:12 -0400
Received: by gyg13 with SMTP id 13so124285gyg.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=F35xzHugtG/kee9DoQ6Owur9G80SvW0ZdLoerL7OQ1E=;
        b=T9qXWRZuKfSgQTXg4OUiqPt+M2yvjJBw6jXx8O+9JwP5oQYtEc6q3bq4+PDErFQDwS
         iyx+sQuoD7Y001cGNWy5DwCAlPKzHK+dgdAeyiiGxkzz1EbNE/JlVLpfufUr9gwmuSC8
         ahNaRX/giLtdJ1vILBHBIYxHZpGBul0sHCb+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c4tr4uU4YJCEgSFa35Pq7yB6xbcznAKSXCqxHbqElR2Pb1+ny4K8UwuolQbo3UzLCB
         Z/ssWXTEbPcI+dOSQHBmBLdmqgpwPnSQtLzxZw64ib8YwAhRH5URsqGugo7mTgvTg9+F
         EVcOLpaSLqy8X6CkfxzatLdWXgAQknC0l/xDE=
Received: by 10.151.11.1 with SMTP id o1mr969010ybi.215.1286975465580; Wed, 13
 Oct 2010 06:11:05 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Wed, 13 Oct 2010 06:10:45 -0700 (PDT)
In-Reply-To: <20101013000741.GK15587@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158934>

Heya,

On Wed, Oct 13, 2010 at 02:07, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> But the "cat" name might be too valuable namespace to reserve for onl=
y
> this. =C2=A0I have no strong preference either way. =C2=A0Maybe the c=
ommand
> should be named "cat-blob".

Let's do that, call it "cat-blob" and restrict it to blobs.

--=20
Cheers,

Sverre Rabbelier
