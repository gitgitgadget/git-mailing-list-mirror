From: Zak Whaley <zak.whaley@gmail.com>
Subject: =?windows-1252?Q?Can_I_specify_a_=93chunk_size=94_for_git_svn_fetch=3F?=
Date: Wed, 4 May 2011 12:06:30 -0700
Message-ID: <BANLkTinXvjQth3wBmZUu8A0QszCXm8dc6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 21:07:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHhPV-0006uD-JL
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 21:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab1EDTGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 15:06:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40177 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab1EDTGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 15:06:51 -0400
Received: by wwa36 with SMTP id 36so1566867wwa.1
        for <git@vger.kernel.org>; Wed, 04 May 2011 12:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=7MgXmrKq2ePZZn+ougt6yPRNH9Ma786HDyFC8LHzejc=;
        b=LxORm1KcZugzeQIBNxdcB4hD6/c/swOBn1XRw8FAXSYN2Rtozb8D8TUdWeaXC7CJtd
         wmxzunzyC2P1/fLANqasH2A6SothjyIJ2Vi+vCfESAkmGY9vBNBwBuAyjGdnkNM58dHR
         Y6/O3wBMZIt5c4nJTYvjQglbe1iKS6vePN3ng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=En5PGm056bsfhSzBx72+ClL5ysKg4frx99opwnhzGMuhd25rq08pnhSfoRUQTcIJWO
         U1I0mogZKGqCIcPs+xh1KuBeS98FQe52nEiPwwjbjKGGQ8n0V6c12e1UnRAm9WbdfssU
         JMCcrMOigKxvS8nF3oGSamu5nUSUqtmsdVZ1o=
Received: by 10.227.43.9 with SMTP id u9mr1517748wbe.74.1304536010377; Wed, 04
 May 2011 12:06:50 -0700 (PDT)
Received: by 10.227.142.203 with HTTP; Wed, 4 May 2011 12:06:30 -0700 (PDT)
X-Google-Sender-Auth: TGtz4hDqK45mdBFzH-BhpjzW5BU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172761>

I asked this over on StackOverflow
(http://stackoverflow.com/q/5886993/665372) and someone suggested
asking this mailing list.

I'm cloning an SVN repo with git and everything seems to be working
fine. The very last revision I need to download contains a ~220MB zip
file.

I know this isn't an issue for git, however the school's server I'm
downloading it from hangs up half way through the file which
invalidates the entire index requiring that it re-download the
revision again.

Is there a way to tell git-svn fetch to get an index in multiple
chunks of a particular chunk-size or to retain the partial index if
the server hangs up?

Spec info:
Win7 with Cygwin 1.7.9-1
git & git-svn 1.7.4-1


Regards,

Zak Whaley
