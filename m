From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Wed, 17 Jan 2007 18:07:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0701171804260.26185@reaper.quantumfyre.co.uk>
References: <17437.1168911089@lotus.CS.Berkeley.EDU> <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
 <200701171629.l0HGTCE3019292@laptop13.inf.utfsm.cl> <7vk5zlsglk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 19:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7FC1-0004Vq-Oy
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 19:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbXAQSHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 13:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXAQSHX
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 13:07:23 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:56746 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbXAQSHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 13:07:22 -0500
Received: (qmail 23876 invoked by uid 103); 17 Jan 2007 18:07:21 +0000
Received: from 192.168.0.16 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2459. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.16):. 
 Processed in 0.029887 secs); 17 Jan 2007 18:07:21 -0000
Received: from unknown (HELO reaper.quantumfyre.co.uk) (192.168.0.16)
  by neutron.datavampyre.co.uk with SMTP; 17 Jan 2007 18:07:20 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk5zlsglk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37022>

On Wed, 17 Jan 2007, Junio C Hamano wrote:

> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:
>
>> Junio C Hamano <junkio@cox.net> wrote:
>>> Jason Riedy <ejr@EECS.Berkeley.EDU> writes:
>>>> Not all echos know -n.  This was causing a test failure in
>>>> t5401-update-hooks.sh, but not t3800-mktag.sh for some reason.
>>>
>>> We have done this already so it might be too late to raise this
>>> question, but does everybody have printf?
>>
>> Here (Fedora rawhide) /usr/bin/printf is part of coreutils.
>
> I am reasonably sure people on Linux land would be fine
> regardless of distros, but thanks anyway.
>
> The problematic are less common ones, ranging from (not so less
> common) OSX, Solaris to (much less common) AIX that some people
> seem to run git on (or at least compile git for).

printf is a bash builtin ... not sure about other shells.

-- 
Julian

  ---
A lifetime isn't nearly long enough to figure out what it's all about.
