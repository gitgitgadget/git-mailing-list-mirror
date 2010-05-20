From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 08:34:47 +0000
Message-ID: <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
References: <4BF4E40B.30205@math.tu-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: matthias.moeller@math.tu-dortmund.de
X-From: git-owner@vger.kernel.org Thu May 20 10:34:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF1DW-0004WE-3p
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 10:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426Ab0ETIeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 04:34:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65465 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab0ETIes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 04:34:48 -0400
Received: by iwn6 with SMTP id 6so4044505iwn.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tKiYt6fo1Db1yyieJsWuvhJTqs1sJ/F2haxgwNHZAtw=;
        b=i8zyJqtxuCzxrtghhCrq1wUVel/ldIEn8wE5utkymh7i86icXWcqlxn1KvU7g+4H1/
         8Vx/AdrKCMV6uilbuBjc+eOSfX1fRlZarnJhb81/XRK0cFkSPAXTC5CzTpfwMJtxHxVk
         L4YK50h2VwWOipth31tcc0E7d3jhk64H5qCR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XIuanFVxuaZFejON4tGVaGw4IEmX76uVich4Bxe5L+Yc/hsPJL2SxaCCJ10Uai+3fV
         YdrMJtCiE7ZnsqSS9IBsQToaEZglEqkQtXk4vY48GleVLarkEc4elVTkSLvMAFPKE68j
         oQf61dHCwFNfLv8oIzjVWe4TKvwUztkTmk4lE=
Received: by 10.231.148.200 with SMTP id q8mr624749ibv.10.1274344487773; Thu, 
	20 May 2010 01:34:47 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 20 May 2010 01:34:47 -0700 (PDT)
In-Reply-To: <4BF4E40B.30205@math.tu-dortmund.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147362>

On Thu, May 20, 2010 at 07:26, Matthias Moeller
<matthias.moeller@math.tu-dortmund.de> wrote:
> I have been searching the web for help and found lengthy discussions
> which state that this is a common problem of the HFS+ filesystem.
> What I did not find was a solution to this problem. Is there a solution
> to this problem?

Is this problem particular to Git, or do you also get it if you
e.g. rsync from the Linux box to the Mac OS X box?

> #       "U\314\210bersicht.xls"

You probably have to configure your shell on OSX to render UTF-8
correctly. It's just showing the raw escaped byte sequence instead of
a character there.

There isn't anything wrong with OSX in this case, filename encoding on
any POSIX system is only done by convention. You'll find that you have
similar problems on Linux if you encode filename in Big5 or
UTF-32.

Linux will happily accept it, but your shell / other applications will
render it as unknown goo because they expect UTF-8.
