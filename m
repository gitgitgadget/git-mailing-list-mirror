From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Mon, 7 Jan 2013 22:28:11 -0800
Message-ID: <20130108062811.GA3131@elie.Belkin>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: schlotter@users.sourceforge.net, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 07:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsSfx-0001Bk-14
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 07:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab3AHG2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 01:28:21 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:39368 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3AHG2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 01:28:20 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so34994dam.18
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 22:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Mb7+Q8wnmmeev2RJnueqmW1qXIG5UfBMK56QuPtJZYE=;
        b=slg5aqgfPJSSwfBTaDj+5ELbIxWIjUfoxDzZMEMsdDd/fe8wuusL4OND/KChq58Dru
         uBWrtWLcncg3E+Ulm2qMgwOEirq9+xt/raa697X643C8z5A9JKHBfYcBFZzampXrKHyX
         LiaOgPUKyaIdzktPMf6kUtqwVJV4890nlozkI8mGH0ryiGAGwb/FlOCACpIaWb2y2LSV
         KfbtSpmx84hYjgfT3FH89RYGtg5Wk7/m3RbOPgK/nv3XHDGENlhqtECPC6oW0reR2wPb
         sMtsJW7BygpRvzZ8ZDmpI/F8GrQFZKZYsnn5LUb9eIyElHpHjFOx040czEfFJyHe8fQq
         tSjQ==
X-Received: by 10.68.209.230 with SMTP id mp6mr193434840pbc.8.1357626499997;
        Mon, 07 Jan 2013 22:28:19 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id gu5sm39057674pbc.10.2013.01.07.22.28.17
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Jan 2013 22:28:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212935>

Stefan Beller wrote:

> Currently it is not possible to have a shallow depth of
> just 0, i.e. only one commit in that repository after cloning.
> The minimum number of commits is 2, caused by depth=1.

Sounds buggy.  Would anything break if we were to make --depth=1 mean
"1 deep, including the tip commit"?
