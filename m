From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] Remove deprecated commands
Date: Sat, 12 Feb 2011 15:04:31 -0600
Message-ID: <20110212210431.GA8808@elie>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <4D4852EE.6080605@lsrfire.ath.cx>
 <20110202005748.GA13803@elie>
 <4D543FB4.1040709@lsrfire.ath.cx>
 <20110210205620.GD21144@elie>
 <4D5689FA.90804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 12 22:04:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoMeC-0007PK-Sy
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 22:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab1BLVEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 16:04:40 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53801 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1BLVEj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 16:04:39 -0500
Received: by gyb11 with SMTP id 11so1565239gyb.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1cRjDIey92z7E9T/JhRHDwhU8Jxhtsd0ykswht1L0L0=;
        b=IEAZ7DF/itX4zUcYX6TmFPrcFTsSxYiyy2YagpM2ca+mBBqbRd+1+uG8C84p/I1C05
         /Ox4uDoMbYD46PM2XTQTqn/cIXkeH2lAZpUNIBbuaGKFDbP7LlWtfWWRG/JDhx83fB85
         241cq6MXFpfpOfkMkeHZi5y1jFcQT5SjX6p3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NKN9CrG5JL/5FmfMWCSuqt8wICLJHgRIrWppe4nsAHl2pGU3VHo5qaa+CwTjKymBm/
         cdx0hn+O7kU4Z5VETJNhV/BHMRyblurmI4q9nyPc+2c5FxfmSRVrm3huDlIrpc1WrEiZ
         DHDO6I3/a1XJ120cQMbBGZ35gLSoGkyfr2fZ0=
Received: by 10.150.218.10 with SMTP id q10mr2341489ybg.351.1297544678251;
        Sat, 12 Feb 2011 13:04:38 -0800 (PST)
Received: from elie (adsl-69-209-71-45.dsl.chcgil.ameritech.net [69.209.71.45])
        by mx.google.com with ESMTPS id p2sm495182ybh.15.2011.02.12.13.04.35
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 13:04:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5689FA.90804@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166623>

Ren=C3=A9 Scharfe wrote:

> Subject: [PATCH] repo-config: add deprecation warning
>
> repo-config was deprecated in 5c66d0d4 on 2008-01-17.  Warn the
> remaining users that it has been replaced by config and is going to
> be removed eventually.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Looks good to me, for what it's worth.  Thanks for taking care of it.
