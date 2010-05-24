From: Debayan Banerjee <debayanin@gmail.com>
Subject: Re: Possible bug with argument parsing in git blame
Date: Mon, 24 May 2010 11:47:02 +0530
Message-ID: <AANLkTikEiRuitD7lrZQIaOruCBrL1Vu5K74Y4wGoiC1z@mail.gmail.com>
References: <AANLkTikn1-Ua6G7eAc8UD8DJx0vpc-5-BOoxsi2mx2BC@mail.gmail.com> 
	<20100523080002.GB24598@coredump.intra.peff.net> <AANLkTinMlvmOneGgkIqxE8qWlhoOlqgALl-YHprqPI6h@mail.gmail.com> 
	<20100523200853.GA23377@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 24 08:17:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGQye-0000zj-Om
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 08:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab0EXGRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 02:17:23 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50302 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab0EXGRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 02:17:22 -0400
Received: by pxi18 with SMTP id 18so1297099pxi.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=QaxSV0L3ER9nN5Fo6jwIyINbefuYNCxEI5aTRo4Q5r4=;
        b=dqcFsjUAtUMBhBVv7DL/ZNx6JHD1FSVB6xRD6AGmvxc7oFN+uV80pB/nBTszGA+QRf
         64V3BSOgNWvJ5Z0Ca6d9NDRQnUznGHozIj11fC75CMx1xhLMH5xNJSCe6md2WgRlww+l
         Yj5o/+ZDjVg/KB3dGcBX7kR1lks13JBlAK00Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=P8bVPSwb/bkVR2sIpduhrMX5j32nIU/OEcH+cCWwiF9GFAIHeU+wUJknS/Yf4pSmza
         Mrz/UfYeu+HHwh9eODJ1IPK1cgeJbYBeOeWOCgB0Gc4WGDiPr3DoOTFDqHAQcop44d4/
         d4DdxU2HzHeqODYGfvjT3bON5I9tXPDGI1wCI=
Received: by 10.142.65.24 with SMTP id n24mr3187927wfa.302.1274681842420; Sun, 
	23 May 2010 23:17:22 -0700 (PDT)
Received: by 10.141.34.18 with HTTP; Sun, 23 May 2010 23:17:02 -0700 (PDT)
In-Reply-To: <20100523200853.GA23377@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147601>

On 24 May 2010 01:38, Jeff King <peff@peff.net> wrote:
> On Sun, May 23, 2010 at 07:22:41PM +0530, Debayan Banerjee wrote:
>
>> > I can't reproduce the problem here. For example, in git.git, both of the
>> > following produce the same output:
>> >

I used master too. The test cases you provided work fine for me too.
It also seems that '/' is not a problem. I tested myself with some
combinations and i could not reproduced the bug. But the strange
behaviour i reported with my particular case still exists.
My repo structure can be cloned from http://github.com/debayan/git-blame-test .
-- 
Debayan Banerjee
Software Engineer
