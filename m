From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Remove pdf target from Makefiles
Date: Mon, 17 Jun 2013 21:34:56 -0700
Message-ID: <20130618043455.GB2896@elie.Belkin>
References: <1370125851.738272.1371492972525.JavaMail.ngmail@webmail23.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 06:35:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UondL-0005rM-WF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 06:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab3FREfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 00:35:01 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:51149 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab3FREfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 00:35:00 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro2so3465935pbb.41
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 21:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GsZ8CS+6lPUqkAFsVi2OZMB6cPz3coSLXBlIwBhck/4=;
        b=rX4hKQN5DrG7yoeSXHdQGQt5wJ3NBKWuVHw0+u29Jx5AKtM4dp4ODnS1PXxI6QZ7mi
         bCi2osLK9rYSQyYKEu40k5LWrdgEwWL9u0VWVoTeu0AD9ymog2gdpSnJBLonxe6jDH2M
         cXk0cVZVDxmHLJ09xavbpcW/uUBDuxIaI6CVmXb13Pm+0x/73C+B56c1m5vHMAW6B1F4
         W+9Al5Hzd0w9p/gf2XXcC5T9IWH980lFbSAhA28WvOtNXO8Eg8XBFaTI44DDK4Otv1iM
         C8dlskgGVIFNI8uQU5Co5NC/1d89CWkNNKejms7ocWM2sylAOpg9h4db0VtXOCrMQlyK
         i1Sw==
X-Received: by 10.66.26.142 with SMTP id l14mr458312pag.197.1371530100418;
        Mon, 17 Jun 2013 21:35:00 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id 6sm16417701pbn.45.2013.06.17.21.34.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 21:34:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1370125851.738272.1371492972525.JavaMail.ngmail@webmail23.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228152>

Hi Thomas,

Thomas Ackermann wrote:

> This target was only used to create user-manual.pdf with dblatex
> using a separate style definition than was used for user-manual.html.
> These two style definitions had to be maintained separately and
> so made improvements to user-manual.html unnecessarily hard.

I don't understand.  Do you mean that you want to change the rules
that generate user-manual.xml?  Would generating different XML files
for the PDF and for other purposes (with different names) work as a
way to achieve that without losing the printable manual?

Thanks,
Jonathan
