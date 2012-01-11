From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Intriguing error with Git 1.6.3.1: Too many open files
Date: Wed, 11 Jan 2012 01:18:51 -0600
Message-ID: <20120111071851.GA28655@burratino>
References: <CALjyegUJ+ZY7g0Lpxqs=gvAyhtYW_a3SNWVybSG4EG3X=ROV9Q@mail.gmail.com>
 <20120111030931.GA12862@burratino>
 <CALjyegVzchN==DEsARD65jEmz0BkkbYMQRhG=ujNiGCBHuB4SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Soham Mehta <soham@box.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 08:14:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RksNr-0008GR-Ec
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 08:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab2AKHOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 02:14:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37932 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2AKHN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 02:13:59 -0500
Received: by iabz25 with SMTP id z25so685628iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 23:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Uy2UZb2HcslXr3nbh21knwJVYbofZtWI9JN2LnKfogk=;
        b=UO8qb4ZBIV7uQb0FG/u/9+AXCg0+sFvgvWSZJnwAMmFR0xpM/KeGxA0KoTQdM+CbMX
         IAGQkxVRZk8l9/4tmpmbsnzjXnS3UvBhgFq3Pg7vOPzqzxm/BJPTk8+eBl5+MQKdm8xr
         QMwxWqrWK1wkuhHe/ByNSzdGLt6DdeJ72EIcY=
Received: by 10.42.168.135 with SMTP id w7mr25201321icy.9.1326266039061;
        Tue, 10 Jan 2012 23:13:59 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q30sm2159737ibc.1.2012.01.10.23.13.58
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 23:13:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALjyegVzchN==DEsARD65jEmz0BkkbYMQRhG=ujNiGCBHuB4SQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188338>

Soham Mehta wrote:

> I haven't played with versions yet.

For almost all purposes, the latest stable version should work fine
(v1.7.8.3 at the moment).  The people on this list tend to be very
keen to hear about cases where that's not true --- if people are stuck
using old versions because of regressions, that means we're failing.

> Are you alluding that #2 on this
> list may have addressed it?
> https://raw.github.com/gitster/git/master/Documentation/RelNotes/1.7.4.2.txt

Not exactly.  I was thinking of commit c7934306 (Limit file
descriptors used by packs, 2011-02-28).

In git time, 1.6.3.1 is ancient history.  There are many little fixes
and performance improvements you are missing out on.

Just my two cents,
Jonathan
