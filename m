From: "Brian Foster" <blf.ireland@gmail.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Fri, 18 Apr 2008 11:29:23 +0200
Message-ID: <a537dd660804180229i263fea0cxb7f7ac9e8f4780@mail.gmail.com>
References: <200804161626.44174.brian.foster@innova-card.com>
	 <a537dd660804180141h25b7f8e2yf7283f63d49521e6@mail.gmail.com>
	 <48086200.5020600@viscovery.net>
	 <200804181114.47067.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 02:30:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmmvU-0003ks-Fc
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 11:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbYDRJ3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 05:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756502AbYDRJ3d
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 05:29:33 -0400
Received: from rv-out-0708.google.com ([209.85.198.251]:63505 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753193AbYDRJ3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 05:29:31 -0400
Received: by rv-out-0506.google.com with SMTP id k29so264902rvb.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=b8gzB5DjHxnfNuC7sbD3bPjivlw4lmilRt1axF5yIn4=;
        b=TfHMI+taN/p8u0VotsOMs7mvf6/vfEuPD6ZQUqHEFXOPLZITIZXBCYAxtLarhI1MSIFFBokL+2vdcW5I5pPJCmtPqnan/HN9ylTwoNnBX7oLF/OmDUPdt3rOI8wsHsT+zu//gjERwfWOc+aghwa3tZ4UsWqKBw1pO4ASHEhfHSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cikgs+DbauwXTel0fDvc9ZetVRaKQDrrWaTvKfSixozPO3b2YAGlGbv+eguQA6ZEyMTYIuRTWE0zHQkgcYQKv0xIFvWkKgni1HkAtzdMcUY2ro4XG5BXBjs6+EHZMv310nc9rjJw8lo7L8rsTtXtyKNU6Uii2mGVEpF8qfa4RPQ=
Received: by 10.141.20.7 with SMTP id x7mr1381357rvi.82.1208510963858;
        Fri, 18 Apr 2008 02:29:23 -0700 (PDT)
Received: by 10.141.123.21 with HTTP; Fri, 18 Apr 2008 02:29:23 -0700 (PDT)
In-Reply-To: <200804181114.47067.brian.foster@innova-card.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79869>

Johannes Sixt <j.sixt@viscovery.net> asked:
> One of the changes since v.1.5.3 was to get rid of this bogus grep
> [ in `check-ref-format' ].  Can you install a newer git?

Hannes,

 yes!  about 10 minutes ago I was handed the keys to a
 brand new VM which is to be the company's git server.
 a very important point is it will be backed-up (unlike
 the former repository!).  git on the VM is "my" problem,
 and one of the first things I must do is install it.

 the VM is running "CentOS release 5 (Final)".  all things
 being equal, I'd prefer to install a reliable/stable
 pre-built package (RPM, I assume, since CentOS is based
 on Redhat).  I confess I do not know (have not looked)
 where to find suitable RPMs of git.

 suggestions are most welcome!

cheers!
	-blf-

-- 
"How many surrealists does it take to    |  Brian Foster
 change a lightbulb?  Three.  One calms  |  somewhere in south of France
 the warthog, and two fill the bathtub   |     Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools."  |       http://www.stopesso.com
