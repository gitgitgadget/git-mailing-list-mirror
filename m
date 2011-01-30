From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Handle rename of case only, for Windows
Date: Sun, 30 Jan 2011 15:39:31 -0600
Message-ID: <20110130213931.GA11285@burratino>
References: <1296344717.25999.1417928123@webmail.messagingengine.com>
 <4D44CB60.8000506@lsrfire.ath.cx>
 <1296406435.8170.1418006125@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Tim Abell <tim@timwise.co.uk>
X-From: git-owner@vger.kernel.org Sun Jan 30 22:39:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjezv-000166-JI
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 22:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab1A3Vjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 16:39:46 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48395 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab1A3Vjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 16:39:45 -0500
Received: by ywe10 with SMTP id 10so1731716ywe.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 13:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JGzKPq1xOrsbsFpYpZKSqcXqMAqiQUso2VCv+kJOSuo=;
        b=I5AVo16C9w+y1v+cBlbbLegwjI9pIZJbr9q1wAlrf4EeG8eTLU0fIlPqIiAvP0dP7X
         6OYeHYE2I5Sm9WN6Z7YDzDqRSfGg4wpqtmduM+F0pG+0Abpb3XNphwKREz/M0k+Ln0Ay
         RdpTpOvJxL/Lq6eTkR8kCV9otCwcLlqs/Y10U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rXdfu7kUly42sqIRApvu+H7ehN/kg8aY+fVZD6EL8AiRvHD0TEGdGkC3HbBp1asyy3
         I3XDAa+O4b5jtHm4DjW9L/UXREYhvHlCMohqg36OBSOGx+qKwrxvBY+klNCMeD5zwo/C
         kUSGC+8aUt/YRfKvVcEOCYUDyEK/eGk0m0UM8=
Received: by 10.150.11.19 with SMTP id 19mr308297ybk.410.1296423585251;
        Sun, 30 Jan 2011 13:39:45 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.sbcglobal.net [69.209.75.28])
        by mx.google.com with ESMTPS id v4sm1477759ybe.17.2011.01.30.13.39.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 13:39:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296406435.8170.1418006125@webmail.messagingengine.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165704>

Hi Tim,

Tim Abell wrote:

> Thanks for your feedback, you are undoubtedly right about checking
> the return value
[...]
> What do I need to do from here to make my patch acceptable/useful to
> git's maintainers?

Generic answer: see Documentation/SubmittingPatches, section labelled
"An ideal patch flow".  Basically you (or anyone else interested it
getting it accepted) are the maintainer of the patch, so you can make
improvements until you and others are happy with it.

Hope that helps,
Jonathan
