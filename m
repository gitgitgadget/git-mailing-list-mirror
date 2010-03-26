From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 20:22:44 -0300
Message-ID: <4BAD41C4.7050508@gmail.com>
References: <20100326215600.GA10910@spearce.org> <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org> <4BAD3C6E.4090604@gmail.com> <20100326230537.GC10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvIri-0001SN-0y
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab0CZXWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 19:22:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45401 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0CZXWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 19:22:50 -0400
Received: by vws8 with SMTP id 8so1699153vws.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Z0Sx0U2Kg61Xic2gx2wPjzkOOTHA3Yakhfvhz648Jdc=;
        b=x4phJSUJoGRypPDiLi/c38El9gl9je3aJIRciDW2Xp+zCXLkoCVqCsEcQgLy4Ex7dg
         0FWpCq8jhInGdrj6ydgbD7XpZlTPD1129Rxg0Jyvjqv7ivmcSEKcGLa2v4GGqL1YiIEx
         2xZ+Z96AT9ExsY+UIrR7kBQSzk6S9IAdYvCA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=S2d+rEnNjjrHblTSQp95w/6R0QcA4xBMrHXK4nkbzCfgPk9DmlBdbbPeflTZga8HyV
         2UwthHhHZxAzIbUAequABYuKW+/dLYTxmJCPxgR1nGQJszQCLh7yP/vOnlRWKTjd5da/
         P86veGzZOOzNj0BCJJ6ftIifto3jvl/CI1RS8=
Received: by 10.220.62.201 with SMTP id y9mr1006206vch.219.1269645769720;
        Fri, 26 Mar 2010 16:22:49 -0700 (PDT)
Received: from [192.168.0.2] (hlfxns0169w-142068217168.pppoe-dynamic.High-Speed.ns.bellaliant.net [142.68.217.168])
        by mx.google.com with ESMTPS id 25sm31512389vws.1.2010.03.26.16.22.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 16:22:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
In-Reply-To: <20100326230537.GC10910@spearce.org>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143299>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10-03-26 08:05 PM, Shawn O. Pearce wrote:
>   $ git filter-branch --index-filter '' --all

This and a few other variations I tried does rewrite things, but the
problem persists:

mikelifeguard@arbour:~/Code/git/stewbot (master)$ git filter-branch
- --subdirectory-filter '' -- --all
Rewrite 5b5d93ca1ebcbc90c3ad688b9b9751d014b452a8 (8/8)
WARNING: Ref 'refs/heads/master' is unchanged
WARNING: Ref 'refs/remotes/origin/master' is unchanged
WARNING: Ref 'refs/remotes/origin/gh-pages' is unchanged
WARNING: Ref 'refs/remotes/origin/master' is unchanged
mikelifeguard@arbour:~/Code/git/stewbot (master)$ git fsck
warning in tree a39aa6d4a6dcfd6c14d8f818bbdf1dfcb3e11771: contains
zero-padded file modes

- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkutQcQACgkQst0AR/DaKHudmACgtZ67Tv1pO769BL5OvduZacix
BvMAoLr1UTf5UTd6zowRDHLovBVSY+0R
=n/G1
-----END PGP SIGNATURE-----
