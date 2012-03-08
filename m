From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 03:33:43 -0800 (PST)
Message-ID: <m3sjhjs4z5.fsf@localhost.localdomain>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:34:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bbc-0003qg-7A
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab2CHLdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 06:33:47 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43713 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684Ab2CHLdp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 06:33:45 -0500
Received: by eaaq12 with SMTP id q12so112411eaa.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=KIHH8fUndNo+lpUYIJWEp4f0eMmGG1JNmmFSBfuUpEQ=;
        b=VFp+hAO08+nNKb+V4xE2DLFzg8in8BYz0tehbhvmns2MMvnTVjwfxH1xYh7UjWVTjL
         /G6YPPkQBfe9f++u8ZXMQZxGa2Ez/D9HXqkC9Zao3GTHZTp37ftem0HY1fN8EDtxkZjl
         C37gHdcHdBAwJU+ZBkxsEjCECFpgou/6rRAyJxCNbIUmjvSnE7I1O3c+gNtSVhcWwul9
         +HRhYsyGrnA8L7sj6xsKUzS4RIS/OR6rolehyZTugGiDPPtYhCtgpaE7xgjaQaYoK1WT
         gWBUFxlMcHedwAe+B3O9KyPIDrL/63tLFiJafFownezoX6AW0Qk9QsiHlkCNR51Lrxu0
         murQ==
Received: by 10.14.127.129 with SMTP id d1mr2174315eei.59.1331206423950;
        Thu, 08 Mar 2012 03:33:43 -0800 (PST)
Received: from localhost.localdomain (abwr173.neoplus.adsl.tpnet.pl. [83.8.241.173])
        by mx.google.com with ESMTPS id y11sm5305651eem.3.2012.03.08.03.33.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 03:33:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q28BWxm0009483;
	Thu, 8 Mar 2012 12:33:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q28BWWlE009478;
	Thu, 8 Mar 2012 12:32:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192564>

Jeremy Morton <jeremy@configit.com> writes:
> On Thu, Mar 8, 2012 at 10:28 AM, Carlos Mart=EDn Nieto <cmn@elego.de>=
 wrote:
> > On Thu, 2012-03-08 at 10:13 +0000, Jeremy Morton wrote:

> >> Right, so I guess I'm saying that the default value for push.defau=
lt
> >> should be upstream instead of matching...
> >
> > Any default is going to leave some people unhappy. If upstream is t=
he
> > right thing for you, then that's what you should use. Most question=
s I
> > see about push not doing what the users expect would actually benef=
it
> > from 'current'. 'matching' is a fairly safe default, as it won't tr=
y to
> > push private branches or changes in private branches that track
> > something upstream.
>
> But 'push --force' WILL try to push your (probably outdated) master
> upstream, killing any changes there made since you last updated.  Tha=
t
> alone is so dangerous it seems like reason enough to avoid it by
> default.

You can always configure server to refuse forced pushes.
--=20
Jakub Narebski
