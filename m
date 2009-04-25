From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 13:18:01 +0300
Message-ID: <94a0d4530904250318w7f368ea6hb5d59558aedc5c4f@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <20090424231436.GA15058@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Michael Witten <mfwitten@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 12:19:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxez0-0001ML-BB
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 12:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbZDYKSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 06:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbZDYKSF
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 06:18:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:55413 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZDYKSC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 06:18:02 -0400
Received: by fg-out-1718.google.com with SMTP id 16so306831fgg.17
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wYXlcFDwOBFw309VRjrmRzki4RcPN1w8+ctTG5By6U4=;
        b=bDkz/ju4w81ifznGrKbTaTQL40tE5Zz7bHUMWZmoPpQARG2GhsVdE/z+ZHHeqGAsME
         mH7ykV/9EJPuBJKR8Mb8S6MZpUiVTwoHZ1VGeLpllbR4J6MQxW+LNgFD375Hk21t7jYz
         Ek5F62cs2higo6q7ZuscuMwKf7jEof2gU7P0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kDkCtoWhEHMbtvX+ffM2+9/cspppMEocD7OmkVr/IGOhRrHWzkMzQksrACxFA7oNh/
         uoIzRKF70vsgoDugqyRTVATtSpRn06xK91hRwW65N2yiCHDaQSh7O6AMha4jqSUtZ3ao
         KDVLEe2FBKlhDtUT6wwoJKyQY+gg1EYrYooiY=
Received: by 10.86.59.18 with SMTP id h18mr1555037fga.44.1240654681361; Sat, 
	25 Apr 2009 03:18:01 -0700 (PDT)
In-Reply-To: <20090424231436.GA15058@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117543>

On Sat, Apr 25, 2009 at 2:14 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 24, 2009 at 07:11:40PM -0400, Daniel Barkalow wrote:
>
>> > Let's start a reformation of the git terminology to use analogies that
>> > have been around since the dawn of computing: 'memory', 'address', and
>> > 'pointer'.
>>
>> I actually think calling them "sha1s" is better, simply because this bit
>> of jargon doesn't mean anything else (git deals with email, so "address"
>> is overloaded). And the term is already in use for this particular case,
>> and it doesn't mean anything else at all (since, of course, the crypto
>> thing is "SHA-1", not "sha1"), and it's short (which is important for
>> making it easy to look at usage help).
>
> Junio suggested "object name" in another thread, which I think is nicely
> descriptive.

It's not a name, it's an identification, so how about "id"? You have
tree ids, commit ids, blob ids, and so on.

-- 
Felipe Contreras
