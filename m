From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 17:36:42 +0100
Message-ID: <m2d3pwj8th.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	<1290517990.10366.17.camel@drew-northup.unet.maine.edu>
	<4CEBC8C9.4010905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 17:36:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKvrU-0008En-4o
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 17:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788Ab0KWQgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 11:36:48 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58402 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753Ab0KWQgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 11:36:47 -0500
Received: by wyb28 with SMTP id 28so8453398wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=BKgxsSvLIdmNYpxW6L06DN63rn9zJpdm64tLlZIhe30=;
        b=IOZBhp+plSiLK/W9GGpGguz6elh9qhB5RykQ9ppQhQA+j0cRHaI8IvXgDio6Jjfbm4
         XNvUnHkut1VavLPtST0XTrE2e9ZJaSGRwX/bljPKzjAhZZux4ecBU3Otqo8Rb5Men4js
         YedwiKWgMp2bHURIFSAaVIAIYMzir1SqhPe8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=x/65E3wLB9Tj63Gx/miF/pHNbsIxY8INfIIQoNbYKrpZnpCewc/3uF01/HmAv7Y1T3
         5sVBTtarHE3ZGvxKaQbeGxCXzx2mUGkFUMxGad576ht6eW9TzztDKrqc69RH3yNPCskn
         0IZP9vNRAKgQm/DTFJ5DIdi1SMJlxUzRx2OHU=
Received: by 10.216.156.1 with SMTP id l1mr1133089wek.90.1290530205900;
        Tue, 23 Nov 2010 08:36:45 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id x12sm2954187weq.18.2010.11.23.08.36.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 08:36:44 -0800 (PST)
In-Reply-To: <4CEBC8C9.4010905@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 23 Nov 2010 14:59:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161981>

Michael J Gruber <git@drmicha.warpmail.net> writes:

[...]

>> I recommend re-installing the docbook-dtds package alone and in
>> isolation from other Yum/RPM transactions. If the xmlcatalog file is
>> correctly regenerated AND the docbook files are there AND you have
>> (re)run ./configure prior to running make AND you don't have filesystem
>
> Don't do that unless you're using configure for git usually. I don't
> think Francis is, he's setting make variables.
>

I won't, I just call make with some variables set.

>> errors THEN you should have a successful build. (Barring something that
>> crawls up out of the rabbit hole--other than a rabbit.)
>> 
>> Fix the most obvious possible problems first before seeking
>> off-the-beaten-path solutions or worse blaming somebody.
>> 
>
> ???
>
> catalog sent to Francis off-list, which closes this topic for me.

Not really I'm afraid...

  xmlto -m manpage-normal.xsl --skip-validation man git-diff-index.xml
  I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
  /home/fmoreau/git/Documentation/git-diff-index.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
  D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"

This is with your catalog.

-- 
Francis
