From: David Barr <davidbarr@google.com>
Subject: Re: How to migrate a complex directory structure from SVN to GIT?
Date: Fri, 27 Jan 2012 15:46:19 +1100
Message-ID: <CAFfmPPNQRtxXSiLRMSwf85t1spdX12zVEQQea0yORK5hN8b0oA@mail.gmail.com>
References: <1326828837924-7197567.post@n2.nabble.com>
	<4F1713D4.9000602@orb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 05:46:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqdhn-00075R-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 05:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab2A0EqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jan 2012 23:46:22 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41809 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2A0EqU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2012 23:46:20 -0500
Received: by ghrr11 with SMTP id r11so629880ghr.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 20:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type:content-transfer-encoding;
        bh=dwsR/bcDUma3r3La2Wj1vhG1L9yMlJWGEn3bp332l1A=;
        b=OTaS5H6xmDQgUMfSWE6SpbHZTrF+rLnY3Ccp7gsx7kic6J98qlJkTdNVGK2sbZdKCV
         YvsDqcG8bjGguQqBT/4M6+0CoDlysxRiuenpUF7xtvJ1JCIz9ZrDMpEhTcvToeBC3fyy
         E4rsGtXvi7WigWwCmVV+3oXESYm1y4gqm/L/g=
Received: by 10.236.124.206 with SMTP id x54mr7496907yhh.112.1327639579758;
        Thu, 26 Jan 2012 20:46:19 -0800 (PST)
Received: by 10.236.124.206 with SMTP id x54mr7496890yhh.112.1327639579614;
 Thu, 26 Jan 2012 20:46:19 -0800 (PST)
Received: by 10.101.144.22 with HTTP; Thu, 26 Jan 2012 20:46:19 -0800 (PST)
In-Reply-To: <4F1713D4.9000602@orb.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189188>

> If however you have a more complex layout, you can use "git svn init"=
, then
> edit .git/config to suit your needs, then run "git svn fetch".
> And by "suit your needs", I mean you can add multiple "fetch=3D..." l=
ines.
> In my case, I ended up having one "fetch=3D..." for each trunk, branc=
h and
> tag.
> It was not efficient, it took 2 weeks to convert <30k revisions, ~200
> branches/project, ~80 projects, but it works well enough for me.
>
> =A0 =A0 =A0 =A0Jehan

This is why we need to breath life into the git-remote-svn effort.
We should be able to handle imports of that size in minutes.
(Cost of dumping from SVN aside.)

--
David Barr
