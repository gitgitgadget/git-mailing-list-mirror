From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH/RFC] Documentation/git-gc.txt: add reference to githooks
Date: Tue, 29 Jun 2010 09:00:29 -0700
Message-ID: <AANLkTilZsHJ20hGehY5eqOfS8jt--ne_QGp4z8SyNeUD@mail.gmail.com>
References: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
	<1277744834-7546-1-git-send-email-judge.packham@gmail.com>
	<4C28ED49.90906@xiplink.com>
	<7vsk45c09m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 18:00:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTdEp-0000XC-02
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598Ab0F2QAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 12:00:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53868 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab0F2QAg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 12:00:36 -0400
Received: by gyd12 with SMTP id 12so1456267gyd.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rf5bLELacoMl1rPB3mjvXkl75vBgKnWyb21BiDR9YSM=;
        b=GYtFJ0BiYtYQZHaKzN6ivl2hGCx03gdilJOJgPz+yazlJUKpG16+jK2X+wCh5m59Zz
         I39cy6Pt7HIIabdZRn2fQBHD1dmN0XChqOopja7oDJ+a5wpNWa+ZzZaKqJOru196w41o
         whbGYdAluPInl0yYg3a7pjhsjQ8GjAfJinGr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RoAzQIa2tmQLOwzs1S7N7tj7hbGi7kjax43wgplJd5MO4s0RIC+nq7sb7vVa1ENg7E
         2H47jAr7RdNZbUkuDHpnljgAcX//q6mX6PuTjly5FhXl66yRKJlbj8LNK9QtmuCxtNJv
         Gn3nm4AgBxr5yKDKVJMjMpm3pGwX5OtaRVZ/w=
Received: by 10.229.183.210 with SMTP id ch18mr4019363qcb.130.1277827229721; 
	Tue, 29 Jun 2010 09:00:29 -0700 (PDT)
Received: by 10.229.39.146 with HTTP; Tue, 29 Jun 2010 09:00:29 -0700 (PDT)
In-Reply-To: <7vsk45c09m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149912>

On Tue, Jun 29, 2010 at 8:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> How about also adding a templates/hooks--pre-auto-gc.sample file?
>
> Please don't, as samples are propagated to all newly created repositories.
>

OK. I won't add a sample hook.
