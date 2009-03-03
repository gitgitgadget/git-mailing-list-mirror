From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] clone: run post-checkout hook when checking out
Date: Tue, 3 Mar 2009 01:55:28 -0500
Message-ID: <76718490903022255sab126c7qeab2fc60321a928e@mail.gmail.com>
References: <20273.1236033817@relay.known.net>
	 <20090303042848.GC18136@coredump.intra.peff.net>
	 <23978.1236056549@relay.known.net>
	 <20090303053750.GA30201@coredump.intra.peff.net>
	 <7vsklvhzpm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, layer <layer@known.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 07:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeOYm-0003LE-ES
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 07:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbZCCGzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 01:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbZCCGzc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 01:55:32 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:8996 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbZCCGzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 01:55:32 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2662333rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2bXUuckx/IihrbqW6xYRNrn01ho2yiuw9IU62PJmeDg=;
        b=uWQlVtS72ykw4fmTQE9gC5NpnE+qtTxvI2YOqoBKaD+2Q0Dq1992+sgcT6985T/r6x
         7HdGxG2Lb+0m9B4pVQTHRNPSpOJk5OwsEsKPp3WcwAOnVqsm8qiYy9SrhOFRnQx0tVQK
         Jwb5ui88h/8E65pI0lEqgVKPM1uTokfVf6S+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K4Sjor65WVc4p3jbH6uQ0/u/v7V3nTSoxglVthiQfGYUeRoGaoHPDPH79cULs8rmeV
         siKUfO/RtWZavNRwC4nAAMjNk9SijwxIFL7g6bjObAw9vCMmup9/2x6reymIjZHASqFQ
         xwM2JPshujnooBQEAEgkJuCr0VUj8VOrZ6Rso=
Received: by 10.141.89.13 with SMTP id r13mr3332046rvl.269.1236063328951; Mon, 
	02 Mar 2009 22:55:28 -0800 (PST)
In-Reply-To: <7vsklvhzpm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112005>

On Tue, Mar 3, 2009 at 1:45 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I do not mind queueing this to 'pu' and let people fight it out. =C2=A0=
I hate
> the local side hooks that have no reason to be there, and consider th=
at
> the existence of the "checkout hook" to be a bug to begin with

I just want to clarify: do you mean to say that none of the local side
hooks have any reason to be there, or that some of the local hooks do
not belong, and checkout is one of those?

j.
