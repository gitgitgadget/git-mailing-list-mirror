From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 12:18:25 -0500
Message-ID: <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes> <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes> <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:18:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7tML-0006w1-VX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab0JRRSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 13:18:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42215 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab0JRRSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 13:18:47 -0400
Received: by gyg13 with SMTP id 13so569132gyg.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=RTcUT+1sl+OvlLdGPByUjDt/hzI2YeQhrR9OCgkiNcQ=;
        b=jX0qYmTIMiOrSP7k2wl3Ol8RngmVney0GFp+PbQJPMdJqWq9WNiXp2/xVazbGHadV8
         JhKEkMeP0OiwTS3WRQPKKlhI+TGe0hMTYawpJbcNUw26qqZ/yjqLjSsCBAxzlin1LmK0
         6XTeeKyReIlkVhzeP6SZ1I11krVSr/X+peu0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=J9W1Uc7WznL8QXbGU/UwJQiziDrMoGyT2UZD+Rw+TpWXaVfc4F4vSb6KpwIcpmHvE/
         HWPcgpebLYFWNV2QgjRFS7D5fB9Ff9wcvoZ9PeGbD9cls1fi21NMDZPsE6deklP01RdP
         rPIE6PkXO/F+J2mRPAgTHfWuerYkAYFQWbe+I=
Received: by 10.151.10.12 with SMTP id n12mr7227959ybi.148.1287422326364; Mon,
 18 Oct 2010 10:18:46 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Mon, 18 Oct 2010 10:18:25 -0700 (PDT)
In-Reply-To: <20101018165631.GA6718@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159270>

Heya,

On Mon, Oct 18, 2010 at 11:56, Jonathan Nieder <jrnieder@gmail.com> wrote:
> FWIW I just wanted to make sure people don't forget about the
> incompatible object models.

> Pulling from svn is a harder problem but luckily the single-upstream
> case is the usual case (so object model mismatches are easier to cope
> with as long as one can find the corresponding svn rev number for a
> given git object easily).

I think I'm missing something. What do you mean with this?

-- 
Cheers,

Sverre Rabbelier
