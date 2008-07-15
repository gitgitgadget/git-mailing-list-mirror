From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 15:14:47 +1200
Message-ID: <46a038f90807142014l2c120467pe4a76b2c35a145f9@mail.gmail.com>
References: <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
	 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
	 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
	 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
	 <20080714085555.GJ32184@machine.or.cz>
	 <alpine.DEB.1.00.0807141256310.8950@racer>
	 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
	 <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
	 <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
	 <20080714191903.GB5788@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>, "Gerrit Pape" <pape@smarden.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:15:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIb11-0000BL-GL
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbYGODOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbYGODOt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:14:49 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:39357 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYGODOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:14:48 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5159899wfd.4
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 20:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=V27VkpMXBEpUfuf+g6ak4aJX1zSgOej2w+oPTAVLANQ=;
        b=JxSioFFo/bk+XsADzS8R+MjRGu1neBW5AkHiE8bwYm1jdWaZsd4bunvEEYCkmjaYDj
         hIPbUQfFKNqVtUwqkWXYLLNrq7BwQPk7IG6Z4RFhwNhAKQAEmrgZCl/YIv7+z2LI9j16
         ezRJ19xzO+vHgNGcfjqXYYQbjHsuadsyeX4Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=scSMpWOLiFrC4ZGJ3lmPNxQgCylnoFOOf2Hfr3qv9bbOjWL/PL66Cu6fD9bHDVMFtq
         MEwFT23nLI2dtufvox8c18GCeBKPnqX+d530G33N88TiVcxqMuyvfpNtxuSeUnfOwMoh
         n0ZcAz1UNHgHHe2FEFzg+reVSrBhLkBw2o5Ok=
Received: by 10.142.154.20 with SMTP id b20mr4466357wfe.99.1216091687588;
        Mon, 14 Jul 2008 20:14:47 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Mon, 14 Jul 2008 20:14:47 -0700 (PDT)
In-Reply-To: <20080714191903.GB5788@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88509>

On Tue, Jul 15, 2008 at 7:19 AM, Teemu Likonen <tlikonen@iki.fi> wrote:
>> But as the upstream, we have our own deprecation schedule.
>
> As Debian stable (4.0 "Etch") and its git 1.4.4.4 was mentioned I'd like
> to point out that git 1.5.6 is available for Etch users from
> kind-of-semi-official <www.backports.org>. So I guess Debian stable
> users aren't left completely behind. Git's web page already advertises
> backports.org version for Etch.

I concur. Users of git on Etch are using backports AFAIK.

We still have the case of the "casual" user, who does not know much
about git, but installs it to clone & review a project's code. There,
if v1.4.4 complains with a useful message, the casual user will swear
a bit and grab a backport. If it dies a horrible uninformative death,
then we will get  bogus bug reports, flamage, the works.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
