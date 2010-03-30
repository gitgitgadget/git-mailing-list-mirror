From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: RFC - "git editlog" feature for fixing up local commit messages
Date: Tue, 30 Mar 2010 14:36:27 -0400
Message-ID: <32541b131003301136h4454f02cyd5a94d746e844a8d@mail.gmail.com>
References: <20100329133132.GA12201@thyrsus.com> <32541b131003291314r2f5a77e8g28e79b5983821e41@mail.gmail.com> 
	<4BB1BBDA.2050102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 20:36:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwgJ4-0007yO-2K
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 20:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641Ab0C3Sgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 14:36:49 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59370 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab0C3Sgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 14:36:48 -0400
Received: by vws20 with SMTP id 20so943584vws.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AldqGREcOItaRVOaoIJ/oFuvx6CEkW4h0Ak+xbUc3iA=;
        b=ApTcFfbINMT9AiwGE1G/OT0PENyX3CyoT3GSFTMj+ov57Og3RAQr8QfmkYSe1G/VGG
         QD3Ot0/ti1NLW60yBeWeL12v2U4j5FyEyHfoESWX9FlK7/JAf2acQwKI78RhHYfK4g1C
         tdL1SaiV1oQQJAFvfrtQX87zq0sw6/FP8ERPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DCvZtspAqNR5g+uRI9j8y+m+XCCBhqCYl7o6dH2nCG67EM7Sz0W2sIaeKllZ7MoBkp
         xl2FVolU6IsxwedozDc8QJPzRs/32sK02FmJ+eIhO3tDIVWEij60y2Jj9OTcdAVvFUR0
         FQwOZ40STmBAGmodOj0LDyAQ1GzOyUl3xXnSs=
Received: by 10.150.203.4 with HTTP; Tue, 30 Mar 2010 11:36:27 -0700 (PDT)
In-Reply-To: <4BB1BBDA.2050102@drmicha.warpmail.net>
Received: by 10.220.107.28 with SMTP id z28mr3972688vco.100.1269974207168; 
	Tue, 30 Mar 2010 11:36:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143588>

On Tue, Mar 30, 2010 at 4:52 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Avery Pennarun venit, vidit, dixit 29.03.2010 22:14:
>> A further option would be to extend git-rebase--interactive.sh (yes,
>> it's just a shell script) to take an option that makes a given commi=
t
>> (or commits) 'reword' by default instead of 'pick'. =A0And maybe ano=
ther
>> option to make git-rebase--interactive.sh not actually pop up an
>> editor before it starts running. =A0Then your editcommit script coul=
d
>> just be a thin wrapper around rebase with those options.
>
> I think the OP's point was that filter-branch is better at keeping
> merges in place; I'm not sure if this is true when rebase-i is used w=
ith
> reword only.

I've never actually tried the "--preserve-merges" option to git rebase
-i, but the description sounds as if it's supposed to not have this
problem.  Can anyone confirm/deny?

Thanks,

Avery
