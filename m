From: Ilya Dogolazky <ilya.dogolazky@googlemail.com>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone', but
 not a single file present
Date: Thu, 14 Jun 2012 13:23:52 +0300
Message-ID: <CACnyznXMQyxOF+P-BdryX7duZkC4fSc6=AW1=xJbx9U8rH=ovQ@mail.gmail.com>
References: <4FD5C263.9010307@nokia.com>
	<CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com>
	<4FD6440C.7090900@nokia.com>
	<4FD67530.1090002@diamand.org>
	<4FD70DEB.7040506@nokia.com>
	<20120612222431.GA13427@padd.com>
	<4FD83A08.6070208@nokia.com>
	<4FD88DE0.4050606@nokia.com>
	<4FD8D527.6050703@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 12:24:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf7E6-0007Bw-7H
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 12:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802Ab2FNKXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 06:23:55 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48510 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab2FNKXy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 06:23:54 -0400
Received: by wgbdr13 with SMTP id dr13so1739834wgb.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xn87Gq61LBIVw/V1iH+strwe71my/qt/FO5VJP/ijn4=;
        b=VxA8iOGyrqzDY5KWO+lheoJtlRP6s1I3rmacxk1qDJd7CReCVsOffo7x3SgJCeAKJO
         Pkp5/0E3qp8j5+vrluGpxJuFWuRrGW5Mwh+g4rbh1XUnD3KJugjokc5BK817Jw8DD0Jd
         BgNdwpeESjsjX4833qg8qeOR9zEUGGua8/G8t6BVC28AMegCVtFkm2wRrmVkyGRYv1L5
         lD0uA9VRCM93IJzDT8q+3Q5l69VZ9RMDBw9a/QAb4Sui96lPcygsf4JLIs3pXWaNMlpJ
         GfT7AhLX1/rGzi75utYWkSoudXSpLDfAru7YgZHHVQP83coU5ja3tjeaggsp0w7WTaRR
         qemA==
Received: by 10.180.14.193 with SMTP id r1mr45500565wic.13.1339669432827; Thu,
 14 Jun 2012 03:23:52 -0700 (PDT)
Received: by 10.223.86.79 with HTTP; Thu, 14 Jun 2012 03:23:52 -0700 (PDT)
In-Reply-To: <4FD8D527.6050703@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199998>

Hi !

2012/6/13 Luke Diamand <luke@diamand.org>:
> So - what is a p4 stream? I found some blurb on the Perforce website but I
> was none the wiser after reading it.

To be honest, I don't have any idea (and my whole p4 experience is
less than one week long). As our local p4 guru explained to me, a
"stream" is some kind of writeable area in depot and every "client"
can have 0 or 1 "streams". If a client has a stream, then it's called
"streamable" and one can submit changes to this particular area (which
means more or less directory) by using this particular client. I don't
know if this story is sane, but at least this explains my problems
while I tried to submit changes.

Cheers,

Ilya
