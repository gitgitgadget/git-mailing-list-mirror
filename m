From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 22:19:24 -0600
Message-ID: <20120302041924.GG5248@burratino>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org>
 <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch>
 <7vmx80nt68.fsf@alter.siamese.dyndns.org>
 <4F504699.3070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:20:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3JyO-0001fk-1r
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 05:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab2CBETb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 23:19:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43237 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab2CBETa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 23:19:30 -0500
Received: by iagz16 with SMTP id z16so1776211iag.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 20:19:30 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.50.186.198 as permitted sender) client-ip=10.50.186.198;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.50.186.198 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.50.186.198])
        by 10.50.186.198 with SMTP id fm6mr348805igc.40.1330661970387 (num_hops = 1);
        Thu, 01 Mar 2012 20:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=s5eIWilaL2l61CDiSDMsbuk6+Eq4HeG/DrUU8u3/56U=;
        b=fcvbFrMStdjuWTSvuIQMIl7amrXbXiHNQEOebDAYZsEKQxTR406BXRLIAH7dFhoXZd
         nU/DOcLZIHv+lxBmF6kcmwZhstRqivOi2HRBgIMxhE76HFBclW1edMdF59x+rvcM+s7y
         FoL6aIJY2MNkvVCE8rzc/LNA1B06mBACcOE1y8QOIVvplg2iSl7Qfj+sAudki5VsIZuQ
         ZnAEqns3aqseMByRPf55pmTzsivdZTdfIOiqFeNGx7GIHiwktHf2JKqVyoLxqeC0Fyul
         /cX+mn5IQs/jcFrIDs+wkUPvwMrthz8mLPGi2Sa/XxkIxU/Cl8cLyDQOvn9ogt2GVLal
         tVjQ==
Received: by 10.50.186.198 with SMTP id fm6mr290589igc.40.1330661970326;
        Thu, 01 Mar 2012 20:19:30 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id df2sm491564igb.10.2012.03.01.20.19.29
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 20:19:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F504699.3070406@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191998>

Neal Kreitzinger wrote:

> Why don't you just use git for your bug-tracking?
[...]
> I think git people in general would be enthusiastic about this

Not this git person. ;-)  I think there is a pretty major mismatch
between most VCSen's features and what a bugtracker needs.

That said, a good distributed bugtracker (which implies solving hard
social problems like "what to do if different contributors disagree on
severity" and simple technical problems like "how to present a
coherent conversation based on threads by people who might not have
been aware of each other") would be a very nice thing to see,
regardless of the choice of storage and network protocol used to back
it.

> git-err-done

Heh.

Thanks for some food for thought,
Jonathan
