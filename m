From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Push to all repositories
Date: Thu, 9 Dec 2010 08:36:44 -0500
Message-ID: <AANLkTik9CxVD9A-2QEyD_tZiyYoCOitfViWucGCudzh-@mail.gmail.com>
References: <1291829983410-5816069.post@n2.nabble.com>
	<20101208180049.GC5687@burratino>
	<1291849156593-5817177.post@n2.nabble.com>
	<1291898174244-5818757.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kevin Sheedy <kevinsheedy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 14:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQgfz-0002XG-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 14:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab0LINgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 08:36:47 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:46697 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0LINgq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 08:36:46 -0500
Received: by eyg5 with SMTP id 5so1770587eyg.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eT0Kvt2kEvo3nb5qiIBN+MGL/P3x91xuwBzMvA1mzPQ=;
        b=F1h5AfWElFSuE9jDnRUf0w8H5/R3Xh7+QDGyL1ALVXIZ4AcaCAMqTGwpYDpzUnRZQj
         V+idVOD5eTrQSCtftxtQ8l4C/f19iBRRAQfeuHHhh6ViUsLJ/BsCmSpENtbYkzzGtcR0
         A2nUgqbOpcePuGolc9QscTkhclTxe7ljPzvfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FMBX6+0G+kQhiMJNxTPEOLlfuusBbVcpFy2GLeikTBysL1cjk58RNjIZCzi+Dexg32
         a/gmwnrnYEbi8lmGpsZNRgA5GpBdToZn5T1H/nBBXxGsVEdLcqpgtCo5/D3svKxePNiY
         eFEa6h60Ok8wVtQJIRKFc8ugp0vYf6v2+FI9I=
Received: by 10.14.48.66 with SMTP id u42mr8506799eeb.40.1291901805013; Thu,
 09 Dec 2010 05:36:45 -0800 (PST)
Received: by 10.14.124.197 with HTTP; Thu, 9 Dec 2010 05:36:44 -0800 (PST)
In-Reply-To: <1291898174244-5818757.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163282>

On Thu, Dec 9, 2010 at 7:36 AM, Kevin Sheedy <kevinsheedy@gmail.com> wrote:
>
> In summary, I think it would be cool if there was a programmatic way of
> saying:
> "Hey everybody, I've changed some code on branch x and I think you should
> have it"
>
> Everyone else would then have the choices:
> 1) Always accept, I trust you (but don't blow away my current work,
> obviously)

I think the closest thing would be a cron job that runs "git pull"
every minute or so. A difference from dynamic views is that it would
no longer update your work tree once your changes start conflicting
with the upstream changes (in dynamic views, all unmodified files
would be updated).

However, rather than trying to make Git behave just like ClearCase
dynamic views (there are many other things to consider than automatic
updates), I think you would be better off if you actually use
ClearCase dynamic views instead.

> 2) Always ignore, I'll get it when I'm good and ready

This is of course the easy case; just run "git pull" manually.



/Martin
