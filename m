From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 13:05:41 -0500
Message-ID: <20101027180541.GA20527@burratino>
References: <20101027173644.GB15657@burratino>
 <0016e645b8c87a160804939cdc5e@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Euguess@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 27 20:05:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBANn-0005Xw-C1
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 20:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab0J0SFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 14:05:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34308 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab0J0SFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 14:05:50 -0400
Received: by gwj21 with SMTP id 21so621563gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PuQnu07m19EKYysMvch3ASpKRRChJHncUBxpIvOguJY=;
        b=cr/ucl5Xs0lg99QNuquvx6TPBP3Ctk79lPOISwwjv98frNoeKV3Q7pNTbQWEiFEdwd
         GGkqlhoFPDogT1HTv9Ns5eH+glmp1X2JrO2N5iZr//GMbHPVCyn3iNfGbLlAg5/+0Umf
         aqm170M+nbI+9NcovG1FVAeUcFoG/djZzuiC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=a7WlVDU9Y3SFHqBCV9bV+6YHKsXAUi9a6/7qZLDQM/wyQ5FNedoh05B6bTLgdDTIzW
         +VvZ5CyGX/0tV5fcCPwfi7cCNjiiTiK431PxafD0mKnvYDKxtOeNyzBSvdnZ2Mzjrqkv
         Z7NeCnIi4tkBx36/wcddYVXUYd+b1RQbiM7fY=
Received: by 10.91.203.34 with SMTP id f34mr1328620agq.132.1288202749603;
        Wed, 27 Oct 2010 11:05:49 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n49sm19691yha.34.2010.10.27.11.05.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 11:05:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0016e645b8c87a160804939cdc5e@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160110>

Eugene Sajine wrote:

> So, I just have to run git pull --rebase to get my scenario working, =
right?

Maybe the =E2=80=9C[branch "<name>"] rebase=E2=80=9D and =E2=80=9C[bran=
ch] autosetuprebase=E2=80=9D
configuration items could help.
