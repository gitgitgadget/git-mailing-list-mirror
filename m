From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 10/41] update-ref.c: log transaction error from the
 update_ref
Date: Wed, 28 May 2014 09:49:50 -0700
Message-ID: <20140528164950.GL12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-11-git-send-email-sahlberg@google.com>
 <20140528002738.GJ12314@google.com>
 <CAL=YDWnvo-oLd80Kgd1qnqUSSSrwNfcq_wHEjLRCa0Jr4XCjwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 18:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wph37-0001Cs-If
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 18:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbaE1Qtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 12:49:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62738 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaE1Qtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 12:49:53 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so1444592pab.8
        for <git@vger.kernel.org>; Wed, 28 May 2014 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8iAT6SWZ+As1GfSc0U8OmiXNlFEnAsRJKWMUucyKpTI=;
        b=1ApOZELz1Yuvcr9dkT11RcXTVsBmsO03IiesXI7/hSs3oWbwXuvft2VpRbC6IMYvqN
         0uI7iG+6RZlEiO9JvRJRdnxU2T15Lrlr9fCS9iU0CXtfVE+tl2YgFyfZ1GLKsSr8Im0K
         lWuG9zHXbn7gTewrlG5CaSUCf4ZR2pwx5ZMrgcoBaLToA/VeirvIwqJj60n1EvVjcLNT
         zWg0yrtvAUvr5RWV0PxMZC4yd9bnGrVU+mZ0/P3B7PIcPWZIJ8gpt4XfL5gG47AAbrNb
         xXyQGJcGZ8ghj7NMI5xQAhaAOc/zylVLHtplYo9RcW0GhfWIyWnP8PqTk12KBvRAE5q7
         JBpA==
X-Received: by 10.66.244.109 with SMTP id xf13mr1234811pac.28.1401295792681;
        Wed, 28 May 2014 09:49:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ie9sm91127206pad.29.2014.05.28.09.49.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 09:49:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWnvo-oLd80Kgd1qnqUSSSrwNfcq_wHEjLRCa0Jr4XCjwA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250293>

Ronnie Sahlberg wrote:

> I reworded the commit message.

Thanks much.  Looks good.
