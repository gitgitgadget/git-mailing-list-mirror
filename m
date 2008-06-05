From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH v2] rollback lock files on more signals than just SIGINT
Date: Thu, 5 Jun 2008 09:02:02 +0100
Message-ID: <e2b179460806050102m1ca15b2fj61d32ca45e4770d4@mail.gmail.com>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org>
	 <alpine.DEB.1.00.0805291341290.13507@racer.site.net>
	 <483EAD69.9090001@gnu.org>
	 <alpine.DEB.1.00.0805291456030.13507@racer.site.net>
	 <483EBF1F.9000809@gnu.org>
	 <alpine.DEB.1.00.0805291541430.13507@racer.site.net>
	 <E1K1jnV-0007HC-Om@fencepost.gnu.org>
	 <e2b179460806040440m29f2326ek3757660646686623@mail.gmail.com>
	 <7vhcc9xg5j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paolo Bonzini" <bonzini@gnu.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git mailing list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 10:03:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4AR1-0005OW-LJ
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 10:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYFEICH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 04:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYFEICG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 04:02:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:60791 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbYFEICE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 04:02:04 -0400
Received: by wx-out-0506.google.com with SMTP id h29so335639wxd.4
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CHKNegEZT5Wh2nYDgrPMkXZ8lIzdu8aGp2MYJUgGhcQ=;
        b=T6PQgwjqhWTL43DzX+Uv/L4qWeUcYUwdkSAENyR4+bH+sbbpWKbK+tc9OU1y7xrSIA
         4Vheob4eEOAihiODrzWicugRwBLdZulVXF7o5fYHUR0YenxXHYzMhKC5Mq4R5klyM19W
         TXEntROWVD55dHdi6Vn36RAlyHMgbxcdsp4Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZfDpDloDrWqiSC9Ntp+EKmA4JpSB6jTDRCuWCnsIW6fBNUTISXScNlV0XIo+lxN61Y
         t6JveWIxuP7U9r0B40TKLJbMWwME/7LCUtwwjpNGZ7L+XmKBEV1dgHJBiFg3t/CKyruK
         UhR71mVtAXP91X5y28nevkSLtQiGezzjSfLz0=
Received: by 10.70.31.4 with SMTP id e4mr1177748wxe.12.1212652922189;
        Thu, 05 Jun 2008 01:02:02 -0700 (PDT)
Received: by 10.70.110.16 with HTTP; Thu, 5 Jun 2008 01:02:02 -0700 (PDT)
In-Reply-To: <7vhcc9xg5j.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83876>

2008/6/4 Junio C Hamano <gitster@pobox.com>:
> "Mike Ralphson" <mike.ralphson@gmail.com> writes:
>
>> 2008/5/29 Paolo Bonzini <bonzini@gnu.org>:
>> ...
>> This addition to the testsuite breaks it on AIX with the default sh
>> (ksh). Replacing the explicit sh -c with $SHELL_PATH -c fixes it for
>> me (as I have SHELL_PATH pointing to bash). If that's acceptable I can
>> post a patch if necessary.
>
> Like the attached one?

Yes, something like that 8-) Thanks for applying. Actually getting
patches out from my work domain without the egregious disclaimer, and
to get them to actually show up in the list is still a bit of a faff
here.

> I noticed quite a many "sh" dependencies in other test scripts:

I'm happy to pick up a bit of janitor work on the tests after this
release. I notice we have a few non-executable test scripts, and
several 'duplicate' test numbers which might also want to be looked
at?

Cheers, Mike
