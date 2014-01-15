From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Wed, 15 Jan 2014 01:02:46 +0100
Message-ID: <CALas-ihMfpQHr4nt9WO_att-2FDLvRYzxr-UVhfEsmRzLWafJg@mail.gmail.com>
References: <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de> <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de> <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de> <20140109221840.GW29954@odin.tremily.us>
 <20140114102445.GA27915@sandbox-ub> <20140114214608.GB838@sandbox-ub>
 <20140114222231.GA2647@odin.tremily.us> <20140114224246.GA13271@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 01:03:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Dwu-0007K8-A5
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 01:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbaAOADI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 19:03:08 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:43400 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaAOADH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 19:03:07 -0500
Received: by mail-ob0-f173.google.com with SMTP id vb8so399196obc.32
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 16:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6J/FpOSlT71chnk4iNKibQzkhNG6Viq4mbp0miW/Als=;
        b=zq2GleLtKcNsCjvPjRR4pvcH/0fVPGEbXqvpzHKRmKgBY45atxDD0Bkql0/L/qb+1o
         HW7vKmcK0pSIeR5TYD+fSP1H0hdMXW9TZtCylfgaSQV6onpY9w61G71U04UczZQ0IW81
         mea9Ig8jDkhnMGG1Q7FZTx+h+X8POUVxKdWxHIGCIeOZbyYda1+t3CNSGNsx9dMM2rVC
         k4tzw0Yo38et17uit9tdd6sYJ+k6WhwDIrreLkBwC5vOt0bz1CzOmKjuSBmVX/2rxxXG
         4zdN1A+NVmSx5UIPamRZKM3e1GQkhHtZOqrMU84FCeW974qL4+Xft1eGdwxjQUvaMrM2
         jA1w==
X-Received: by 10.182.113.69 with SMTP id iw5mr3672807obb.32.1389744186249;
 Tue, 14 Jan 2014 16:03:06 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 14 Jan 2014 16:02:46 -0800 (PST)
In-Reply-To: <20140114224246.GA13271@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240426>

2014/1/14 Heiko Voigt <hvoigt@hvoigt.net>:
> On Tue, Jan 14, 2014 at 02:22:31PM -0800, W. Trevor King wrote:
>> On Tue, Jan 14, 2014 at 10:46:08PM +0100, Heiko Voigt wrote:
>> > I would like to step back a bit and get back to the original problem
>> > at hand: Francescos original use case of an attached head for direct
>> > commits on a stable branch in a submodule. How about we finish
>> > discussing the exact solution of that first. AFAIK that is already
>> > solved with the following:
>> >
>> >  * Trevor's first patch[2] to create a branch on initial clone of a submodule
> [...]
>
>> > That should be all (and IIRC Francesco agreed) needed for that use-case.
>>
>> That was my understanding [3] ;).
>
>

I've been silent these days but yes: I confirm Trevor's second patch
iteration[1] gives, IMO, a better meaning of the
submodule.<name>.branch property and is perfectly fine for my use
case, to the point of stopping pursuing for my non behavior changing
patch[4] (I still think it deserved some more in depth reviews, though
;) ).

Cheers,
Francesco

[1]: http://article.gmane.org/gmane.comp.version-control.git/239967
[2]: http://article.gmane.org/gmane.comp.version-control.git/239973
[3]: http://article.gmane.org/gmane.comp.version-control.git/240139
[4]: http://article.gmane.org/gmane.comp.version-control.git/239956
