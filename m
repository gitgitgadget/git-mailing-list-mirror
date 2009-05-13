From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 08:49:58 +0200
Message-ID: <81b0412b0905122349n729f0081j2f9b5b546da80306@mail.gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	 <20090512151403.GS30527@spearce.org>
	 <alpine.DEB.1.00.0905121808480.4447@intel-tinevez-2-302>
	 <D1E08DA2-8D8E-4D45-A50A-F32E3448D6E9@gmail.com>
	 <alpine.DEB.1.00.0905122237230.27348@pacific.mpi-cbg.de>
	 <4A09E719.4090205@gmail.com>
	 <alpine.DEB.1.00.0905130222460.27348@pacific.mpi-cbg.de>
	 <4A0A5BDB.9030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 08:50:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M48IS-0005H1-3d
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 08:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991AbZEMGuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 02:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbZEMGt7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 02:49:59 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:49447 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbZEMGt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 02:49:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so218455fkq.5
        for <git@vger.kernel.org>; Tue, 12 May 2009 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wVV603LGhdlkUwICGMiNW2cvplphszGg8rml1j5HrXg=;
        b=aKFAbdvkB0GgT5v97lDqM7ZQLhiAmu0tu0+Ypd+zlJg7jxWQeVeZ1zRkIYu6iIux9A
         9/2qDFdCuY4y2vVz1g+y/ag82ndsmZPMwbWRqDpdTzbjQsvPkdnI+1mm6EfhRVnojesv
         dUDrBfGcFAVawduUtStqv8PIafoUupRF2XvJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w1g2pWFFiOiqgNt+NBBr11LFZYo9u6vfZUaPjmh4HlV2cnQi25ALgaEwsiTD/FL8Jw
         Fjcp7p3Lqzl5kbk6kxq6t19TUVLy5oulXm50NHPEFfmXNR3AK53TVC5JI9vMVvioa3Xq
         F+ERnVnGAX09mqGMk2HOF04BONsn8zhTzGNUA=
Received: by 10.204.72.15 with SMTP id k15mr608050bkj.14.1242197398278; Tue, 
	12 May 2009 23:49:58 -0700 (PDT)
In-Reply-To: <4A0A5BDB.9030602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118989>

2009/5/13 Esko Luontola <esko.luontola@gmail.com>:
> Johannes Schindelin wrote on 13.5.2009 3:23:
>>
>> Well, that rather settles things, no?
>>
>
> There is need for the feature, but it's unfortunate that the Git developers
> do not see its value. There are many users for whom using non-ASCII names is
> necessary (for example all of Asia and most of Europe), but now it seems
> that Bazaar is the only DVCS that handles encodings correctly:
> http://stackoverflow.com/questions/829682/what-dvcs-support-unicode-filenames

Many Git developers just use systems which don't care about the file names
encoding at all and just keep the names as they were. So interoperability
problem does not exist for them. So, they either don't need the feature,
or can trivially avoid or workaround any problems.

> I see that there are some tests in the /t directory. Which command will run
> all of them, how good coverage do the tests have, how reproducable and
> isolated they are, how many seconds does it take to run all the tests? Is
> there some high-level documentation for new developers?

make test. See also t/README. We like them. I always run test suite before
deployment and sometimes run it just for fun (unless I have to run it
on Windows).
