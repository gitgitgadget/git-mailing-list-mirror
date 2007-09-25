From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: Fixes and improvements related to diffs
Date: Wed, 26 Sep 2007 00:21:20 +0200
Message-ID: <8fe92b430709251521j2b596016l186bdbb08c6cf816@mail.gmail.com>
References: <8fe92b430709211431m7a93a11cp915988a57801edd6@mail.gmail.com>
	 <7vodfq4ch0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 00:21:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaImW-0003Ru-DC
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbXIYWVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXIYWVV
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:21:21 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:26541 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbXIYWVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:21:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1830266rvb
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=N87AmAkd/gaPiQIQTGq6WGxvl5r3EOv2tKKGlTURgGo=;
        b=RmD1ys29KFPcjoLoCQ6JeXASliG+n1E57LZWZOO164aLDyFyJFQYZ3Oe0+t7TaNopMD+m4ru2ogWTe4vYEXAeS9usHphU7N9nyGE/C6Fvc7cHHAR3uCmU54eGqM2a4zfd6kkrYUk2Yg3cHkAyeFbDliwLiS7tg/eGnhgEryarsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sBygf9PfHHHplxeHFhLAnMYp68kgkbXrgTeTQCvftTLSFnzSerNnZNjDAhFnpmD5iDfugall7JGGnhaeC0LTyAPNvFoDYXFwbPP9e/l6/Y+X1Pvs40oxRlaC4RRu8q8rotHNMmG6vPmNPEPi0ipFgiMai0lwbkG2MEYOE1xmplA=
Received: by 10.114.53.1 with SMTP id b1mr8430291waa.1190758880077;
        Tue, 25 Sep 2007 15:21:20 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Tue, 25 Sep 2007 15:21:20 -0700 (PDT)
In-Reply-To: <7vodfq4ch0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59180>

On 9/26/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jakub Narebski" <jnareb@gmail.com> writes:
>
> > This series of patches adds fixes, simplifications and improvements
> > related to diff handling in gitweb ('commit', 'commitdiff' views).
> >
> > Becaus I didn't have access to Internet, this series is based
> > on 1e61b7640d09015213dbcae3564fa27ac6a8c151 (v1.5.3.1-1-g1e61b76).
> > As I am sending it via GMail WWW interface, patches are send as
> > attachements.
> >
> > I send this series now, even without good Internet access,
> > because it contains two bugfixes, and one code fix. I'll try to
> > resend it rebase on top of current master later...
>
> I've parked the first two in 'master' and was hoping to roll
> them into 'maint'.  I haven't taken a look at the other three as
> I was waiting for a resend.  If you think some of them are
> bugfix material for 'maint', please mark them as such.

Third fixes a rare bug when gitweb screwed up names of files
in the patchset part of commitdiff view. This took place only
(diagnosed by pasky) when there were different files which
had the same preimage and the same postimage.

-- 
Jakub Narebski
