From: Douglas Mencken <dougmencken@gmail.com>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Wed, 21 Nov 2012 14:20:40 -0500
Message-ID: <CACYvZ7hDu=r1=x_ofsVud6+0krZD5wPoE0Q9yjLg_e6y7MzPuQ@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
	<50A2978D.6080805@ramsay1.demon.co.uk>
	<50A2B2DF.1080704@web.de>
	<50A53FAC.8020401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:21:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFr6-0008VP-DB
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab2KUTUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:20:43 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47356 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab2KUTUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:20:41 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so2988009lbb.19
        for <git@vger.kernel.org>; Wed, 21 Nov 2012 11:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=njRmgrtBEuwVJ+VGzhG2XLdgAWqtXmKHXM3wK7iLf8c=;
        b=zijsf1UhDrqji/haxk/x1kd3TdxKe5Lz4OyPYgiS3DBUolaeD28MoJFmLP7dkR3aka
         8ckShAl+xPTg1SvD5bLkNwh3cdPAT+A0JH8bwHDtr1Mxnm+ZFwKR6+vJhZAsctMG/1Uo
         XqlpjcsctZuvZFrQTThzrQdOQor2hjXFax8bwOio7zT5iEFomZyJNnhz8DNXe5yib9Pk
         9wCb/9FIWTKcY8rhwkOs7weYLHk87/ttvOZMtOfQ1vvdr3mqil+0qD6v36WAf72HRdDc
         j2zh450umbExfpAtz6qEuIYvV1J/zpjxp9JHKCibtmaB0NMmgnqWOtICYCYTDJKJCkFV
         G66A==
Received: by 10.152.106.212 with SMTP id gw20mr18832543lab.8.1353525640360;
 Wed, 21 Nov 2012 11:20:40 -0800 (PST)
Received: by 10.112.22.6 with HTTP; Wed, 21 Nov 2012 11:20:40 -0800 (PST)
In-Reply-To: <50A53FAC.8020401@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210163>

> The threaded index-pack code did not fail for
> me on cygwin at all during development, including tests, but failed
> immediately I installed v1.7.11. On real repositories, it failed
> intermittently. On some repos it always failed, on some it never
> failed and on some others it would sometimes fail, sometimes not.

Then why did you commit it? If it has so high random failure rate.
