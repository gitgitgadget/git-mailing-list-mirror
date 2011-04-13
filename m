From: =?ISO-8859-2?Q?Micha=B3_=A3owicki?= <mlowicki@gmail.com>
Subject: Re: gsoc - Better git log --follow support
Date: Wed, 13 Apr 2011 23:04:20 +0200
Message-ID: <BANLkTik7t=Tfh_Y_+swnaAWyetfy8MU6VA@mail.gmail.com>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 23:04:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA7Eg-000352-Nh
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 23:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852Ab1DMVEV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 17:04:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57429 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296Ab1DMVEV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 17:04:21 -0400
Received: by iwn34 with SMTP id 34so888582iwn.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1JoaTd0ICieYxlvofO1gpCc30O1vHuZVFCLuOS7kms4=;
        b=HSANB8KKgILx7V6ZM8E4+JIZOZYZK5pUGExWlyt5hsj50I99i/pf1Lgb8iEh0EIini
         6Y4JK+GZxuToYRvBRefPEVUuMO1hnJr8jpJ4toFlRKY1IMt5ZpjHk+wk2jcxtVeW48XV
         Ic1HFObe9c9gMePkn9wMSB9xBFqmZQgvBQDfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l7cBjbdWndQBetpAjviDO+Bf5MlfV4NW88tMXt98DujMprNQQ4Z3sR4I6asYz56+SN
         Wjs3xA+lYUtJDiX8v+PeqLTxMT4tw1LWL/KftxMsOsCW/EB7SAL2f9nRjcP+fo+mmbJp
         u0gkXgs5BrFSaJjmoqQxlD7ZZ0XujTMOXgVsQ=
Received: by 10.42.246.71 with SMTP id lx7mr4489436icb.351.1302728660445; Wed,
 13 Apr 2011 14:04:20 -0700 (PDT)
Received: by 10.42.222.195 with HTTP; Wed, 13 Apr 2011 14:04:20 -0700 (PDT)
In-Reply-To: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171488>

Hi!
This is the first plan for this gsoc project. Jonathan Nieder
described me how --follow works and pointed me to a lot of sources for
studying. He also suggested where I should start a how it should look
like (thanks for that).

25.04 - 15.06
1) study the revision walking code
    * understand its stages,
    * improve Documentation/technical/api-revision-walking.txt (it
doesn't explain revision walking code stages so I could save others
some time in the future)

2) study the pathspec matching + limiting and rename detaction API
    * possiblity to update/improve documenation here as well

3) figure out what state --follow will need to maintain, where it will
fit into the revision walking process and design new architecture for
it

16.06 - 26-08
4) implementation

I plan to spend about 2 months for the first 3 points. It's all about
poking the right developers and sending question to the mailing list.
I'll try to send some updates soon when I get through some basic
lecture and the most important code.

Any suggestions/ideas are as always welcome. Be prepare for many
questions from my side :)

Greetings,
Micha=B3 =A3owicki
