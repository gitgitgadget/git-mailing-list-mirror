From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git clone NonExistentLocation
Date: Thu, 17 Feb 2011 14:03:29 +0000
Message-ID: <AANLkTin3Pf4XD_gbwxPzW4uff9SbDWJdGug6jM_SHDo+@mail.gmail.com>
References: <4D5CE3E7.5030101@atlas-elektronik.com> <4D5D1715.5020707@drmicha.warpmail.net>
 <4D5D1A04.4090107@atlas-elektronik.com> <4D5D1BCB.3010003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 15:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq4Sv-0005gd-9m
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 15:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483Ab1BQOEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 09:04:13 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54326 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab1BQOEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 09:04:11 -0500
Received: by yxt3 with SMTP id 3so1126077yxt.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/JqORz6XrL0nT5QSEa2+Q5vJpsemV3xZP2uusdItyb4=;
        b=lIirWOCHaVa8U3iHBXMCwIS73BKRwMvlKLW+ZnjHSoyh5KEEtAaiW/xxtZ6GFDtl56
         bERvBmt2K0U5ADZLLpXURSUebF1ATuXGWuMi+l92ibPAK9Zr9kL7tYDXewbxwSFdfmqd
         NosRKkwBXynYDBlyiDMMuIAYRW7Vvm4b6MSwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UmYSsBb42tg2dxPJgdpa4MX5P7k3KATtbhU1O1SuITGorF7vR0+O3JAsiGmjDSoFPA
         t5kuvFdQzMXvp1t7YTM0a8Ek9qvX4GuMD+pb/8RBfpkK+Un8RSbQuyIRLTT/YaxSGpfJ
         3Gw1wcrdk/vmCkYkjl14YLW6JPjaKXRDDxwxY=
Received: by 10.150.96.21 with SMTP id t21mr2420255ybb.20.1297951449260; Thu,
 17 Feb 2011 06:04:09 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Thu, 17 Feb 2011 06:03:29 -0800 (PST)
In-Reply-To: <4D5D1BCB.3010003@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167086>

Heya,

[Thanks for summarizing.]

On Thu, Feb 17, 2011 at 12:59, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Sverre, with your 86ac751, the following two are equivalent (modulo a
> warning) on a nonexisting dir:
>
> git clone dir
> git init dir
>
> Is that intentional?

No, that was not intentional. The former should still be an error if
'dir' is an empy directory.

-- 
Cheers,

Sverre Rabbelier
