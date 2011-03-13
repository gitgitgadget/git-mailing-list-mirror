From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Using libgit2 code in git.git as a Google Summer of Code
 project?
Date: Sun, 13 Mar 2011 22:41:24 +0530
Message-ID: <20110313171121.GC19763@kytes>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
 <20110310101332.GC26851@elie>
 <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
 <AANLkTi=q6mxGQcdb-Gx9t3TZWDRbNpiZV-iyjgd=NrXj@mail.gmail.com>
 <AANLkTi=6huFKCqrdfvjXXfYrd0GaeZKmiEg-9UjipBKK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, libgit2@librelist.com,
	git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 18:12:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyoqK-0003ZR-Dq
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 18:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab1CMRMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 13:12:31 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53562 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559Ab1CMRMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 13:12:31 -0400
Received: by yia27 with SMTP id 27so1757904yia.19
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Rw4bMi0z3OP8J/gmd+EtwUFaSY/YC16O+e294Vwr3eI=;
        b=IxnfKtdw6aRoow66I62L76XEqyujOBTLgjCwEnAtZ1vjt2Rx+loXkixqlvAC/dmPJa
         hAzgrK9X5wVwoJh01w9xsXu10gZtv0XfvlmCjWSHUS7pHoJf2yRCXaNpZl4d7j1TlF6G
         q0E44rzNkOJJBCsbVLEcUjt9tZMzx4JLniTPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PePE5HIisNL1RQhORgamd/Fkoo1A4Os1WLCzIVDMZgov8yHQlVPbZdGI5XDrx+uvj1
         5Y7nk2Ebw4+f0er2TRMtvryAvw6QdrDvUDX7D72SgsKVR1rUR2WfGN0H4e+V/WtLeWQc
         /5tnNSbmgouQcMGEsVI1QuXXvxNdRuH8/kUaY=
Received: by 10.150.72.20 with SMTP id u20mr1681269yba.288.1300036350235;
        Sun, 13 Mar 2011 10:12:30 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id q29sm4688873ybk.22.2011.03.13.10.12.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Mar 2011 10:12:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=6huFKCqrdfvjXXfYrd0GaeZKmiEg-9UjipBKK@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168972>

Hi Vincent,

Vicent Marti writes:
> You can see the key features we are lacking in the SoC2011 ideas wiki:
> 
> https://git.wiki.kernel.org/index.php/SoC2011Ideas

I thought we should de-couple both ideas and put up the idea of
getting libgit2 merged on the wiki too: in the process, I've reworded
things a bit. Please revert these changes if you think they're
undesirable.

Thanks.

-- Ram
