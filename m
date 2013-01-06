From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 6 Jan 2013 04:09:17 -0800
Message-ID: <20130106120917.GC22081@elie.Belkin>
References: <2491041.bQ51Qu8HcA@thunderbird>
 <1890551.8jTmplCF6O@thunderbird>
 <BB541ECCD3F04E479F06CA491DDB598D@black>
 <50E92675.4010907@web.de>
 <20130106093211.GB10956@elie.Belkin>
 <50E946EB.1000709@web.de>
 <20130106095757.GC10956@elie.Belkin>
 <50E9647F.4090209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 13:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trp2s-0006RP-VV
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 13:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab3AFMJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 07:09:24 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:42540 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab3AFMJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 07:09:23 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so8236490dan.9
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 04:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QMLQKphCUEjY/ZIAb4oagT/M3BRSiDzYc0WNs0LNnjQ=;
        b=AkW4YbQT6RQF8N5yo6g3iDpaebwJanngnkF5kybdsHg+FELBq2DKZfa6t9xmVxsKSA
         foppAW9msUXg6NArHPENnymM/ftTbZFj4G+sv9OSjompAkYtJJzCBmV+J4lRAxEX5Lnq
         ZVXRLBiYZaubqQbRAk4pFlEK757c7s04ItqLI7EdqgIWuzG+gd6OXu9/gKAQn9ThJ/U/
         Tf4v4O2ucFABHfQAqhD8Z8hcnBwLHyM/hIMmuzkMZ1cG8mPFhszB8GlZtW/SedroHxS/
         Ht+lJw9dmynGaHm6ZSuvPr75Fon124Q6rtI5OcyXsJti9QSSONavonk5kBgHyuz/5v6H
         gCPw==
X-Received: by 10.66.86.71 with SMTP id n7mr169304922paz.77.1357474162992;
        Sun, 06 Jan 2013 04:09:22 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id jv1sm30424452pbc.36.2013.01.06.04.09.20
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 04:09:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50E9647F.4090209@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212797>

Mark Levedahl wrote:

>                                                          However, the newer
> win32api is provided only for the current cygwin release series, which can
> be reliably identified by having dll version 1.7.x, while the older frozen
> releases (dll versions 1.6.x from redhat, 1.5.x open source) still have the
> older api as no updates are being made for the legacy version(s).

Ah.  That makes sense, thanks.

(For the future, if we wanted to diagnose an out-of-date win32api and
print a helpful message, I guess cygcheck would be the command to use.)
