From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 06:25:19 -0700 (PDT)
Message-ID: <m362o5vrhd.fsf@localhost.localdomain>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: James Blackburn <jamesblackburn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 15:25:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXCZa-0006yO-PW
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 15:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab1FPNZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jun 2011 09:25:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64857 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab1FPNZV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 09:25:21 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so1104460fxm.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=W/Vk64btza2k76IfgAkwxCbAmzQLyCIrKFGear2CiRI=;
        b=wMGMRpcmaV81yTHFl9KLKPWQ5Cj0ZJI9ZdmnbOh4FSUub6K4HqOuaqv0B+/AGRT96o
         +uQP/ESlOLHQrULEmYJCQ98isosLvG9vNyQXfBuU+afQmE2Oldcf834r6iOIdB790Rdf
         WLfJ7usOc//WkADg4YwoOI6iJK87xyNJ71MjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=M4LZEyPJe70SuZEs7UQorqYTYGBybi/rP9iwUAFfIYVZdoQwWFZouUmGpUlzJf4SSA
         tITx8OjLls6YsDkD3mFelCdKEqMrCcnCBKoScrD9+Z+UipGvHUF8MjqKFnrftdIh4ow1
         G8kt7nirNdcmUVj/cMTbug2bNvME+gFhekiPQ=
Received: by 10.223.6.201 with SMTP id a9mr1082315faa.110.1308230720324;
        Thu, 16 Jun 2011 06:25:20 -0700 (PDT)
Received: from localhost.localdomain (abve99.neoplus.adsl.tpnet.pl [83.8.202.99])
        by mx.google.com with ESMTPS id h9sm819739fai.30.2011.06.16.06.25.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 06:25:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5GDOvRo017517;
	Thu, 16 Jun 2011 15:25:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5GDOlr5017513;
	Thu, 16 Jun 2011 15:24:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175896>

James Blackburn <jamesblackburn@gmail.com> writes:

> I'm trying, without success, to get git log to show the history of a
> file across a rename. =A0I'm using=A0git version 1.7.5.4, and git bla=
me
> has no such issues tracking the source of the lines.

[...]

> Have I done something wrong in grafting history like this, or is this
> just a problem with the way git log --follow tracks renames?

The `--follow` option to git-log is more of a bolted-on hack rather
than proper solution, see 750f7b6 (Finally implement "git log
--follow", 2007-06-19), and it might not work in all cases.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
