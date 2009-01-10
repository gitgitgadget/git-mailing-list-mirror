From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #01; Mon, 05)
Date: Sat, 10 Jan 2009 10:10:35 -0500
Message-ID: <2c6b72b30901100710u1f15db5bh2b9ffb7686f826ce@mail.gmail.com>
References: <7vbpulnduj.fsf@gitster.siamese.dyndns.org>
	 <2c6b72b30901092015l2405627aqf928e43c12eabc3c@mail.gmail.com>
	 <7vr63by9cw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 16:12:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLfVg-00057p-Ax
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 16:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbZAJPKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 10:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZAJPKj
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 10:10:39 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:48407 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZAJPKh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 10:10:37 -0500
Received: by bwz14 with SMTP id 14so30244425bwz.13
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 07:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=H4sUErNChiNNxm6ucmCyRXJsMvYwH7IJv+XnvZShHQo=;
        b=O/W2MaxC2IrMqg50Z8wKMdviDwNP/cCjefN3p3rQn6xm796JTPZJ3VFW7kFS/kMecQ
         giIKxBh9wcLWZvZwdXhPT+g/zmkU6X9VBMKo8fBk/upM0zW6JvyQ8TjAak6HLXEGlWLo
         0qdeVae6wgx5fAr2f1nMKqN1US76LEkXl0yS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JL1rrvwyX+9rMXB1Q1Y7RpMXjFdBDTsEnMiJLfPcTWkaiJd+/ETP5MOIC1nXbYiy6e
         SNCc4cdI+cu2uPrmOs+6uYNy/cV/Cu/eSUw+h3Gm96kfQikN6R3wHRLYWYZHH4cEL1oe
         JruA9GeP8ZfiA06XPJ3TSdbLZEsjWbVMrr+D4=
Received: by 10.181.135.5 with SMTP id m5mr10187907bkn.87.1231600235388;
        Sat, 10 Jan 2009 07:10:35 -0800 (PST)
Received: by 10.181.215.20 with HTTP; Sat, 10 Jan 2009 07:10:35 -0800 (PST)
In-Reply-To: <7vr63by9cw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105120>

On Sat, Jan 10, 2009 at 01:15, Junio C Hamano <gitster@pobox.com> wrote:
> "Jonas Fonseca" <jonas.fonseca@gmail.com> writes:
>
>> On Tue, Jan 6, 2009 at 01:33, Junio C Hamano <gitster@pobox.com> wrote:
>>> ----------------------------------------------------------------
>>> * mv/apply-parse-opt (Sun Dec 28 00:03:57 2008 +0100) 1 commit
>>>  + parse-opt: migrate builtin-apply.
>>
>> This broke apply for me after updating to the current "next" earlier
>> today.
>
> Thanks.  I think this patch would fix it.

Thank you for the quick fix.

-- 
Jonas Fonseca
