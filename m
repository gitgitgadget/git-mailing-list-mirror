From: Steven Michalske <smichalske@gmail.com>
Subject: Re: git svn clone terminating prematurely (I think)
Date: Thu, 12 Jan 2012 23:10:15 -0800
Message-ID: <FDD0F00A-8BD3-466A-95A6-03FBEE0E068D@gmail.com>
References: <CAJ1a7SrkDOyNRv8Spo4xvoKjP4zaXteim4h3JGcWU-nYDugx9Q@mail.gmail.com> <CALkWK0nyc6NVE7Qpvbc0dXb1UHGM_=uYbCS+a53HZxiBRG9HvQ@mail.gmail.com> <20120111224833.GA29654@burratino> <CAJ1a7SpRP5GymPrpEchuNk3xwkJLHBKjsXY_85Xs_LAzXtWYuw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Steven Line <sline00@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 08:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbHN-0003zv-0V
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab2AMHKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 02:10:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59813 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab2AMHKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 02:10:19 -0500
Received: by iabz25 with SMTP id z25so3924799iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=/bRtPyMvXxR72rBKOa5dj3zNcEY3uCa5ehQeR+5/XTo=;
        b=WRdivDrcpMq2hZHEwlKB1mnm2rE0qdZSiK5j08LgiHx6DSNu7FfJVDhqDXjVC/lLyS
         54pbxLsb2wpIqEbd0eE0yubw53kq2LngJC7ll7xDONSmDqDvuKe2/857WUf701L+3pqI
         QDKSm/2Dz7dOuqtbW0I+DYtDAhDhSRU3N7OEY=
Received: by 10.50.6.194 with SMTP id d2mr1374046iga.24.1326438618320;
        Thu, 12 Jan 2012 23:10:18 -0800 (PST)
Received: from [192.168.1.114] (c-67-161-24-30.hsd1.ca.comcast.net. [67.161.24.30])
        by mx.google.com with ESMTPS id l35sm25901533ibj.0.2012.01.12.23.10.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:10:17 -0800 (PST)
In-Reply-To: <CAJ1a7SpRP5GymPrpEchuNk3xwkJLHBKjsXY_85Xs_LAzXtWYuw@mail.gmail.com>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188495>

Steven, 

In this case nohup seems like a pain.  There is a utility called "screen" available on most unixes.
It allows you to create a virtual terminal that you can detach from.  After you detach you can log out, some time later log back in and then reattach.

Steve

On Jan 12, 2012, at 10:25 AM, Steven Line wrote:

> Thank you Jonathan.
> 
> I had a breakthrough yesterday on this problem.  To make a long story
> short my ssh connection to the server where I was running 'nohup git
> svn clone' was timing out.  Additionally the nohup I was using wasn't
> really protecting the git svn clone process so an hour or two after
> the ssh disconnected, the git would terminate leaving me with an
> imcomplete repository.  I don't understand why the nohup wasn't
> working yet.  So my problem wasn't due to git itself.
> 
> I started my most recent git svn clone and it's now been running for
> 18 hours.  I'm optimistic that I've solved the problem.  If my git
> does terminate early then I'll try a 'git svn fetch' to complete the
> clone, based on what you said in your post.
> 
> -- 
> Steven Line
> 303-910-1212
> sline00@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
