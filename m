From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/7] fast-import: Let importers retrieve the objects being written
Date: Wed, 13 Oct 2010 01:07:17 +0200
Message-ID: <AANLkTi=MWyK=_7jK7B_0+GD4fWJcyjk7n+zAP2eKKw2H@mail.gmail.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-3-git-send-email-david.barr@cordelta.com> <20101012223827.GB15587@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:23:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5oBw-0005PD-Np
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab0JLXX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 19:23:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61185 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab0JLXX1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 19:23:27 -0400
Received: by ywi6 with SMTP id 6so1264419ywi.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 16:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MuAsQu7NvuZ37s2HLaWAfFmkKsBQC7i61SjrClFhcSE=;
        b=KciYCf1kjof+K3MX3DyA1ZMmlyCQL+HY/Pr83lGVQ9XTT/EjG5pdrwE3IW4f3TSodB
         gz8JS8YC44qjKOjsV0tdbYNxXD13NXD6aqRKjmyvRAAr0Dt66/9qeRCfMHYG9Cl3OpAG
         uje+LwXjSMbdDpe1p/8/c6WqI9CPmAWa30PBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=e02Ill5B6dY+Fj1bqUgf69aV3hmr9MMLIX6zrPQdJ91QvWgFpxhpxV3FjusSGn7Zkx
         eOAERzpPB6qDRwdrRxPwYUzXsUei2DZYsroFN+mNjHTiHiMRJoci2R9S3PuNjlY+Tsdl
         iLadk9BENjl/x5b292D+hptWnzSb9IW/g92yQ=
Received: by 10.150.201.18 with SMTP id y18mr9014047ybf.329.1286924857447;
 Tue, 12 Oct 2010 16:07:37 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Tue, 12 Oct 2010 16:07:17 -0700 (PDT)
In-Reply-To: <20101012223827.GB15587@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158897>

Heya,

On Wed, Oct 13, 2010 at 00:38, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> At any rate, that is not needed for the current version of svn-fe,
> is it? =C2=A0So maybe it would make sense to strip down the patch to =
just
> allow
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cat <blob>

Do we want some sort of type indicator to make it easier to extend? So
"cat blob <blob>"?

--=20
Cheers,

Sverre Rabbelier
