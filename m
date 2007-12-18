From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Tue, 18 Dec 2007 10:24:52 +0100
Message-ID: <200712181024.52495.jnareb@gmail.com>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org> <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com> <7vlk7s38aq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Joel Becker" <Joel.Becker@oracle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:25:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4YhZ-00071K-Qp
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbXLRJZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 04:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbXLRJZA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:25:00 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:16443 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbXLRJY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:24:59 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1952505fkz.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 01:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=iCMIKufKvzAoCetLlFlfS61Dr3j/Iazd/YHX+0Uvu1U=;
        b=rzjYffYI+7J909HMFyhUNEFk0LJNfKwJMFXLNLokfj4Sytt4Ii32SrjKFEVmSHx3IvoHKmLX+NUvqRYeCaaYE91MuSh1Dr4FzWKeiFObub9aqCtOgXO4SCGCaUf8hA71IPGe30hU/sC/3he6Mf2Aje0LyIi0ycmu82Y5U+60vnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=K8J2Nx0j5pR1wR9qm6+IaAhKVCQgOZVvCVR1ABQfxm1NwchQoEw8dGG41B6cFinU/tIBSBmOyew7y75oS4yYtTzxHrFni/1RXZjovwHgIm4L7IS/x+mFKRc+XAS7XoCqdpLViXYxKo2k1yEKswc0eca6pyoUQEp8u1u4SnwP7C4=
Received: by 10.82.107.15 with SMTP id f15mr2319608buc.0.1197969897500;
        Tue, 18 Dec 2007 01:24:57 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id z37sm1332742ikz.2007.12.18.01.24.55
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 01:24:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vlk7s38aq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68716>

Junio C Hamano wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> 
>> If cvs 1.11 doesn't talk with 1.12 I'll say there are nuts - minor
>> revisions should interoperate with end users not even thinking about
>> it. But 1.5.5 has in its changelog lots of deprecations and interop
>> changes.
>>
>> It's not good communication to label it 1.5.5.
> 
> There indeed are handful scheduled removals.  I do not mind declaring
> that 1.6.0 comes after 1.5.4, or just relabel the removal schedule for
> 1.6.0 and keep the scheduled change on hold a bit longer.

By the way, I wonder if there would be packv4 in time for 1.6.0;
perhaps not enabled by default.

-- 
Jakub Narebski
Poland
