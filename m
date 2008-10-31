From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 16:56:51 -0700 (PDT)
Message-ID: <m3tzasfhgb.fsf@localhost.localdomain>
References: <20081031170704.GU14786@spearce.org>
	<20081031174745.GA4058@artemis.corp>
	<alpine.LFD.2.00.0810311558540.13034@xanadu.home>
	<7viqr873x7.fsf@gitster.siamese.dyndns.org>
	<20081031234115.GD14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:58:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3sk-0007w6-5i
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYJaX4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbYJaX4z
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:56:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:55609 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbYJaX4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:56:54 -0400
Received: by nf-out-0910.google.com with SMTP id d3so672736nfc.21
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 16:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=m0+C8CBAQcmlVhRdqdU1w2UU9Kg5ZuBKCjNdhxSHIrU=;
        b=sCXsXksVzRO+6rRuRq33jWFVyzX0CJGv8MpkcVLOAW9/EgdL19pqMNcaCMbrG6zLp1
         Y0LVDrDCCJkFruJjMY4qAOkB+otJqGnBUSKfblFh2p2UPNWi2RE4e5jQcydHo5ibWneV
         NExBIUskN3rF2EiTuUZFNRaCh8W3Y7Lmngbms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=TqHVKMWVF1uLrzoxVPYcbeVf37ZpD4H2zB+BWM4DX6H0m+i/QFmAL5ryANSgW1t0rV
         ScboKVedg1CqsyS5MvJc1geV+XkTNC3OiLQQmaMNlkYr0+62uXeYF6v6fWV5O973A9aI
         uyIL5PP4Rsl6I/08He5IuuJyEgQDG1pJE3cOA=
Received: by 10.210.59.14 with SMTP id h14mr5148669eba.50.1225497412118;
        Fri, 31 Oct 2008 16:56:52 -0700 (PDT)
Received: from localhost.localdomain (abwk207.neoplus.adsl.tpnet.pl [83.8.234.207])
        by mx.google.com with ESMTPS id 10sm4863200eyd.6.2008.10.31.16.56.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 16:56:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9VNtpHl000458;
	Sat, 1 Nov 2008 00:56:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9VNtGnC000453;
	Sat, 1 Nov 2008 00:55:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081031234115.GD14786@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99684>

"Shawn O. Pearce" <spearce@spearce.org> writes:
> Junio C Hamano <gitster@pobox.com> wrote:

> > Although no license asks this, my wish is that if somebody built on top of
> > what I wrote to make the world a better place, I'd like the same access to
> > that additional code so that I too can enjoy the improved world.  Because
> > almost all of my code in git.git are under GPLv2, in reality I do not have
> > any access to your software as long as you do not distribute your
> > additional code that made the world a better place, which is a bit sad.
> 
> IMHO, its a flaw of the GPL.  GitHub anyone?  Heck, even Google uses
> a lot of GPL'd software internally (yes, we have Linux desktops and
> servers) but not all of the software we distribute internally goes
> external, so not all of our patches are published.  *sigh*
> 
> I've actually stayed awake at night sometimes wondering what the
> world would be like if the GPL virual clause forced the source code
> for a website to be opened, or forced you to publish your code
> even if you never distribute binaries beyond "you" (where "you"
> is some mega corp in many countries with many employees).

There is such license, and it is called AGPLv3, Affero GPL[1].

And of course Google prohibits (or did prohibit) using it for projects
hosted at Google Code... wonder why... ;-)

[1] http://en.wikipedia.org/wiki/AGPL
-- 
Jakub Narebski
Poland
ShadeHawk on #git
