From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Show diffs for changed files under a new or deleted directory.
Date: Mon, 18 Feb 2008 07:44:57 +0100
Message-ID: <200802180744.57757.robin.rosenberg@dewire.com>
References: <1203263746-2924-1-git-send-email-rogersoares@intelinet.com.br> <200802171605.48250.robin.rosenberg@dewire.com> <47B9110E.90707@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Mon Feb 18 07:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQzky-0006Vd-LE
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 07:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbYBRGpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 01:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbYBRGpE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 01:45:04 -0500
Received: from [83.140.172.130] ([83.140.172.130]:21725 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbYBRGpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 01:45:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 603E78006AD;
	Mon, 18 Feb 2008 07:45:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dcYZFLdQ5dQC; Mon, 18 Feb 2008 07:45:00 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id E4DE980019B;
	Mon, 18 Feb 2008 07:44:59 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <47B9110E.90707@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74234>

m=C3=A5ndagen den 18 februari 2008 skrev du:
> The Differencer I changed was actually a bug. If you say that the fil=
es=20
> left in the left pane are Differencer.ADDITION, then the ones left on=
=20
> the right pane _must_ be Differencer.DELETION. It just doesn't make=20
> sense to say that files not on the old tree but on the new tree are=20
> addition, and at the same time that files on the old tree but not on =
the=20
> new tree are also addition.
Ok, I see. I'll test it a little and push soon.
> > I'd love to see a unit test for your code since, even if it works, =
it is very easy
> > to break again.
> >  =20
> Ok, I'll get a look on the test cases and probably write something wh=
en=20
> I get back into these compare issues. That if somebody else doesn't d=
o=20
> it before me, of course :)

Not very likely within a short time frame, though I want do the excersi=
ze. Unfortunately I have too many open branches right now to add yet an=
other. The original author (cough, cough) didn't do it. I was so happy =
and pleased, at them time, to see it work at all so easiliy :) . I've w=
ritten some tests for other functions, so I guess it's mostly about set=
ting up some more infrastructure to make testing reasonably simple.

-- robin
