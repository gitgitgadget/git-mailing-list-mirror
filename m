From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow testing of _relative family of time formatting and 
	parsing functions
Date: Sun, 30 Aug 2009 10:10:44 +0200
Message-ID: <81b0412b0908300110l5dd07b9ejdd0e2af7df517542@mail.gmail.com>
References: <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
	 <20090828190319.GA9233@blimp.localdomain>
	 <20090828191521.GA12292@coredump.intra.peff.net>
	 <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
	 <20090828193302.GB9233@blimp.localdomain>
	 <20090828205232.GD9233@blimp.localdomain>
	 <7vk50mz41e.fsf@alter.siamese.dyndns.org>
	 <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
	 <20090830075140.GB14217@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 10:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhfV2-00029s-P8
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 10:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbZH3IKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 04:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbZH3IKo
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 04:10:44 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48997 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbZH3IKn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 04:10:43 -0400
Received: by bwz19 with SMTP id 19so2273718bwz.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D1l6GC4zO5jJa25Dcfsd25yxwRGoPlJnakpJVcEVjzg=;
        b=c9d7iLNbOfrtwF4GQMd8FHiHq2MlmzIbBpxFVYEnXp53XrNQvppVgpxLwcuyVgIb8E
         eBkm2Tsmi8eH+BURYbK412e4Cgp+7TGG7/UspGcDdlRR5jMEk1Q0D1DLbOVXrcjAC3Wb
         hR+NVGf/iNf4KbN/O0o+xsk6c9YKstQhyWROc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=up7bHPEZzJ1gZiW9oB2la7AEFahmqHDDgqovf/YTMBaSboh4Ihm+De2aRVu1C+gI+S
         tRpZ6QHTFdcyC4lP7s6qbdpu4ndS0OQAd2zBg14T+BZEuakr7X7ssAzuTIfs7Vv3dFCY
         6kfrZ+TZyts04Y7GVAdGQxx2m1rawHMpmhsZ8=
Received: by 10.204.153.13 with SMTP id i13mr2873719bkw.161.1251619844997; 
	Sun, 30 Aug 2009 01:10:44 -0700 (PDT)
In-Reply-To: <20090830075140.GB14217@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127399>

On Sun, Aug 30, 2009 at 09:51, Jeff King<peff@peff.net> wrote:
> On Sun, Aug 30, 2009 at 09:25:11AM +0200, Alex Riesen wrote:
>
>> >=C2=A0Is this intended as a serious submission for inclusion?
>>
>> Not yet. AFAICS, test-date is never used in our test suite.
>
> No, it isn't, but I think the point of this is to change that.
> So it is useless without an extra patch to the test suite. I'll try t=
o
> put something together.

Thanks :)
