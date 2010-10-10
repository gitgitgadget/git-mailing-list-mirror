From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Sun, 10 Oct 2010 13:48:03 +0800
Message-ID: <AANLkTi=QJ8bbyNHwFibY+W9dMyiYa5s_ne0zG8Ltt0um@mail.gmail.com>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
	<AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
	<AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Akira Kitada <akitada@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 07:49:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4omY-00025Z-Pj
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 07:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860Ab0JJFsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 01:48:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53573 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab0JJFsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 01:48:05 -0400
Received: by ewy20 with SMTP id 20so194757ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 22:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Zcw7CjVKcRUx+FpcUlJ9b1gmh/cPO2Wm/Hv2oIxUnVo=;
        b=MUTCURHUeCDpRdLKJsh5ohNFrKDViC2TWKLUe0dgf/eX3LzGFv7HPLAgvUWy2gzhwb
         hX+6QEIP8K9rXvWvPaqLgRE6edCLCTUClxvnl29G8eS7zmGWgAIjb1moPIebwBs9dc3v
         GZZyYgZGenc5bRWkXXZ/8ujp398jrMpL+vYE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ekKWjTb1arrsdLhIIO+O2srLZvVhpx82YLT5m2kkMHSbv5rjYKK7UYR7aI43ZbW1C9
         fmfULBF7Q/2oW6Z8sSvUI26i2uh0G2903uLjiS3QgteDS5LenaSrp5uNaL2NKTwx+93x
         V6af8fnVnHZonaOcTOsKExUK/Dxn4LZleH7MA=
Received: by 10.213.54.140 with SMTP id q12mr996758ebg.71.1286689683563; Sat,
 09 Oct 2010 22:48:03 -0700 (PDT)
Received: by 10.213.33.197 with HTTP; Sat, 9 Oct 2010 22:48:03 -0700 (PDT)
In-Reply-To: <AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158643>

Hi,

On Sun, Oct 10, 2010 at 1:25 PM, Akira Kitada <akitada@gmail.com> wrote:
> I use perl 5.8.9 and ExtUtils::MakeMaker is 6.48.

Can you try upgrading it and running make again? I think the cpan
commads for it are "r" (show upgrades) and "upgrade".

> $ /usr/local/bin/perl -v | grep v5
> This is perl, v5.8.9 built for i386-freebsd
>
> What version of Perl does Git require to build?
> It seems INSTALL does not mention it.

Ah, Perl is used for git-add--interactive and git-svn.

-- 
Cheers,
Ray Chuan
