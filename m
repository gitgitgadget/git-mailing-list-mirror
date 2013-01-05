From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-fast-import(1): remove duplicate "--done" option
Date: Sat, 5 Jan 2013 15:12:50 -0800
Message-ID: <20130105231250.GE3247@elie.Belkin>
References: <20130105160652.GE6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrcvT-00006B-6i
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 00:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab3AEXM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 18:12:56 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62510 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab3AEXMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 18:12:54 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so10006883pad.23
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=81Kkk2gnvUEHJU2F2/INuKdT65YyS9iTVcs7ZdRwfEo=;
        b=NFn5gZJh124m4KCivo207PjDN/PcQS7bnBsFrM5gmnzebENVTjOurATwj3iKfnUHkE
         jpf/pf/XZGXDoYw64+cpHOcxAPYoc/du4dcfM21IJYuD+r8Qxv3NpBLuDI7ZpUI/M4dR
         BCYWKc5Ye4SgDHQCXx9FfgRkdtocSZ1iLnYSvdJen8otXBk0azG6sCbzq/Ce4q49gipA
         g46l1m50kua9RC+wYGInq6EPO5eY4IFQiz9RRpCFLXZ+mCiYtlqBMCkT/W4rLbKDrFd9
         Ei56W6unTJC6Lp/mUG+tj9VDm6ZhoLFq1WkGUp9e1JH3+57+f/K3/EzxHravbkGPz/2d
         uGyA==
X-Received: by 10.68.235.1 with SMTP id ui1mr6984858pbc.138.1357427574414;
        Sat, 05 Jan 2013 15:12:54 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id vk5sm34743489pbc.34.2013.01.05.15.12.53
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 15:12:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130105160652.GE6440@serenity.lan>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212739>

John Keeping wrote:

> The "--done" option to git-fast-import is documented twice in its manual
> page.  Combine the best bits of each description, keeping the location
> of the instance that was added first.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Good catch, thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
