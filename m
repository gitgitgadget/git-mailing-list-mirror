From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Fri, 2 Mar 2012 00:25:24 -0600
Message-ID: <20120302062524.GI5248@burratino>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org>
 <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch>
 <7vmx80nt68.fsf@alter.siamese.dyndns.org>
 <4F504699.3070406@gmail.com>
 <20120302041924.GG5248@burratino>
 <4F505F8C.70802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 07:25:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Lvr-0008P2-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 07:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802Ab2CBGZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 01:25:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54533 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab2CBGZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 01:25:30 -0500
Received: by iagz16 with SMTP id z16so1881501iag.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 22:25:30 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.42.140.199 as permitted sender) client-ip=10.42.140.199;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.42.140.199 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.42.140.199])
        by 10.42.140.199 with SMTP id l7mr6022591icu.28.1330669530250 (num_hops = 1);
        Thu, 01 Mar 2012 22:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=F+dZeK++/qllj6qYdBnvDxoNYBEl/2s/rxUNC8djBpA=;
        b=Q0HMSpuygDS4J8QF74uhy0NmZPj6wIgWuFEuyem679YFGVBSWmoZRVjLhh/THzNhLd
         Z8Ce7wgb7ppxIiAiXSkZou/VrAofb7iXvIk9XieZCwUfwnxSXKeF4vFKwdIa72hfRy6y
         puYIqm4a7rw7Bf3vSijN7SUfVcTJ0t94WSmVdygEb4R0gRqZETzb8ctyWjhjdMRCLeyp
         bincC1I9p6xsxmokR+ii5Mb356Poljyl6aNvif4KswzVFS8h4ZaBJLrE9Ay2MX29w6qf
         xD5TyhREtSH39qTikxyKqIlOiJ/c4cYo3NasUNvimfGgXAhrCbPwlsOzLMbam4CcyuZx
         GR9Q==
Received: by 10.42.140.199 with SMTP id l7mr4932825icu.28.1330669530192;
        Thu, 01 Mar 2012 22:25:30 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id eo1sm666519igc.17.2012.03.01.22.25.29
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 22:25:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F505F8C.70802@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192006>

Neal Kreitzinger wrote:

> Please let me know what else is a "hard social problem".  I'm not a
> bug-tracker expert but I've used a few bug-tracking systems and
> worked plenty of bugs though never on an opensource project so maybe
> I'm not aware of the "hard social problems".

I was not alluding to bug ping-pong (which is a security or discipline
problem) but the task of reconciling independent good-faith updates
(which is a coordination problem).
