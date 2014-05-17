From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH] Documentation/technical/api-hashmap: Remove source
 highlighting
Date: Sat, 17 May 2014 08:22:19 -0700
Message-ID: <20140517152219.GA31912@hudson.localdomain>
References: <alpine.DEB.2.02.1405170707260.44324@all-night-tool.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat May 17 17:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlgRR-00040A-Ja
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbaEQPWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:22:25 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:38397 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085AbaEQPWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 11:22:25 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so3883837pbb.25
        for <git@vger.kernel.org>; Sat, 17 May 2014 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kQDZAHR4DIKENs4G2zEaRHhlaazzCwUWSGHwlZXVqQc=;
        b=kIHPyx486Fj6/w+X3/9gWlMN8XT5j81AlBfK8nzGS0dadZSocg5fIrFiTG01MR69d3
         1++hziI6HWYIxSlgtJ0VUaH0XS7Dr2rVt3Xe5ynWNBTZOsPA5Rt2BSS0uHAWLzosKmhI
         dr5XWLiG3+k4UrfG68kKlK1YI4IaREjCbQhAaQXcNpT4n8HHzt909XJJZaNJVrMvWZyT
         bD1lvCaUR8usi76DHsFgHKoIeh2g27pyYqJ/zu1oGJKiVHvD6Y+oaPBOpOi63n16voMn
         PsPUKGuRktDQcXOYT3kt4YeT8f0CBi6HQGZAGPdx0kMqcLZjDLa0qRhLAQFZL+UUXrLA
         CyRw==
X-Received: by 10.69.20.65 with SMTP id ha1mr29256256pbd.75.1400340144532;
        Sat, 17 May 2014 08:22:24 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id zq5sm20477183pbb.37.2014.05.17.08.22.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 17 May 2014 08:22:23 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 17 May 2014 08:22:19 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1405170707260.44324@all-night-tool.MIT.EDU>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249472>

On Sat, May 17, 2014 at 07:08:55AM -0400, Anders Kaseorg wrote:
> The highlighting was pretty, but unfortunately, the failure mode when
> source-highlight is not installed was that the entire code block
> disappears.  See https://bugs.debian.org/745591,
> https://bugs.launchpad.net/bugs/1316810.
> 

I agree that a broken document is an unacceptable failure mode.

But I do not understand why 'source-highlight' is not an install
requirement for 'git-doc'.  If I install 'source-highlight' on
my Debian machine the code looks great.

  apt-get install source-highlight

I also noticed that this seems to be the single place where source
code highlighting is used in Documentation/technical.
So it might be worthwhile to eliminate this dependency all together
as Anders patch does.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
