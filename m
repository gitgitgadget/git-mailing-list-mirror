From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 27 Feb 2009 21:41:02 -0500
Message-ID: <eaa105840902271841p2cb45eb1ye0bafb136c0cceaf@mail.gmail.com>
References: <20090224223412.GA4573@raven.wolf.lan>
	 <49A50EB2.80300@drmicha.warpmail.net>
	 <20090225232442.GC4573@raven.wolf.lan>
	 <eaa105840902251702l68bc35f3ia15b1c804a6825f3@mail.gmail.com>
	 <20090227165812.GA14187@raven.wolf.lan>
	 <eaa105840902271011u19375ba4j4a765ed2707ebb3b@mail.gmail.com>
	 <20090227235824.GD14187@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 03:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdFAA-0001U1-Cl
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 03:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbZB1ClH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 21:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbZB1ClG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 21:41:06 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:52202 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbZB1ClF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 21:41:05 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1034165ywh.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 18:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=0jKtz+q8IO/WLN6kjY4gUH4B4S8yGovs1nd+NQR0a48=;
        b=Kig/BGO0vpcm+7lLXBz7FfFl7pXFbPC7YSKo2lc871n0qwtI9uuLZ+Vxod/sjxm9lx
         QiouYXQ6hAiGoUJcqWmTTgjPq7YZnY4yVD4ISgByEnnZYD1AGb0+pXzWik55CYRrjswv
         Qh1uM3I3sKWZxcY1zHB/tc7x5k6giVWE8gzz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ECb79Bzjkhm0coSNXQ2FALFsSlXwS0JucRzCFPiGsN+QDUvtrBud8mV+jzxdGGcITc
         Kw0DoJ21pi7Y4OYHMKQEJ7gFixoNrnHsCOZPISH0S4KJDy2u3ZvnoULYCdXaJcIqUggg
         FSM2jzdWvctqP8w43YlFjcf8I+PH/XxVgaawk=
Received: by 10.220.85.199 with SMTP id p7mr1223992vcl.104.1235788862932; Fri, 
	27 Feb 2009 18:41:02 -0800 (PST)
In-Reply-To: <20090227235824.GD14187@raven.wolf.lan>
X-Google-Sender-Auth: b12ede847b79e58d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111740>

On Fri, Feb 27, 2009 at 6:58 PM, Josef Wolf wrote:
>
> At the time I read the tutorials/howtos/whatever, I thought I underst=
and
> what "rebase" actually means. =A0But now I get pretty much confused, =
since
> there are "git rebase", "git pull --rebase" and "git svn rebase" invo=
lved,
> and they all seem to do very different things.

(simplified, take with grain of salt:)
"git pull" is short for "git fetch && git merge <tracking branch>"
"git pull --rebase" is short for "git fetch && git rebase <tracking bra=
nch>"
"git svn rebase" is short for "git svn fetch && git rebase <svn
tracking branch>"
"git svn dcommit" is short for "while (changes) { svn ci && git svn reb=
ase }"

It's all just shortcuts for the same operations underneath. Does that h=
elp?

Peter Harris
