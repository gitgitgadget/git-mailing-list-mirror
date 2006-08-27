From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH] Simplify code outputting relative timestamps in git log
Date: Sun, 27 Aug 2006 16:27:52 +0200
Message-ID: <dbfc82860608270727w783688ecva69013e2437c7729@mail.gmail.com>
References: <11566886081901-git-send-email-now@bitwi.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nikolai Weibull" <now@bitwi.se>
X-From: git-owner@vger.kernel.org Sun Aug 27 16:28:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHLcD-0006oG-Rz
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 16:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWH0O1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWH0O1x
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 10:27:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:1851 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932129AbWH0O1x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 10:27:53 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1390218wxc
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 07:27:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=C+NaJZNM1FABZ7pjSfUiRKhZO5vwnENQLNGZYjKyBcDruZsjzxIairkAUUJi/kiC52rJnh/2AXYEvF0b7+OnTS4J+RREGtBJmNCEVpqkj3lAYOuFgQOfokzDJK3wLFiSjTzDBIf+6iimvkyJ5kRVjl3wIBk0yjI/MpZrHzEa33E=
Received: by 10.90.54.4 with SMTP id c4mr850693aga;
        Sun, 27 Aug 2006 07:27:52 -0700 (PDT)
Received: by 10.90.68.17 with HTTP; Sun, 27 Aug 2006 07:27:52 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <11566886081901-git-send-email-now@bitwi.se>
Content-Disposition: inline
X-Google-Sender-Auth: fec663e05a2f14c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26099>

On 8/27/06, Nikolai Weibull <now@bitwi.se> wrote:
> From: Nikolai Weibull <now@puritan.pcp.ath.cx>

Hm...why is format-patch not using user.email?

> The code that outputs relative timestamps is repetitive and can be
> simplified by using an array to deal with the various cutoffs.  This makes
> it easier to modify and remove the cutoffs if we in the future desire to do
> so.

I just realized that I forgot to update the cutoffs to those in the
repository.  I was playing around with other cutoffs.  I'll send a new
patch if it is of any interest.

  nikolai
