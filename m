From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: [GSoC 11] submodule improvements
Date: Sun, 8 May 2011 17:10:07 +0200
Message-ID: <20110508151007.GA5066@jpl.local>
References: <20110508120538.GA19074@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun May 08 17:10:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ5cf-0004M8-Ll
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 17:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554Ab1EHPKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 11:10:11 -0400
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:57100 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284Ab1EHPKK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 11:10:10 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id DFFFEEB337
	for <git@vger.kernel.org>; Sun,  8 May 2011 17:10:08 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlUTADixxk1T46eEPGdsb2JhbACXZo4xCwEBAQE3MohxvFCGDASeRA
X-IronPort-AV: E=Sophos;i="4.64,335,1301868000"; 
   d="scan'208";a="9498496"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb3.telenor.se with ESMTP; 08 May 2011 17:10:08 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 467EE422AF; Sun,  8 May 2011 17:10:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110508120538.GA19074@paksenarrion.iveqy.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173157>

On Sunday, May 08, 2011 at 14:05 CEST,
     Fredrik Gustafsson <iveqy@iveqy.com> wrote:

> I've been chosen to improve git submodules during the summer. My main
> focus will be to move the .git-directory away from the submodules so
> that submodules can be deleted and created in the working tree [1].

[...]

> [1] My proposal:
> http://www.google-melange.com/gsoc/proposal/review/google/gsoc2011/iv=
eqy/1

The proposal says

    The submodule system is widely used, specially within the android
    platform.

which puzzles me somewhat. The Android platform uses the Repo tool
to help out with multiple gits in the same source tree, and Repo
currently isn't based on submodules. Work is however ongoing to
switch Repo into using submodules instead (which would make the
whole tool rather redundant). Are you thinking of that work, or
is there a misunderstanding somewhere?

[...]

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
