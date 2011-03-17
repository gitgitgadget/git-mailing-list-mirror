From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Thu, 17 Mar 2011 14:20:08 +0000
Message-ID: <1300371608.16335.1.camel@wpalmer.simply-domain>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
	 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
	 <4D773570.4010803@drmicha.warpmail.net>
	 <AANLkTimyW7CMSkXndHOW9Gbvu124YYT5e-SdGUq3-OGu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 15:20:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0E3o-0008HI-VV
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 15:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab1CQOUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 10:20:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59124 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab1CQOUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 10:20:14 -0400
Received: by wya21 with SMTP id 21so2815213wya.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=s/mhq33KPhemEHW44VF+o99gXshbk3C1S1+hQHlhp/0=;
        b=eg/xvVmhdSISOuTfYQXMCuXW38HANxW6g+aWFIjB+W0be8uyCo/1kiDNoOzYJje6K0
         6d4Og17n5ELf/xv4XS1TeoCwlyterf6k5ljOxyONDpS2kOjiA4gTjMa3vm7MTBoXFNVm
         HREfPeooyi0N6E1oXBMsCdFYBuqW+Cb4kKOO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=gcMdh4OM1cOnzbkXqi8Gy1Pf6c1no5sbsARHmNftkyimKYJgHUiwnTaUlaWyw83dtW
         XaMubaYLmgLOS/qYm+3ZSJmliXGjYPhoxrkTQ5/sS327SCp/g/X4gVTNpwruigEAuEzg
         VlCApGEEojJq2+9MCaB3rwdTQIRoo3EQXYeTE=
Received: by 10.216.121.130 with SMTP id r2mr1362277weh.96.1300371613477;
        Thu, 17 Mar 2011 07:20:13 -0700 (PDT)
Received: from [192.168.2.64] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id k76sm1119205wej.43.2011.03.17.07.20.09
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 07:20:11 -0700 (PDT)
In-Reply-To: <AANLkTimyW7CMSkXndHOW9Gbvu124YYT5e-SdGUq3-OGu@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169244>

On Wed, 2011-03-09 at 14:14 +0200, Alexei Sholik wrote:
> .................. Just ran this command
> 
> git blame -p "$1" | awk '$1 ~ /author$/ { print substr($0,
> length("author  "), length($0)) }' | sort | uniq -c | sort -nr
> 
> on the for-each-ref.c and saw that Junio had the first place by a
> relatively large margin.
> 

Wrap that up in a script and submit /that/ as a patch ;)
