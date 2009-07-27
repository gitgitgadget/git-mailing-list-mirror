From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2009, #02; Sun, 26)
Date: Mon, 27 Jul 2009 16:09:56 +0200
Message-ID: <81b0412b0907270709kd6a5b8fy51829099d7b488e5@mail.gmail.com>
References: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 16:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVQz8-0004kh-Rb
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 16:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbZG0OPR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2009 10:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZG0OPR
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 10:15:17 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60847 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZG0OPQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 10:15:16 -0400
Received: by fxm18 with SMTP id 18so2620978fxm.37
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ewRrutzogFViimUlx7gXho0MLur+s8nnD8MAbEzUidc=;
        b=AcMXLzfGke2EwyKtVZlKfKrEBfB66ZuqsijpxzYDdDmfKwc4gdmtL+To35k1r0/sNG
         Ao6CdQUFaX3/btYTgkXPPDuP5TRkkLD4ODyaaVvm8UxC42lOuV+/5Jn2ZQQuE+a3hqFP
         hATwp+wkojiUqEEzvgqTvOWzLWAnsJA2EmKA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GLEReBu+z60EbG1NQjIbpnVeK6eeHloPl0zdqgtcieOvcBqQfwSkBAOr6geUBifG3Q
         sGUtVlZjyOxEhVQI75khWaVxqFCy+sf0wsuKRSaGq4o5oEJ1dURsQ/PZUXBy17CrYCow
         xAeq7fplUC58upj5sBCrF+LBg1OUyOpLHSBFA=
Received: by 10.204.63.8 with SMTP id z8mr2844903bkh.55.1248703796384; Mon, 27 
	Jul 2009 07:09:56 -0700 (PDT)
In-Reply-To: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124169>

On Sun, Jul 26, 2009 at 10:47, Junio C Hamano<gitster@pobox.com> wrote:
> * ar/maint-1.6.2-merge-recursive-d-f (Mon May 11 21:25:36 2009 +0200)=
 2 commits
> =C2=A0- Fix for a merge where a branch has an F->D transition
> =C2=A0- Add a reminder test case for a merge with F/D transition
>
> Although the reported breakage is covered with the patch, Alex feels =
the
> solution unsatisfactory. Cleaning up D/F conflict handling in merge-r=
ecursive
> may be long overdue but seems to be a hard problem.

Maybe promote the testcase patch to master and drop (or leave it in
next) the other patch?
So that the reminder reminds not only people running next but also anyo=
ne who
happens to look at the output of their test suite run.
