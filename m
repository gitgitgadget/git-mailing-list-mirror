From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: EasyGit Integration
Date: Thu, 11 Jun 2009 01:15:16 +0300
Message-ID: <94a0d4530906101515k3656a895kd36f8477d3a37b5f@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	 <4A2F0B8A.9010203@vilain.net>
	 <7vws7khlvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 00:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEW4s-0001jY-HJ
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 00:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbZFJWPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 18:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755790AbZFJWPQ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 18:15:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:43139 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbZFJWPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 18:15:15 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1381915fga.17
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xaxJOyeuUCAliQ+3p4mqO7ceqNtVUeRZkhBELT3MAos=;
        b=qiNZPHhhVD6A1/+Bdu5IgPcxTWY0SkZWKtNDwq+kcO5cv6cV+rPE2K5sgMMPBa13yA
         quPR1hlmSbHr61qZG5hFv0a0ylbpvE+kbZx2JX844KXjKIPuKFkFIuKSLshq13uvjGw6
         64/iGaAsmtPFSn6Nz0JRFU7Tj/KStgp+3vNDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FBV495ssMYdfxN4QM9fHmVi1ftnxGFdG9JyJG3lFHdhMFD4inZqcNrYCHUSTnGjIOy
         ZNj/IRMKgQEgOAsyvVr74leM4zNDIkEaCI+kgEtDCdezyiKIAwauRNkQlMVglqNXKwcv
         /gU9jcOm1afcyiGv55/pg6ICT4/SVeTD5aS5Y=
Received: by 10.86.86.10 with SMTP id j10mr1545521fgb.37.1244672116244; Wed, 
	10 Jun 2009 15:15:16 -0700 (PDT)
In-Reply-To: <7vws7khlvj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121312>

On Wed, Jun 10, 2009 at 5:18 AM, Junio C Hamano<gitster@pobox.com> wrote:
> Sam Vilain <sam@vilain.net> writes:
>
>> We talked about this much at GitTogether '08. It's true that for
>> 'reverting' a change in the past, that is the right thing to do. However
>> I don't think there is a first principles case that this is always what
>> people mean by 'revert'....
>
> Sorry; what you think people mean by 'revert' does not matter at this
> point, unless you are building a brand-new system from scratch.

Subversion is by far the most widely used VCS, it's quite likely that
new git users will come from the svn camp (I know I did), and it's
quite likely they will assume 'revert' is doing what svn does. Do you
think that doesn't matter at all?

You might think that 'git revert' is superior to 'svn revert' (and I
happen to agree with that statement), but at least you should take
into consideration the huge amount of users that would find this
behavior strange.

Personally, I would add a note to the 'git revert' documentation to be
extra-clear what 'git revert' is not.

-- 
Felipe Contreras
