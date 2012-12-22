From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Sat, 22 Dec 2012 15:10:02 +0100
Message-ID: <CALWbr2zZFq_9qa+pTx3nYn+KFv61LrSMcNM4N1Xs5cmnr8teXg@mail.gmail.com>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
	<50D4199C.6000002@alum.mit.edu>
	<20121221104437.GA5244@thyrsus.com>
	<20121222034751.GA11635@book-mint>
	<20121222140453.GB375@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Dec 22 15:18:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmPuT-0004Yi-Kc
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 15:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab2LVOSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 09:18:25 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:37123 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2LVOSX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 09:18:23 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so2276148eaa.19
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 06:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JYJgle///fSNfGE9owqZ0sn2yzKN/ctgZflglwyliWQ=;
        b=f5bcPQV2yLj7ZbeMJBcxbUFjG/ooGszjGuT0Bdk94XvBLyl2xQyJtoiGMRJ5UD76TQ
         4IYwfIYdriAKOaXQKNzFoLTeIiC6gEUKGHKVlS8FhS2is1dT2zCeXVRafAQnAjzCrWbd
         9BeXEqPxqMetlgQtJkF2FxUtB9vLx8BoTAVeYZUOAGk/19gT4eCgiVuxWlnAFNmtDIDb
         YTFArDHACCND0ibqaYSjjkxOISt3OtveclcmoO5CGQeLvc9hD6n4j+s8dWTaQF7QpSPD
         qiWvdxdpT4UuQ2OPLY9GAnwsXrOW9bzQRAq637f6h9YFu1IbkmHWU/Y0osLLIa9Mg5A+
         nKEg==
Received: by 10.14.1.195 with SMTP id 43mr40753506eed.31.1356185402665; Sat,
 22 Dec 2012 06:10:02 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Sat, 22 Dec 2012 06:10:02 -0800 (PST)
In-Reply-To: <20121222140453.GB375@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212051>

> esr@snark:~/WWW/cvsps/fixrepos$ git clone http://repo.or.cz/w/cvsps-hv.git
> Cloning into 'cvsps-hv'...
> fatal: http://repo.or.cz/w/cvsps-hv.git/info/refs not valid: is this a git repository?

I guess 'w' means write, and you don't have write access. You should use

    http://repo.or.cz/r/cvsps-hv.git

instead. It works for me.
