From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Verbose as default for commit (optional)
Date: Fri, 24 Apr 2015 21:08:56 -0400
Message-ID: <CAPig+cRegJ9b0NyvkrZvJMw3CAU0TdgyzH1DMDjB_hV2X4ysHg@mail.gmail.com>
References: <20150424191809.GA18897@alvaca.santafe.altoros.com.ar>
	<vpqbnidmgzh.fsf@anie.imag.fr>
	<20150424235103.GA1798@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eloy Espinaco <eloyesp@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 03:09:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yloac-0002U3-UK
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 03:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031669AbbDYBI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 21:08:58 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33514 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030990AbbDYBI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 21:08:57 -0400
Received: by igbpi8 with SMTP id pi8so38146013igb.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i/Gz8PUGJnEU/TBY1XqWpycU4o2Lre7dfyAYpoxnKFQ=;
        b=F57Qect4kC8ADELkJ2Kx7hbSb9xhxdWAGs5gA71DorV7dkjA4eZyz73pqnGVDgUSaI
         4A6flaeDzAUeouUudILRBxa9YgeWfbfaDbLq27RHVEnh5jp4V/KF9U0Bq7HEjgTmmDaH
         rITtt4aH+Q0l3e2706ipdjAmTO4IOaC9F+ODLGVyaTKGCpab3G/Xwxed9gOc1K/oLZ6/
         +t3FEf1PC4I9HuPKEohOeVhrG9+QcZy5iO021+8Qc0dzi9W1MUdZFTGpiTjjYceJMFUx
         cfJe+VklVj0XazfJLT3atk7NbIR1r1uj4sMtgURD6u0OQrQjhvlzWzuuzjFZSZCjffge
         Dxig==
X-Received: by 10.107.31.134 with SMTP id f128mr1364872iof.19.1429924136729;
 Fri, 24 Apr 2015 18:08:56 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 24 Apr 2015 18:08:56 -0700 (PDT)
In-Reply-To: <20150424235103.GA1798@localhost>
X-Google-Sender-Auth: 2AhvOaFW9RqcPGb9mM5M1j-teNs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267767>

On Fri, Apr 24, 2015 at 7:51 PM, Eloy Espinaco <eloyesp@gmail.com> wrote:
> Ok, now I found [this
> thread](http://thread.gmane.org/gmane.comp.version-control.git/251376)
> that seems abandoned, but implements this config, a --no-verbose that
> disable it for one-time and the tests, but was not merged (don't know
> why)

I recall reviewing Caleb's patch series and making a number of
suggestions for improvement. v6 was the last version he posted[1], and
it seems that he intended to post v7 but never got around to it.
Apparently, Torstein Hegge asked in February 2015 about picking up
where Caleb left off, but nothing has materialized.

You are welcome to revive the series by taking reviewer comments into
account and submitting v7 (and beyond if necessary). Be sure to keep
Caleb's authorship and sign-off intact, and add your own sign-off
following his. If you make changes to his patches, briefly describe
your changes in a bracketed comment in the commit message, starting
with your initials, like this: [ee: changed blah to bleh].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/251943/focus=264608
