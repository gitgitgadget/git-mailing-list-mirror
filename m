From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Sun, 10 Apr 2011 03:31:13 +0200
Message-ID: <BANLkTimbAmW+ueq1Z9PJN9opXggywdxdnA@mail.gmail.com>
References: <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com> <4D9EDCEA.9010903@drmicha.warpmail.net>
 <20110408185924.GA25840@elie> <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
 <20110408194548.GA26094@elie> <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org>
 <BANLkTi=3LPRzohnZStAogddpL5ZLehb97Q@mail.gmail.com> <20110409081108.GE13750@arachsys.com>
 <BANLkTim5DPjGjJ=SfnNfXpzCd6=PKnSs6g@mail.gmail.com> <20110410001518.GA6380@elie>
 <7v39lqzzn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Chris Webb <chris@arachsys.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 03:31:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8jVG-0003ly-96
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 03:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab1DJBbe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 21:31:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48062 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab1DJBbd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 21:31:33 -0400
Received: by iwn34 with SMTP id 34so4551610iwn.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 18:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=mbSDPVZ4aMeLQ/P16kBQTYohsIBDpCMHVmVgA+nvh4Y=;
        b=P/qTzf/d4NSOf2lzlL40pgYcJil2a+waLaG8bt85gSX4OkVbkEGp42v2mgI15lfuyf
         o2IPvTqxHKeC1+YDRHgnoO/cLFNHm7PsBKgyuoBnsVIChW3cO8CQwMsza1B78RSfMWyk
         s/hysUiuYMlJBb7Mko2vSXIaxpF1Z4n0hpDBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w3e8aPd/Q0mu1+bJrYGMfG0FS5X6gddxauUEVyl/4cgdg0aL50H5+GhrqS+9OxceJp
         eDlFhHDdG4jGcbAkIf5g6RgzZYoVOGBQexWUdruaZzi8y839a10E3CSsa4SXD+O9GhEf
         KaVWno8QYpcAvgZRl35tVN1hNY8Wu1UPVGs8o=
Received: by 10.231.61.198 with SMTP id u6mr3752536ibh.160.1302399093089; Sat,
 09 Apr 2011 18:31:33 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Sat, 9 Apr 2011 18:31:13 -0700 (PDT)
In-Reply-To: <7v39lqzzn9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171230>

On Sun, Apr 10, 2011 at 03:03, Junio C Hamano <gitster@pobox.com> wrote=
:

> That is exactly why git does not store metainfo. =C2=A0Storing auxili=
ary
> information on commit objects or tree objects to help build or deploy
> procedures is fine, but that kind of information should be stored
> somewhere that the normal git operations would not care about.

Keeping this information out of git's way during operations in which
it's not needed is obviously A Good Thing. Yet, this would only happen
when this information has been added to the repository on purpose.
Thus, I don't see this as a deal-breaker.


Richard
