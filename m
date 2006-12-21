From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Re: [BUG] daemon.c blows up on OSX
Date: Thu, 21 Dec 2006 03:04:11 +0100
Message-ID: <f3d7535d0612201804r4b80545esd59b374ce8456457@mail.gmail.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	 <86vek6z0k2.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	 <86irg6yzt1.fsf_-_@blue.stonehenge.com>
	 <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	 <86ejquyz4v.fsf@blue.stonehenge.com>
	 <86ac1iyyla.fsf@blue.stonehenge.com>
	 <7v1wmu6ugr.fsf@assigned-by-dhcp.cox.net>
	 <86r6uuxi8o.fsf@blue.stonehenge.com>
	 <86irg6xht8.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 03:04:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxDIC-0005Co-Qg
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 03:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbWLUCEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 21:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWLUCEN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 21:04:13 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:19168 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161137AbWLUCEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 21:04:12 -0500
Received: by wr-out-0506.google.com with SMTP id i11so1048199wra
        for <git@vger.kernel.org>; Wed, 20 Dec 2006 18:04:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AiKBcvGth7t8+xsNpdbilE31Ryyk0bnfvfAS2icY62d203jcXGW13xP2LMF+01wlGM9Az0wEplGdmjeGzdN1nYSzPOC75361BhCZVJ3B7xJhkn8NUweFCALZxcirakd7Qf6BJACdge21b9VJZyv9jTdH7HoOEn0kf4HdxNukkPU=
Received: by 10.90.103.2 with SMTP id a2mr8165387agc.1166666651813;
        Wed, 20 Dec 2006 18:04:11 -0800 (PST)
Received: by 10.90.94.16 with HTTP; Wed, 20 Dec 2006 18:04:11 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <86irg6xht8.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35009>

Hi,

20 Dec 2006 15:34:43 -0800, Randal L. Schwartz <merlyn@stonehenge.com>:
>
> Unfortunately, just deleting the two _XOPEN_SOURCE entries in
> git-compat-util.h doesn't do it, even for OSX.  So something more convoluted
> here is going on.

Hm, very strange - for me the patch mentioned here works fine. (Mac OS
X 10.4.8 on an Intel Mac)

bye

dreamind

-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
