From: "Raimund Berger" <raimund.berger@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Sat, 31 Jan 2009 14:26:40 +0100
Message-ID: <87myd7bo8f.fsf@gigli.quasi.internal>
References: <871vulda2r.fsf@gigli.quasi.internal>
	<slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
	<87vdrwbofv.fsf@gigli.quasi.internal>
	<slrngo771p.b1i.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 14:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTFtL-0001Sa-6g
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 14:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbZAaN0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 08:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZAaN0q
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 08:26:46 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:52877 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbZAaN0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 08:26:45 -0500
Received: by fxm13 with SMTP id 13so673198fxm.13
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 05:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:references
         :mail-followup-to:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=jAtsN15e7jgBgbMIO/g+M9DOVTaqqw9IkVjU348TumE=;
        b=szB1Ps/PqoPXMO7iCGk11fJgTv69sTj8XR/Y1nKsBlRopXSYFAsNOkA/2J1wSYFdFO
         3g/tbQDSHYWkSHmlqwod5ULq2Ri1Ku8l6sNwhLt0uM9yfigPi2zppIGaDiwAkmdi+plW
         qhas7cD12MnX3Ow7r5IJnmCUNgqTVeaShFZVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=IL+txGos6VlOmqUYnQBhlW3gA5fCHHTDX6ulGSnyHRgrcWcMv+jwqrd4p7Y+VciKJZ
         0tZRCwpbbgLPd95jfxxD+8HOXY6aIBUXAAr4Szv+UpTh92QMg38wdilv6otqAD74HA2d
         lyDSj1BbNsoYRit9XYHqCeKaSuvjEyo0VB+pg=
Received: by 10.103.227.13 with SMTP id e13mr1041128mur.20.1233408403379;
        Sat, 31 Jan 2009 05:26:43 -0800 (PST)
Received: from gigli.quasi.internal (p5DC329D3.dip.t-dialin.net [93.195.41.211])
        by mx.google.com with ESMTPS id j6sm2554201mue.24.2009.01.31.05.26.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 05:26:42 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <slrngo771p.b1i.sitaramc@sitaramc.homelinux.net> (Sitaram
	Chamarty's message of "Sat, 31 Jan 2009 00:32:57 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107922>

Sitaram Chamarty <sitaramc@gmail.com> writes:

[snip] ...

> Rebase *does* do an implicit merge by default (as far as the
> tree that results is concerned, which you mentioned right at
> the start), I'm pretty sure of it.

I'm myself, especially since a conflicting rebase leaves the index in an
"unmerged" state. Much like a regular merge does. It's still all
assumptions though, or maybe I'm missing documentation .... (?)

> Perhaps someone with more git smarts will chip in with
> something more concrete.

That'd really be awesome. I mean, it's ok for me to dig through source
code and find answers myself, but it would really save time if somebody
who knows for sure dropped a word or two.
