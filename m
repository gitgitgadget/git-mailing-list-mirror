From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Sat, 2 Aug 2008 08:06:45 +0200
Message-ID: <cb7bb73a0808012306y5672dad9nd0a21f861f181e5b@mail.gmail.com>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
	 <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
	 <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org>
	 <cb7bb73a0808012241s80a06fq1ac54a3350169f6c@mail.gmail.com>
	 <C871A30D-F2AF-4385-ABD4-C57F474D7F01@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 08:14:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPANi-0004v7-Rv
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 08:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYHBGGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 02:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYHBGGr
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 02:06:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:45795 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYHBGGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 02:06:46 -0400
Received: by yw-out-2324.google.com with SMTP id 9so803263ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 23:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2Qtu7Trry2RY3cCIpEATPy6n70mcd294KNUKhdMJzio=;
        b=VPcp93R4s1YyMMulOWjcZy2zaM3gHe4Mpo7lt5tjc5any/+t7KzNh+s1W/JHWUzZb7
         u061OLBFuxkEN7EQSQkJqzYoy+Gg4P8S4AdYpa2xXYGnwkXegQv98UqyhxZIAzsuWN39
         gKiE/I9vMz217bO5HUtnrP2d6yiksxZuN6YdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Fl8dktogzX9EDLnHPg+kfDL9FI23lVoSGaXgwYcZ4cT00dx1B5XBM3cDqmuU/R7nML
         2OnGyGDdKAz6xu0MSA8tbPkhq7ZoO4oczTB5tShQT/XusgpGSYmneb7Hr9ESUbxW1N/6
         oQjirsOf7hA20Oe0Ru9QAL/Hr89u5QKHONcy8=
Received: by 10.150.217.14 with SMTP id p14mr4509578ybg.83.1217657205452;
        Fri, 01 Aug 2008 23:06:45 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 1 Aug 2008 23:06:45 -0700 (PDT)
In-Reply-To: <C871A30D-F2AF-4385-ABD4-C57F474D7F01@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91134>

On Sat, Aug 2, 2008 at 7:47 AM, Kevin Ballard <kevin@sb.org> wrote:
>
> If you're going to get into anonymous code blocks, you're going to have a
> really tough time deciding which blocks are interesting and which aren't.
> And as you stated before, without a stack-based approach, this could really
> fall apart, as anonymous blocks are (almost) always going to be inside a
> method.

I was just looking for a libxdiff issue tracker but I couldn't find
one, so I guess I'll ask the author directly about the possibility to
implement such a thing. The matchit plugin for vim seems to manage
(even user-defined) code blocks very well, even for multi-state blocks
(if ... else ... end), using regexps; so maybe a reimplementation in C
for libxdiff could be a solution. Of course, one wonders how much
slower such an approach would be as opposed to the current "look back
until the first matching line" solution ...

-- 
Giuseppe "Oblomov" Bilotta
