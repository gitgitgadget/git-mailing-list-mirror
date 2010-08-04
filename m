From: Jared Hance <jaredhance@gmail.com>
Subject: Re: How to create branches above master
Date: Wed, 4 Aug 2010 08:04:22 -0400
Message-ID: <20100804120421.GA2228@localhost.localdomain>
References: <29342864.post@talk.nabble.com>
 <AANLkTik-qw3bFHWLwMnqJuzgu=HHSRiiVRBW2nfjRTy3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 14:04:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogci3-0007OK-2t
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 14:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640Ab0HDME2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 08:04:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38023 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab0HDME1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 08:04:27 -0400
Received: by qwh6 with SMTP id 6so2893043qwh.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mt6o/rnRWfL1Nx7V447idyUspfIRSMshNxMhLn4sqZk=;
        b=NlCr5MEZfbyxVtmBGqKqop0rqBnW9eyF7tirU0ZBVRrB1+X8l+t6nPuLPz9mp1o4Hm
         1LrV8LdrWilQnl7b54C+5Z8i0VEAzIrRr57pcWN0l50PYnPGnK9CY9czfKaOhKwWRWTa
         +8xsctUDANxy7qiDAvvEbCPFyc6Q0AXtWnfSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BWvXBt5W5DLGLOqIxUrcwl/b4MD7V0Me3PDIGoWPNs1FyPWkSdnyosb7SZNNfSCUOD
         oHDCvGL/fQPawDYXVzPyo0JN54gqZc8o446enHZeaZhwdj6C3Ba3m9hJSz0JRP18DgLv
         L+W4ASytR3Q9wd2ktWKcCC6lL8HSCVMklhXBA=
Received: by 10.229.184.149 with SMTP id ck21mr2214307qcb.160.1280923465861;
        Wed, 04 Aug 2010 05:04:25 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id t21sm2846630qcs.8.2010.08.04.05.04.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 05:04:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik-qw3bFHWLwMnqJuzgu=HHSRiiVRBW2nfjRTy3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152575>

To Bharani: It sounds like you are using one repository for
multiple projects. Git doesn't handle this use case very well.

On Wed, Aug 04, 2010 at 08:07:56AM +0000, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> > I got different projects which I need to integrate in "integrate" b=
ranch and
> > give it to testing and once the bugs are fixed it should go to "rel=
ease"
> > branch.
>=20
> See git-merge(1) et al for how to merge branches.

I think he might need git-cherrypick for this use-case since you don't
want to merge all of integration into release.
