From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Does git fast-import support deltas?
Date: Thu, 18 Apr 2013 23:13:23 -0700
Message-ID: <20130419061323.GB5055@elie.Belkin>
References: <323381594.20130414121834@gmail.com>
 <673219382.20130414124800@gmail.com>
 <20130414113351.GA1299@thyrsus.com>
 <1762779000.20130415215818@gmail.com>
 <20130418094326.GB11038@thyrsus.com>
 <1095757971.20130419092931@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 08:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4Zj-0004ey-OD
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 08:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416Ab3DSGNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 02:13:31 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46245 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab3DSGNa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 02:13:30 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so2023656pdj.38
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6Y9u6iX6BRpwObtsW9Uby1UeQGb3MT20FXdSN//yH4A=;
        b=QwQtfNpLjjcoWBbS2KyHRHzeazb+nag+yhXPvsI61MZspC7zKjJTeFaH1ZhLKTPV5l
         BDgwkWPlw0mHpmGG+AYIRcZJc+MewSUIBwvIGOx8mXvQQhwmzjXaR8xZSsVdo2qYtMFU
         OpIU1Tt2K3QQkRcQUDB3/PxYqCEbI9nKjRhmfylwLZACE7HwSY3M+YImONTZfwA6y6yN
         v4xdZcTH8805rcrLWc6/Ir+NRXfAdJLiqus9NSPDfjlImkAvlCh9Tg8b60+vqLV7w1fY
         cLg0EV47Nc09MmdSKHwTzmPSyWjobXqsYHFyYh9UB6KEsdcaHLw8aggPP2fp4PmEJPwn
         dR3A==
X-Received: by 10.68.100.164 with SMTP id ez4mr17071954pbb.109.1366352010030;
        Thu, 18 Apr 2013 23:13:30 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id b7sm12232204pba.39.2013.04.18.23.13.27
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 23:13:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1095757971.20130419092931@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221741>

Hi Ilya,

Ilya Basin wrote:

> 1) a created a git repo from a foreign source using git fast-import
> 2) new commits were added to the foreign source
>
> Can I create a fast-import input stream not containing the commits
> already existing in my git repo and import it?

Yes, if the foreign source is structured in a way to make it easy.
Take a look at the --cat-blob-fd option, the "ls" and "cat-blob"
commands, and see svn-fe from contrib/svn-fe/ as an example.

Hope that helps,
Jonathan
