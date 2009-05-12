From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@swipnet.se>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 20:13:03 +0200
Message-ID: <20090512181303.GA26082@jeeves.jpl.local>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com> <e2b179460905120940u2d87a591kefbdf659e1badd0c@mail.gmail.com> <7444645C-67E8-424E-9073-E831C8DE8656@npcinternational.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Jon Brisbin <jon.brisbin@npcinternational.com>
X-From: git-owner@vger.kernel.org Tue May 12 20:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3wTg-0003AP-Ki
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 20:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbZELSNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 14:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbZELSNJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 14:13:09 -0400
Received: from proxy3.bredband.net ([195.54.101.73]:55311 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbZELSNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 14:13:09 -0400
Received: from ironport2.bredband.com (195.54.101.122) by proxy3.bredband.net (7.3.140.3)
        id 49F597CD00588DB9 for git@vger.kernel.org; Tue, 12 May 2009 20:13:08 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkAFAAxZCUpT4/BMPGdsb2JhbACBUJU6AQEBAbZshAIF
X-IronPort-AV: E=Sophos;i="4.41,183,1241388000"; 
   d="scan'208";a="480469368"
Received: from ua-83-227-240-76.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.240.76])
  by ironport2.bredband.com with ESMTP; 12 May 2009 20:13:06 +0200
Received: from jeeves.jpl.local (jeeves.jpl.local [192.168.7.3])
	by elwood.jpl.local (Postfix) with ESMTP id D1FCA422AE;
	Tue, 12 May 2009 20:13:05 +0200 (CEST)
Received: by jeeves.jpl.local (Postfix, from userid 100)
	id C6C273C2D; Tue, 12 May 2009 20:13:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7444645C-67E8-424E-9073-E831C8DE8656@npcinternational.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118938>

On Tuesday, May 12, 2009 at 19:56 CEST,
     Jon Brisbin <jon.brisbin@npcinternational.com> wrote:

> On May 12, 2009, at 11:40 AM, Mike Ralphson wrote:

[...]

> > I'm not sure what Rational Developer is likely to want to do in
> > terms of getting the edited files back to the AS400 (assuming it
> > supports that directly). Are you planning to run (j)git on the AS40=
0
> > or have another step to get the code from a central git repo back t=
o
> > the AS400(s)?
>
> Since I work with, but am not a part of, the AS400 group, I don't hav=
e
> a copy of Rational to play with. I have used Websphere Studio before,
> though (which I think is the precursor to Rational/eclipse) and it
> used the toolbox utilities (JT400 et al) to transfer files locally,
> allow the developer to work on the file, then put them back on the
> server where they can be compiled. I would assume Rational works
> similarly. This is making me wonder whether any open source scm will
> work for this scenario. We may be tied to IBM's tools or nothing.

I hope I'm not stating the obvious here, but "Rational" is a division
within IBM, not a product. IBM Rational has two solutions for version
control, ClearCase and Team Concert. The latter does a lot more than
just version control though, and it seems to be shipped with Rational
Developer. Just to be clear, which product(s) are they considering?

[...]

--=20
Magnus B=E4ck
baeck@swipnet.se
