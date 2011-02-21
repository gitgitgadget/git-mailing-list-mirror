From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/15] Makefile: "pot" target to extract messages marked
 for translation
Date: Mon, 21 Feb 2011 07:05:25 -0600
Message-ID: <20110221130525.GB18427@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
 <20110221101530.GE32137@elie>
 <AANLkTi=ewuq=QS=MTyOF95FUBJNoQ=f2CY53GEZOVOAL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 14:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrVSU-0007nB-Hu
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 14:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab1BUNFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 08:05:42 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36790 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab1BUNFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 08:05:41 -0500
Received: by iwn8 with SMTP id 8so1864966iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 05:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rkP8ZTSHPeqwp6HXDwTJttqalJfA9KKGGoiiIu2EfWQ=;
        b=MuDVaRq1rlPrxrDh4Hfd3Y8PNpLixOCSr4oX5rqlSI/XQ+/aWaZ6fi7hg78d00c+xJ
         7Cy2w22geafbdYwWrVzc6F+LtwvLOQZHcX9V8Y+1uFv4kStQiHfybr5L8eeqriRS1vJm
         tPekhLO58nvqOqfb9aOkJ2H6jTVgQl0YVMZHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=A8rpLNGw7pkaZKX/yoSBG8Uo1TKkOrFYI6B2eT2ldsZWB0axS/23lmVePOkMXT6jsD
         pd8oRhMJ5I1LR9ymX4R6n/ZisQHmIjhLZLWLmBVLrb6kcoQFImxrQ7yH87Ir3KIuu4eo
         nMfXTXVRWtlbqyYiOpu++ts/Vxb7iQ+8JXE/A=
Received: by 10.42.230.137 with SMTP id jm9mr1923873icb.256.1298293530258;
        Mon, 21 Feb 2011 05:05:30 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id u9sm5187557ibe.8.2011.02.21.05.05.28
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 05:05:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ewuq=QS=MTyOF95FUBJNoQ=f2CY53GEZOVOAL@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167481>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Feb 21, 2011 at 11:15, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Add rules to generate a template (po/git.pot) listing messages marke=
d
>> for translation in the C portion of git.
>
> Can we please not apply this?

I included it in the series because I used it to test, for what it's
worth.

I also think it could be useful to translators, so they could work
against git.git directly once it has enough translatable strings.
That sounds valuable to me.

But I have no strong preference about what actually gets applied to
git.git in this case.
