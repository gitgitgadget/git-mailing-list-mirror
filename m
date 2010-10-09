From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Sun, 10 Oct 2010 00:12:36 +0200
Message-ID: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
 <20101008081509.GA2845@kytes> <4CAED762.7040708@gmail.com>
 <74AF320B-5D82-4622-A7BF-61C847D4059A@cordelta.com> <AANLkTi=zS+oj1iHMh-gKVD=2dG5tLwA+bia9E6U3o=zW@mail.gmail.com>
 <20101008170939.GG9212@burratino> <5A2A5584-FB25-46C2-8891-B667C46011D3@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 00:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4hfM-0000OB-Aj
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 00:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0JIWM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 18:12:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48152 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab0JIWM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 18:12:57 -0400
Received: by gwj17 with SMTP id 17so669460gwj.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=0xCwrRFWWTv2tNf4ofNxQujqyUkbThbZwyHDgmcZFVU=;
        b=jLgK0U3zJintIGUNmd67X7zmb9mwjp5DaeaYIH70p4r+YwYwvVMtG/LHZ3a3J0LZGu
         jjp9Cpp5dXLn132yS0r/okthcLpzfStNcoTf4lBSNhMi2zIYbBffIrKWIbQyNMRLFnsE
         lASZcyz2apnDtyRz528MTzafdXPgyIBrMDHfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mZHjNU0VCveL1k197t88BaA7RsB/f+jP6Hbg0xlyW+hpuyAWsrPW8pRVbvCwrf436E
         yfociIGWcEB/58JyoO2pBFpgAHYhTcYfjnYlYZu3zFjq6FKa09B3h+w7zNcKZqbcpY1i
         n5ApkaM3pBupaKNRbhmYnpMaXP0gaWRaHQCZE=
Received: by 10.150.147.11 with SMTP id u11mr5008331ybd.386.1286662376301;
 Sat, 09 Oct 2010 15:12:56 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Sat, 9 Oct 2010 15:12:36 -0700 (PDT)
In-Reply-To: <5A2A5584-FB25-46C2-8891-B667C46011D3@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158632>

Heya,

On Sun, Oct 10, 2010 at 00:11, David Michael Barr
<david.barr@cordelta.com> wrote:
> v1.7.3-rc0~75^2 (Teach fast-import to import
> subtrees named by tree id, 2010-06-30)
> has a shortcoming, it doesn't allow the root to be set.
> Extend this behaviour by allowing the root to be
> referenced as the empty path, "".

Yes, that would be a good addition.

-- 
Cheers,

Sverre Rabbelier
