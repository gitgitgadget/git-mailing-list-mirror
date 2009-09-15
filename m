From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 15:54:58 +0200
Message-ID: <46a038f90909150654t73cab47ckfd02f8a2f4353722@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
	 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
	 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
	 <20090915130640.GC31846@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 15 15:55:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYUx-0002AA-Sy
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbZIONzC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 09:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753995AbZIONzB
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:55:01 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:41588 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbZIONzA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 09:55:00 -0400
Received: by ewy2 with SMTP id 2so483808ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/pBOpq1QZBNiqQspi6Zph6Jqz5Q0klOQmbjuzVMFc38=;
        b=Q3iO+n7giJUCRdQhqVqz7tumb2hpan6tG9v2sL8+9n2YkcpXM9P4wEfeqUnUGHFP5x
         DtkByxEn85Pm7Gf7KYuAHUPps07uDtL6WxyZb9nXaqvKppj5mrydCyZjW8s4Nq6w8nnf
         MqRztBy4dUIJrN+4FlkB1S0gPK7ylA/VbYRiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b4N89N/QGCqggo+Z3iKbRq4C9ueTSyQ5s7Io11Nxp8WKMyF1nrHGq1HeTjBnEzCD4J
         CxPu01ix5WThWGkWKWZGoob5yfxSmhkvy+liDCwfJ9YvHxkh7VL5mWwN09nX19MGSu6p
         BoHImo/QsA7ExHPw02CWMWS3GHj/V1LUAHM5U=
Received: by 10.211.171.12 with SMTP id y12mr890248ebo.51.1253022898824; Tue, 
	15 Sep 2009 06:54:58 -0700 (PDT)
In-Reply-To: <20090915130640.GC31846@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128562>

2009/9/15 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> [Please stop top-posting...]

Not everyone is deep in mailing-list lore :-) -- we can help anyway.

Howard, I see you're wondering about it: http://www.idallen.com/toppost=
ing.html

> Just don't use patch(1), there's no sane reason to do that, you're
> sacrificing all of what git can offer there.

Oh, yes there is, specially for newcomers used to patch, and how it
handles conflicts.

In this case, I happen to know that Howard is a refugee from CVS land
(the moodle project in this case), and he is familiar with the output
of patch if things go wrong.

It's not what I'd recommend to someone that is deep in git-land. But
even myself (with a bit of code in git) sometimes use patch when
git-apply tries to be too clever and I just want a damn .rej file to
review and edit with emacs.

cheers,


m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
