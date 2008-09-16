From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Tue, 16 Sep 2008 19:12:04 +0200
Message-ID: <200809161912.06571.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com> <fcaeb9bf0809140345n11d41430ma9b4096c66776b0c@mail.gmail.com> <alpine.DEB.1.10.0809142038190.19489@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Tue Sep 16 19:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfe7B-0006qc-D8
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 19:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYIPRMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 13:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYIPRMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 13:12:16 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37772 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYIPRMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 13:12:15 -0400
Received: by gxk9 with SMTP id 9so27918275gxk.13
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SF8cSaHVghrqABzqw2AO+uuSD83sjB6kFrzvz7TEWKc=;
        b=RAB0X2R8s29IukTAa4+v/68Z6A4cIvqA2Mm7b2ft0y/8aU3Sz+4L6BxqaFdFC1TxfC
         igcCYZD5nKq2ZAUDXZ7ny755ctuTf2gQZdUV2ueVvzrq2wllyJeUIUu/t7CyPvCwoQOA
         2G/gYor33pKD1FhYQFk385fF6bOCdMlLuLPY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Vx9NtqbrjdZVAgRBGFSIfjTNu0HjR5c0QlemQpYrF2lCTiRAf8nLeaugDtM4OO79Ga
         gOyh96Iq6hdl7Rl4jOdKUg/rPakNAQyR0E+ewvBsii89L6C58SlObki0mwht2XQLsFq1
         dnqSx7MZbjZk+49Zfm32Orv8oqk8iAPqYo6ao=
Received: by 10.86.26.1 with SMTP id 1mr982726fgz.35.1221585133900;
        Tue, 16 Sep 2008 10:12:13 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.240.247])
        by mx.google.com with ESMTPS id 3sm17072947fge.3.2008.09.16.10.12.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 10:12:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.10.0809142038190.19489@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96018>

On Mon, 15 Sep 2008, David Lang <david@lang.hm> napisa=B3:
> On Sun, 14 Sep 2008, Nguyen Thai Ngoc Duy wrote:
>> On 9/12/08, Jakub Narebski <jnareb@gmail.com> wrote:
>>>  15) Do you miss features in git that you know from other SCMs?
>>>     If yes, what features are these (and from which SCM)?
>>>     (Open ended text - Essay)
>>>
>>>  Total respondents       1046 (some/many of them wrote 'no')
>>>  skipped this question   1249
>>>
>>>  This is just a very quick summary, based on a first few pages of
>>>  responses, Full analysis is I think best left for after closing th=
e
>>>  survey, because I think this would be a lot of work...
>>>
>>>  So here is preliminary list, or rather beginning of one:
>>>   * sparse/partial checkout and clone (e.g. Perforce)
>>
>> Have not read the survey result, but do you recall what is the most
>> used term for sparse/partial checkout? What SCMs do sparse/partial
>> checkout? I think it could be usable as it is now in my
>> will-be-sent-again series, but I don't really know how people want i=
t
>> to from that.
>=20
> the most common use-case is people who want to follow a project but
> (at least think that they) don't need the history. so they want to
> save time/bandwideth/disk space by not downloading things they don't
> need.=20

Errr... the idea is to implement partial (sparse, narrow) _checkout_,
which is doable, not partial/lazy _clone_, which is very, very=20
difficult.

Partial checkout *might* help reduce disk space because usually=20
repository database (which is compressed and deltaified) is smaller=20
than checkout; and if it isn't you can always use _shallow_ clone (only=
=20
part of history) and/or remote alternates (with reference repository
not on your quota, or on different filesystem).  And it might help
checkout/commit/diff/status times (performance) on slow filesystems,=20
with extremely large number of files in full checkout.  But contrary to
centralized SCM, where server is usually net away from working area,
partial checkout doesn't affect network usage _at all_.

--=20
Jakub Narebski
Poland
