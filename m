From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Restricted git push ?
Date: Tue, 19 Jul 2011 20:33:23 +0530
Message-ID: <CAMK1S_hhHhETL2tE=E98Bku96KULC9L-pHCwz3iPjwEcMbCe9w@mail.gmail.com>
References: <20110719150637.596b9791@shiva.selfip.org>
	<CAMK1S_jsv-pFy6bNPG=EK=4YsJOh3GUZ+_DAq6n36ajWuhyNaQ@mail.gmail.com>
	<20110719160311.10f2364d@shiva.selfip.org>
	<20110719161529.47268b52@shiva.selfip.org>
	<20110719164037.05fd4a36@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Jul 19 17:03:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjBpZ-0007Gq-6L
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 17:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab1GSPDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 11:03:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54558 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1GSPDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 11:03:23 -0400
Received: by vws1 with SMTP id 1so2945939vws.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G5qHE0CJK2GqAhjgtivp99B8h5UPbwhn5VVdpKPiM9o=;
        b=uorw7efB+rp+59DG8M2NP+mdOUnbz1/BPmAdMrJ7YD+GliB4n66fV021qRJDC0/i2n
         Mz7bx8pIT610yhq3940BdjDvM4tfutuM+5eIvUVIZfk/eJvw2QkfIJVunroH/vdRYSj0
         Sy/wgopJidWotPCfF6HDNyFdkdDx7TylEQ5oY=
Received: by 10.52.76.105 with SMTP id j9mr7965737vdw.220.1311087803057; Tue,
 19 Jul 2011 08:03:23 -0700 (PDT)
Received: by 10.52.167.105 with HTTP; Tue, 19 Jul 2011 08:03:23 -0700 (PDT)
In-Reply-To: <20110719164037.05fd4a36@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177457>

On Tue, Jul 19, 2011 at 4:40 PM, J. Bakshi <joydeep@infoservices.in> wrote:

> Just like git-receive-pack anything for git pull,clone etc.. ? then we can use those to restrict read access separately. Users having read access need not have the right access then.

git-upload-pack I guess.  Maybe git-upload-archive also.

-- 
Sitaram
