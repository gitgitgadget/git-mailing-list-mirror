From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Wed, 2 Mar 2011 10:34:23 +0700
Message-ID: <AANLkTi=GhdfWCyx7MN3w0ZPhqKHcC1e6RmPeZt67OeqG@mail.gmail.com>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
 <1283769430-9263-1-git-send-email-pclouds@gmail.com> <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
 <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
 <20110226100310.GA21724@do> <7vsjvb6qmt.fsf@alter.siamese.dyndns.org>
 <20110226133639.GA32442@do> <7vpqqaffy2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 04:36:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PucrG-0002Sd-U7
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 04:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab1CBDfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 22:35:04 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46760 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab1CBDfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 22:35:00 -0500
Received: by wyg36 with SMTP id 36so5379174wyg.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 19:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=x5l9AQbCxB9Noapagdr0TI5X/kh86sEnGtRtjKcLvHM=;
        b=PKudYKtz8fvl5u3kvEMTn8/n1xRS/FPZt9kkrPN6HnnZN5SwcIR2brbCUsOR1s0b2r
         rrunlPsevZl4tfq41X02oYtgZi2kygfHBztaxLfnAHkWSH+If/manJ1vjHVMzH4Eimf9
         jlYNo20kmXC760rdfBd/W/PXgEILx4qtPNY7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qBWtu6docZI7MIG9E3OV5x3ATreR9VJR+WcRHTwO0KwhTxVgTE1QuXH5wdOBJu4udM
         /Q6KrrSdSfLgVAFLVo9pyTKxoxCRx6v1tg0sxIHtI6KiqPFy5ODnJ4LN4y+E7SNMjYjZ
         64qnpmzE3/+vv3AkhGaMt5gmeiErZL7PhcyM4=
Received: by 10.216.186.144 with SMTP id w16mr6787643wem.13.1299036894207;
 Tue, 01 Mar 2011 19:34:54 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 19:34:23 -0800 (PST)
In-Reply-To: <7vpqqaffy2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168290>

On Wed, Mar 2, 2011 at 8:51 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> OK another try. I also add more details to tree cache. If somebody
>> uses this document to create a git-compatible tool, then such a tool
>> should behave the way git expects it.
>
> Thanks.
>
> Here is what I scribbled on top of yours (not quite polished).
>
> =C2=A0...

Looks good. I don't really like ending a sentence with semicolon, but
that's just my taste.

I wonder if we should also point to relevant source files, so if this
document becomes out of date, the readers can jump in the source and
verify themselves (perhaps coming up with patches to this doc)?
--=20
Duy
