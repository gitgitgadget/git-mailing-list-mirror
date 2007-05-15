From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Tue, 15 May 2007 17:50:52 +0100
Message-ID: <b0943d9e0705150950g14261b94h7133514965ebe85c@mail.gmail.com>
References: <20070506150852.8985.98091.stgit@yoghurt>
	 <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
	 <200705151821.08568.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Peter Oberndorfer" <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue May 15 18:51:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho0El-0000PZ-Hd
	for gcvg-git@gmane.org; Tue, 15 May 2007 18:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983AbXEOQuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757347AbXEOQuy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 12:50:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:19286 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757983AbXEOQuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 12:50:54 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1620812uga
        for <git@vger.kernel.org>; Tue, 15 May 2007 09:50:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s+g7CgoKL0D+XaOtaLsIzFSeUf6nXkp313RUXMyIsZG//jcDVi00npVtPprAegTGhA28BGy1K70sXd0lJ+llV8Mq1uWJjmwYH7UMxDQ7M+NC2Fg/d1nFbjF340ccfkTMg70aTPJ7oDwK96uPdXDwlF7D/RgX2yXum/yty3rKPkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g+qy3sHutaRd8FbmwPJAEMsqx8BjCKOTvUJNhfTIVfqPDF5lstQ2zkVx4XtedYyRHCy/ZzvFlG1Eyrosb2dMb/SUBtc5RLdXbXz6cuYKNXg66JBMtl1eP1+UEHvW13YA1UCXnGrWnIsZLrR/ovfuQfj/mfonVTtatZXAcdwgNN0=
Received: by 10.67.116.3 with SMTP id t3mr6077337ugm.1179247852573;
        Tue, 15 May 2007 09:50:52 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Tue, 15 May 2007 09:50:52 -0700 (PDT)
In-Reply-To: <200705151821.08568.kumbayo84@arcor.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47358>

On 15/05/07, Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> this is a bit OT,
> but when i wanted to try out this changes i found that 2 unrelated patches in you repo[1] are empty.
> * Store branch description in the config file
> * Make the "name" argument to "stg new" optional

Thanks for pointing out. They failed to apply cleanly last night and
forgot to delete the empty patches created. I fixed the conflicts and
added them today (I'll push them tonight).

-- 
Catalin
