From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Allow cloning branches selectively
Date: Sun, 25 Dec 2011 08:28:39 -0800 (PST)
Message-ID: <m3hb0ofwem.fsf@localhost.localdomain>
References: <1324671199-7074-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Q2FybG9zIE1hcnTDrW4gTg==?= =?utf-8?b?aWV0bw==?= 
	<cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Dec 25 17:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReqwH-0008OL-On
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 17:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab1LYQ2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Dec 2011 11:28:42 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64871 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab1LYQ2k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Dec 2011 11:28:40 -0500
Received: by eekc4 with SMTP id c4so10621598eek.19
        for <git@vger.kernel.org>; Sun, 25 Dec 2011 08:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=gpD2JnJ4zDR10kSyRwz38ZHvCnMZ7gRTsC2ZVMMRhyM=;
        b=DTyXZiXwp0nBbPwwEsssBI/PchHAnIyv0NKc3Byoe+SsDMIErHjIhdXPBX9XdAf4Pn
         88xDmIewCp7TgfwfGf4MJ7Kn1IU1oxzOKYlf8OMCla0chXEDlpUxBHiJA9eba6KXYc87
         JkEnc+MSVRRporqgBSKufNEgXlduijkLeDt7E=
Received: by 10.213.31.69 with SMTP id x5mr4399269ebc.17.1324830519738;
        Sun, 25 Dec 2011 08:28:39 -0800 (PST)
Received: from localhost.localdomain (aehn107.neoplus.adsl.tpnet.pl. [79.186.195.107])
        by mx.google.com with ESMTPS id u53sm31519897eeu.6.2011.12.25.08.28.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Dec 2011 08:28:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBPGSY4B001495;
	Sun, 25 Dec 2011 17:28:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBPGSX7b001492;
	Sun, 25 Dec 2011 17:28:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1324671199-7074-1-git-send-email-cmn@elego.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187682>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Sometimes it's useful to clone only a subset of branches from a remot=
e
> we're cloning. Teach clone the --fetch option to select which branche=
s
> should get fetched.
>=20
> Each --fetch sets up a fetch refspec for that branch. Previously this
> was only possible by initializing a repo and manually setting up the
> config.

I haven't read the code, but I guess it should be possible to share
code with "git remote add", which allows to select which branches to
track, and which branch is to be 'main' on remote.

  git remote add [-t <branch>] [-m <master>] [-f] ...

--=20
Jakub Narebski
