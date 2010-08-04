From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git merge - "both added" conflict resolution
Date: Wed, 4 Aug 2010 18:36:52 -0500
Message-ID: <20100804233652.GB3595@burratino>
References: <AANLkTi=Hp6DsE75XbgehS2bucp-M9NXmGgYbvw0kp6j8@mail.gmail.com>
 <20100804205916.GC2920@burratino>
 <AANLkTi=dScNMsf4XZ+sS8R+424fESyOr6wYO4WamAutj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 01:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgnXO-0003KR-6X
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 01:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757602Ab0HDXiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 19:38:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45316 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab0HDXiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 19:38:12 -0400
Received: by vws3 with SMTP id 3so4621845vws.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cj1F8V05w6RaYNFZegGo6QNzkJNOXse3NnhaG+RBqiY=;
        b=dr5yXu9YG003eg3wntb2nnv3inB8MJb0aHqvpSBv39kJdZWGPnPaLgspfBoxcFTl+V
         /pI0ZNxPNFEhhpK8WkBiP+Nt1CBtz9Mbb4+S+XGXD/NdgE0OB/7klngzsdfLGBQ/6Pbs
         mBPrGdGbu+PFpoxQfsH5kTT6wb4BjPnfCB1IU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bi4FPEry2e0rfvyq6ftxpL0FDHjVk/OIIHNVGsm2VLp871gOh/Sg/qnqTNC5Jq4qEM
         sRvBUB4z7wW3JZFXn7XTiTIxDHo3gJ2K5UmZAjS8JeNniBJ9aE+KbUVTcrMa/Ip6xoju
         MTww4WaT2shMVlOIbpJTdr2myckBlD4BSKctA=
Received: by 10.220.62.136 with SMTP id x8mr6781203vch.10.1280965091095;
        Wed, 04 Aug 2010 16:38:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v11sm7950324vbb.11.2010.08.04.16.38.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 16:38:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=dScNMsf4XZ+sS8R+424fESyOr6wYO4WamAutj@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152611>

Eugene Sajine wrote:

> So, I'm removing all conflict markers and removing the incoming line
> with the property value=3DprojectOne leaving it as projectTwo.
> This effectively means that there is no changes in build.xml for git.
> And I'm stuck because i cannot add file, that is not changed

Sorry I wasn=E2=80=99t clear before.  Could you give output from attemp=
ting
to add the file?  It is supposed to work.
