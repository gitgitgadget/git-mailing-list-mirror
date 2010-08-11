From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Encoding problem on OSX?
Date: Wed, 11 Aug 2010 02:55:03 -0500
Message-ID: <20100811075503.GD5450@burratino>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com>
 <AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com>
 <20100809234620.GA6418@burratino>
 <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:04:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6IY-0003az-Tj
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234Ab0HKIEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:04:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36693 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab0HKIEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:04:10 -0400
Received: by gxk23 with SMTP id 23so4018489gxk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iTOtZBzNSmKwiElCsfI9T1MINBC5/FSVtT/cyadk0EQ=;
        b=Mv6Jpci1nsKNsvlAMjJ3aM802KaBrlfShfT5UHiLg3zc2WikY3D0zx0gkNQBbV6Dc4
         hxEmK9CpEIQsVqEff+NiGWfOVgeWPGPBVYsfUKxWNvFx92Nq/Hdp5RuThIPqKJ1tXcoK
         ZWY+KlfKK4c5O89L1ve+mOv7cUfHHWUCJeM2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fBV+uOO3dLW0eMJ9KS1gaYF1hxMEpBgkRQmIZTRoFpqiD4F/BTBpVz7cECzKOgrj7D
         B/KWFJ9pgt0qH2mXeUtOBNmtSeNbbDUCq1FH8SiXDw2kBkpZcCfCR5FuoShPSjiWb0S6
         8FOUXMQyWsE5VWCquJPb3PZ3SVxRUFNnL2Z7o=
Received: by 10.101.20.12 with SMTP id x12mr21265631ani.95.1281513392073;
        Wed, 11 Aug 2010 00:56:32 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w6sm12188295anb.3.2010.08.11.00.56.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 00:56:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153199>

=C4=B0smail D=C3=B6nmez wrote:

> [~]> printf 'Th\360\235\204\236s\n' | sed 's/.*//g'
>=20
> [ismail@havana][08:51:06]
> [~]>

Thanks for checking.  So sed is not completely broken.  Could you try

 sh t4201-shortlog.sh
 cd "trash directory.t4201-shortlog"
 git log
 cat "trash directory.t4201-shortlog/log"

?
