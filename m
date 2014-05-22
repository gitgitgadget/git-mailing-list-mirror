From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v8 0/2] format-patch --signature-file <file>
Date: Thu, 22 May 2014 12:41:19 -0700
Message-ID: <20140522194119.GA20201@hudson.localdomain>
References: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
 <20140522142332.GA15095@hudson.localdomain>
 <xmqqy4xtmyeg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 21:41:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnYrp-0002Bt-Ae
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbaEVTlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:41:25 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43563 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbaEVTlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:41:24 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so2956316pbb.39
        for <git@vger.kernel.org>; Thu, 22 May 2014 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VDMCBV0wlKnEAZDDHB7RW5VTNNpzi40UBFGt5R9w89g=;
        b=0yFSWWs263D1qtS6JXG3e0iT0WMpKmCnXcbJEwvY9YO3JwDJwkzN7yJvowh+RujEr0
         wL9sTg/ZiVoTTEGOsF7Aq4w4raTI8xJ+yGJ4VZvgAl8v4c7yKUDC7OBUjfw2gSY0wsEW
         EyLoQf8KpeOZoLsOqS4XpWC4Ow/UVuKvb/8BSQa+Vgya3ncuXOCfoAPmeFqFG8F3F2QC
         ii0harVTnDdNsEMXflyYhT3hpUd7icmVV7h4HqwcQ7y0AOFYtuuo76tqmi3Wu96EvRqx
         XH4HQ32OFcBcyH7a2ateISpw4+Gp/Jx9SHgdrvRjH0NlJcebYi88JncZ4ybcyuzOX4F0
         5D6g==
X-Received: by 10.68.203.132 with SMTP id kq4mr31972883pbc.12.1400787684129;
        Thu, 22 May 2014 12:41:24 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id py7sm916247pbb.78.2014.05.22.12.41.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 12:41:22 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Thu, 22 May 2014 12:41:19 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqy4xtmyeg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249940>

Junio,

On Thu, May 22, 2014 at 12:00:39PM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
> > I just notice that my patch is in 'pu'.
> > But it is version 7 instead of the improved version 8.
> 
> Yeah, I know.  In a distributed environment, multiple people work
> independently and a sequence of event can go like this:
> 
>  - I read v7, comment, and queue it only so that I won't forget;
>  - I attend to other topics;
>  - I start the day's integration cycle, merging topics to the
>    integration branches, maint, master, next and pu;
>  - You reroll v8 and post it;
>  - I may not notice v8, or I may notice v8 but think it is not
>    worth to discard the integration work so far only to replace
>    v7 with v8.
>  - The integration result is pushed out.
> 
> A reminder is very much appreciated, but on the other hand it is not
> something unusual.  It happens all the time, and I usually am aware
> of it ;-)
> 
> Thanks.

Thanks for explaining how this process works.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
