From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC update] Sequencer: Iterating over a stable series
Date: Tue, 7 Jun 2011 13:32:30 +0200
Message-ID: <BANLkTi=JMTq5YBi=D30dr_XFp_zrj6LQ0w@mail.gmail.com>
References: <BANLkTik93BB7p0gNMx5ZfsSCjietXxiG3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:32:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTuWU-0004tk-9m
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 13:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab1FGLcd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 07:32:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58860 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab1FGLcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 07:32:32 -0400
Received: by gxk21 with SMTP id 21so1870157gxk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vbZRUmmhfXFe5ObFd9LD+fH5wAv5uCMImjXjk59RJF4=;
        b=xP8nosIY/bXJrCi/o+XxoBS6Kr1CoJ/nnSPw/XVGE6MEnshKSwWudC/HYBSIjVtnDS
         L8YNfUjQw5f/wrXSqnEZEnoxCMJkR+yfMJwugXtV2cTJSOpUWdb6AQWOZwYvrBkrz2So
         8/gpeZ//drUu+2VfoamombVUJD0Fy5l0SbhQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NVxCI3IqaH7W5ESgmlMKb/7DDwYpL1YJ9gahmrs36XCMDmFQdV3R38aev+/3bqesDY
         7waZ8Rvsv3U76M9WUUj4goY7vJXBFI4AbEn8DqsSqhRllnfnwIsz3DfQGFB2lggq+/zZ
         DYUVEMBPPOa/wzNnIj2O6N+crHnIEjUewtedc=
Received: by 10.236.80.10 with SMTP id j10mr279750yhe.262.1307446350899; Tue,
 07 Jun 2011 04:32:30 -0700 (PDT)
Received: by 10.147.83.2 with HTTP; Tue, 7 Jun 2011 04:32:30 -0700 (PDT)
In-Reply-To: <BANLkTik93BB7p0gNMx5ZfsSCjietXxiG3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175197>

Hi Ram,

On Tue, Jun 7, 2011 at 7:48 AM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> Hi,
>
> I will start posting weekly updates starting with this one, since I
> now have quite a lot to say :) =A0Over the first few weeks, my object=
ive
> was to keep iterating the initial series I'd posted until I ended up
> with a more-or-less acceptable version. =A0This [1] doesn't seem far
> away. =A0Now, I'm busy writing some tests, and planning out the
> functionality of each of the individual features -- as soon as I
> understand the problem correctly (see discussions in [2] and [3]), I
> will start working on writing new features. =A0I'm quite hopeful abou=
t
> meeting my mid-term target. =A0Please feel free to email me any
> comments/ queries about this project. =A0Alternatively, catch me on
> #git-devel on Freenode IRC; I'm almost always available, except when
> I'm sleeping.
>
> Jeff: I was out of town these last few days. I saw your email about
> the lockfile API confusion- will investigate and comment soon.
>
> As usual, the latest code can be found on the sequencer branch of my
> GitHub fork [4].
>
> Thanks for reading!
>
> -- Ram
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/174526
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/174393/fo=
cus=3D174945
> [3]: http://thread.gmane.org/gmane.comp.version-control.git/174874
> [4]: http://github.com/artagnon/git
>

Thanks for this status update, this is very much appreciated,
Christian.
