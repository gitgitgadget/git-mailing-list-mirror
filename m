From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How can I force git to recognize a change change in file modes?
Date: Sat, 28 Feb 2009 09:34:15 -0800
Message-ID: <e38bce640902280934u3d9da650ke64865d7149b3c66@mail.gmail.com>
References: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
	 <20090228045531.14399ebf@perceptron>
	 <e38bce640902280824x3ae41d95qab1f1a450235e096@mail.gmail.com>
	 <76718490902280852y2f2657ck7459c138205bb874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 18:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdT6L-00063I-G2
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 18:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbZB1ReS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 12:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbZB1ReS
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 12:34:18 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:55110 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbZB1ReS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 12:34:18 -0500
Received: by el-out-1112.google.com with SMTP id b25so1387462elf.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 09:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RxV2sszKapYkrXTiRtMJ0S0x3KKI3+JKQPy5hSjoXBE=;
        b=DgDvhTE67fquHhuL4QrWRVM7/GRf87M3OPVuFIPhlBJiE2x/5hK9cipq3lwJYknsLy
         fWW05m4DxcIQcRsrGYaOn6s/gO4OHtFlZ6dqQHYjYujpETb0FPlfF8Ebv9xCC1SI8YFR
         tDnXhJygSA61UN8+A/4osjNC8Nh/h6P2xafZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v9EbavtlpFO7KPpcH6ti98u3uJV/7nIoUJSqyodY6sHhyCrQjD6FjMErSLzp+T6qqH
         NC9UKbEsNLjHZsroxzzSjoX0KIfkW5c7/spX6BfZVhz1fVp2rQF6oueCZFmgSxyTs1JZ
         gbU0USKO79GyBLv7hjAA+p0kbmaLFZ/dZUy78=
Received: by 10.90.92.14 with SMTP id p14mr150309agb.104.1235842455655; Sat, 
	28 Feb 2009 09:34:15 -0800 (PST)
In-Reply-To: <76718490902280852y2f2657ck7459c138205bb874@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111779>

> The short answer is: because Git was designed to track content. The
> long answer is more complicated. Here's one of the more useful past
> discussions:
>
> http://thread.gmane.org/gmane.comp.version-control.git/91783
>
> I'm sure you can find others by searching the git list for "metadata".

I read that thread you showed above. Sounds like a big squirmy
can-o-worms, and I see that thread died on the vine because of it. :)

All I want to do in my case is just chmod 700 a bunch of scripts after
they are checked out or updated.  I'll need to re-read the git-hooks
man page more closely.

Thanks for your help!
bg
