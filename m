From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 21:48:46 +0100
Message-ID: <m2fwur7olt.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	<1290517990.10366.17.camel@drew-northup.unet.maine.edu>
	<4CEBC8C9.4010905@drmicha.warpmail.net> <m2d3pwj8th.fsf@gmail.com>
	<1290532016.10892.40.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Nov 23 21:49:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKznQ-00053t-4U
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 21:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0KWUsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 15:48:55 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43653 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab0KWUsy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 15:48:54 -0500
Received: by wwa36 with SMTP id 36so9113521wwa.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 12:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=OZRLq/gU/4+Uko5VzwxtCGPV38KgxMsNJVb1i8rKYtI=;
        b=HnzIaHGkmCVphXkHq9szXyOb5VgBSu1ULEnQsaEpiB+kbjh+tAQKV43IDYvurFTPBh
         8Zo404FnIOv6Upe93r3ABaIz1Bh3zzBFcDZEv0hT7z5//rhtywfZcA3rEF9Ft2oCTERz
         gXeuCye5PPQisVIbxJ/e9Uk2YuRrAMMZpL+MA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=tXOaRqMBC7yBzKvzHQCBT/C9dLNdUA3XQpJiiB/ExOIFzYlR5o/nU2GYvENoMI/u/g
         JhZSEg/CUGNc2Mc3lxHv3kBO73/zsjCBdQTfn4goJJP/WR8ZE1zwi1bDxSJ8nBc77gIm
         lxiHE57M82bJ5rIULsA2m9VQE3nPoTkiR7E4M=
Received: by 10.227.68.206 with SMTP id w14mr8228633wbi.144.1290545332482;
        Tue, 23 Nov 2010 12:48:52 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id h29sm4401960wbc.3.2010.11.23.12.48.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 12:48:50 -0800 (PST)
In-Reply-To: <1290532016.10892.40.camel@drew-northup.unet.maine.edu> (Drew
	Northup's message of "Tue, 23 Nov 2010 12:06:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162026>

Drew Northup <drew.northup@maine.edu> writes:

> On Tue, 2010-11-23 at 17:36 +0100, Francis Moreau wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>> [...]
>
>> 
>> >> I recommend re-installing the docbook-dtds package alone and in
>> >> isolation from other Yum/RPM transactions. If the xmlcatalog file is
>> >> correctly regenerated AND the docbook files are there AND you have
>> >> (re)run ./configure prior to running make AND you don't have filesystem
>> >
>> > Don't do that unless you're using configure for git usually. I don't
>> > think Francis is, he's setting make variables.
>> >
>> 
>> I won't, I just call make with some variables set.
>> 
>> >> errors THEN you should have a successful build. (Barring something that
>> >> crawls up out of the rabbit hole--other than a rabbit.)
>> >> 
>> >> Fix the most obvious possible problems first before seeking
>> >> off-the-beaten-path solutions or worse blaming somebody.
>> >> 
>> >
>> > ???
>> >
>> > catalog sent to Francis off-list, which closes this topic for me.
>> 
>> Not really I'm afraid...
>> 
>>   xmlto -m manpage-normal.xsl --skip-validation man git-diff-index.xml
>>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>>   /home/fmoreau/git/Documentation/git-diff-index.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>>   D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>> 
>> This is with your catalog.
>
> I really hope you don't have any filesystem errors. May be worth
> checking before attempting to reinstall the docbook-dtds package.
>
> In any case, you are apparently missing the docbook XML 4.5 DTD/XSL
> files (from your local cache). It automagically fails over to trying to
> fetch them over the internet (which I've noted doesn't work very well).

Ok, I fixed the problem by reinstalling the following packages:

    - docbook-style-xsl
    - docbook-dtds

I suspect something went wrong during Fedora major updates, at least
that's the one I'm going to blame for now ;)

Thanks both of you for your help.
-- 
Francis
