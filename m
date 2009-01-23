From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Fri, 23 Jan 2009 10:16:44 -0500
Message-ID: <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
	 <20090121170434.GA21727@hashpling.org>
	 <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
	 <20090122142258.GA2316@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 16:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQNno-0003Os-2a
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 16:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbZAWPQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 10:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbZAWPQr
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 10:16:47 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:64427 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbZAWPQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 10:16:46 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1283940fkf.5
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/AcK0pCcFxt0sUk1w/EFlMmCQ8dbsiv5Y0I/h3Mw+Is=;
        b=lo3m5u86fzPjdA4vB0oWIM6fcNNE3nkJme84rqK5cd7cbbXeOhWif0TrbARpjQ/rBG
         QY6ADA/VmRC4NJSidalBjqH6FzbncUX9Ir8KriLHxXFMg1xdP5G0yThokIAXlXI0HVEU
         xtqBpxll5RXJlZ7wf3ppxtnzypUNeq6jbcC00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M81OHJcCyYv1X0P0kiOVfR0Zy8ziGAD233wDsAbPwVN/tB+czrw0tMozNv5U9m1Sqz
         W7GWY3NH5VuBpLg+F7MqNh6+VJY3V2Jx+t8dcV9jcfWrKAMi09Dge1ME24tL4bh3cO3o
         HguoRyslZaWywQ20l2LxIJfjGOWrZIjKjPOJw=
Received: by 10.223.112.130 with SMTP id w2mr2661776fap.65.1232723804611; Fri, 
	23 Jan 2009 07:16:44 -0800 (PST)
In-Reply-To: <20090122142258.GA2316@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106883>

>  You'll never (well, almost never) know that tabs aren't 4 spaces.

no but I think people should be able to view indents at whatever they
want and still have it work, which is why I normally use tabs
exclusively, and set it to 4 space display, but if people wanted to
view at 2, 6, 8 spaces or whatever they could and the indents should
still look correct.

it doesn't really matter to each project there own.

so does my patch satisfy now? what's it take to get it included in the
next version of git?
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
