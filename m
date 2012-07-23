From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC remote-svn
Date: Mon, 23 Jul 2012 07:04:28 -0500
Message-ID: <20120723120428.GE14294@burratino>
References: <4514544.Xip1OCQ7Uj@flomedio>
 <20120722214333.GB680@burratino>
 <2948040.5ceLh0WG3L@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	davidbarr@google.com, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 14:04:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StHNP-0002CP-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 14:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab2GWMEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 08:04:34 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37063 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab2GWMEe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 08:04:34 -0400
Received: by gglu4 with SMTP id u4so5329483ggl.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ko++DCps8x+tLUPMBw1S0CpAo5fTl5dC0YHx8MZ3gHU=;
        b=qQoaOUCR5U7m7FCVr9nYVyWNkyi+6ffOxZXNrUzcXvVPhnwEIiqcGiRUl2U0Hux3qf
         Nt9Hs4mbpTLbkZDHd9GzM6kE5ClB+TI80+9T8UdG0gsXbNFBLRTZcJ/taxQiacXA2VEB
         cCSm8wspS271DOrL4DhiChgBgYqkxAAMYPOPVJnFJdmb+mHRemhpKQc00DRhQQc0IjWE
         8StmJQh/4lwsg4gBGSSn7t+Fmd+AERaMP00TBhqFyJfR75igDS+gy02moHMcLgMZpkkN
         GLE+L64tLl6lvIZE8fq7UXzcS+PyBQkwLmMeUpSsmO9HDAlJreVy91f/zLmUsYhgHZ7w
         hTqQ==
Received: by 10.43.124.201 with SMTP id gp9mr8130155icc.47.1343045073400;
        Mon, 23 Jul 2012 05:04:33 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id pb3sm13035892igc.17.2012.07.23.05.04.32
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 05:04:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2948040.5ceLh0WG3L@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201930>

Florian Achleitner wrote:

> But when I fetch from a git repo that imported from svn, the notes are not 
> fetched automatically. In this case I currently loose marks and notes.
> What can I do?

In the long term, git will need to be tweaked to automatically fetch
notes along with branches by default.  There are other reasons not
related to remote helpers to want this, too.

In the short term, we can document which ref the notes are expected to
be fetched to.  Maybe someone interested would provide commands like
"git remote-testsvn --clone <repo>" and "git remote-testsvn
--add-remote <nickname> <repo>" as a stopgap to set up the appropriate
fetch refspec automatically so the user doesn't have to worry about
it.

Thanks,
Jonathan
