From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Fri, 9 May 2014 15:37:17 +0200
Message-ID: <CALbm-EbcoZmWtuxMLSZWjPcgKVTXZPcQ_ppj2UGKzF9oh+hQvA@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
	<20140509015107.GA9787@sigill.intra.peff.net>
	<536c35a3507a8_741a161d310cf@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 15:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WikzR-0002UD-5I
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 15:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbaEINhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 09:37:22 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38145 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913AbaEINhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 09:37:19 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm4so1339460wib.4
        for <git@vger.kernel.org>; Fri, 09 May 2014 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CuYccBqrfEWB/VLGKNbBCTue611pgBaZT7llj93CpWk=;
        b=MfpOEZn23JpsR4Yy2KfxfwPYSYmgbpR3gUUGPYAZlLL7HY2q1r6X118a9MW2KUtJ8v
         du7QAYjt8bBu+z9smC58pMC5YGmlEK+Rz0Tdu18475Yvi/HjJydhVazR2FSsT22wwVBv
         xeZBf3SxnZ1AZdl/N/zVlAl0QhfSTO6Cnfgcc6XTqzExnH+VTaY1/WTqpVGw/LSXKU2C
         aQh1ecT/QUvBW9KtcajlVqYIQ05MrX9AM15KOU9mhd2hy2L/7JFEE20RmlqHhmuLpbfl
         hWzSD1aM2FyJXVJp8n5xi8LOK0ZlDGTA6CkRbdE4/Ioia9INXbkkT4wAHJ5B9uwTDi9Q
         jqRg==
X-Received: by 10.180.207.47 with SMTP id lt15mr3436694wic.46.1399642638088;
 Fri, 09 May 2014 06:37:18 -0700 (PDT)
Received: by 10.180.94.166 with HTTP; Fri, 9 May 2014 06:37:17 -0700 (PDT)
In-Reply-To: <536c35a3507a8_741a161d310cf@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248557>

>
> It is serious.
>
> The purpose of the 'contrib/' area is not clear. The statemens coming
> from Junio don't match what is on 'contrib/README'. So we have a huge
> variance of quality all over 'contrib/'. Some tools in contrib have
> higher quality than what is part of the core (e.g. they have tests,
> while git-archimport doesn't).

How about rewriting the README then?
Also as I said in another mail, we could split up the contrib/ area
into multiple areas with narrow defined use-cases, i.e. staging/,
Documentation/historicTools (the current contrib/examples section),
3rdPartyTools/, Bridges/ (for cooperating with other VCS).


>
> So this is a serious attempt at making sure we remain consistent through
> the core and contrib/.
>
> Personally I would like to see everything in contrib/ have *at least*
> some tests and documentation. Otherwise we know what's going to happen;
> they are going to rot and nobody will care that the tools don't work any
> more, or they won't even know what they do and how to use them.
>
