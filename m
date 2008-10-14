From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: How many users of parsecvs are there?
Date: Tue, 14 Oct 2008 17:51:12 +0100
Message-ID: <e2b179460810140951v3bcfc951xc211b70e71ec198e@mail.gmail.com>
References: <b2cdc9f30810140310l647eb2fbld3f6a1c608d029a@mail.gmail.com>
	 <alpine.DEB.1.00.0810141820110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, keithp@neko.keithp.com,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Bennee" <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 18:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpn8E-0008Gp-8f
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 18:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbYJNQvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 12:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbYJNQvO
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 12:51:14 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:40744 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYJNQvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 12:51:13 -0400
Received: by qw-out-2122.google.com with SMTP id 3so650055qwe.37
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3u1CFjg2FHxAhb4C1fRzh1Vl14gTyb1C3Fa0NIfpwkY=;
        b=DaIWjGsAq1YGE/CTa4V+cXEQ1NXjivrKFp0zDSQ3QwEtTFh6sNxV51Rf9ghSVAVgSe
         rLmmgS695MSjLLScOxyUt86o0N2AAVKwBI60V3ikeQWdZR6gMhHAZMGRJSVsHCntYEOE
         sBpTQ8+tivaSyM/Vyo+rA1X1cYRMNZ6zWsOY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KipQ7dam+IVCQ2kOtqmH+WX7+QpEO/CAO0U/NvE2JhGRYP1X7f2Y2M/8QrJp/OrY/U
         YcTCaFfgPWoq0WSG/U3b9rk36si8snAz5rDnag7d9Y04374j5ZqErAdTvfdCnueMXOeJ
         Gek2sAMC1rR0s0DDn0A7jbrV8CzSiHqAf3HTk=
Received: by 10.214.150.7 with SMTP id x7mr6841422qad.38.1224003072611;
        Tue, 14 Oct 2008 09:51:12 -0700 (PDT)
Received: by 10.214.215.10 with HTTP; Tue, 14 Oct 2008 09:51:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0810141820110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98198>

On Tue, 14 Oct 2008, Alex Bennee wrote:
>
> I'm wondering how many people are there still using parsecvs to to track
> a live CVS tree?

I used it to import some problematic historical CVS projects into git.
It coped with the (probably) broken history better than cvsps did at
the time, though I had to hack it to ignore some non-standard
directives in the ,v files (deltatype, permissions etc).

At the time that was a one-off exercise, but the project which
replaced that project has now itself been cancelled and it is just
possible the original will be revived (!)

Hopefully though, the egit project would now be sufficient for us to
go forward based on the converted history in git and leave CVS behind.

Mike
