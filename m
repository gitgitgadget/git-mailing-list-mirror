From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Wed, 26 Feb 2014 12:26:01 -0800
Message-ID: <20140226202601.GK7855@google.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:26:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIl3T-0007Ci-6C
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbaBZU0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:26:06 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:53345 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaBZU0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:26:05 -0500
Received: by mail-pd0-f175.google.com with SMTP id x10so1427650pdj.20
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 12:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=idjuOwgu0bydHUtrJJQ+oSU5xLGsBSYTMQkbwRx5ceg=;
        b=0Fpd+t+QHnDdbT9PgPl+H+AMtJfTyOIdSF6OAILUNGEH5yxVBdLyCmzJHAG2tLtbp0
         geGd/aZlzHk56IJikVqloeVQaR4yNCj2mwjlqaUbg70LGOy07LCB36VapE2ghdbAqMFd
         4smiFk2sCnR9ca0VCC9L6OPyOPNPdLQMKpnHMmHaiSwpKaDtfb7kq6zZ886KajPlKHTm
         Z+zsUx7kaQ3KhBMxnCAAsL7IHwqhrZIqpOwxCh661f0GvJXu7QQei7QFIdoeCc36seC4
         tU4HL7WZC4NiGdDo5yEyba0M8z76/ZBhTJ8RjIdg+fFgd8Gl7nQ61NIqOayFu0P8RF8I
         Npjw==
X-Received: by 10.66.158.132 with SMTP id wu4mr11137292pab.66.1393446364715;
        Wed, 26 Feb 2014 12:26:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id js7sm6214725pbc.35.2014.02.26.12.26.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 12:26:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242758>

Hi,

Andrew Wong wrote:

> The first two patches are just about rewording a message, and adding messages
> to tell users to use "git merge --abort" to abort a merge.

Sounds like a good idea.  I look forward to reading the patches.

> We could stop here and hope that the users would read the messages, but I think
> git could be a bit more user-friendly. The last patch might be a bit more
> controversial. It changes the default behavior of "git reset" to default to
> "git reset --merge" during a merge conflict. I imagine that's what the user
> would want most of the time, and not "git reset --mixed".

I don't think that's a good idea.  I'm not sure what new users would
expect; in any case, making the command context-dependent just makes
the learning process harder imho.  And for experienced users, this
would be a bad regression.

An 'advice' message pointing the user to 'git merge --abort' might
make sense, though.

What do you think?

Thanks,
Jonathan
