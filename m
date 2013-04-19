From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Git crash in Ubuntu 12.04
Date: Fri, 19 Apr 2013 09:53:29 +0200
Message-ID: <87zjwvt0qu.fsf@linux-k42r.v.cablecom.net>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
	<87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
	<CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
	<20130411170659.a35d2c581cf34ade13448bfa@domain007.com>
	<CAJiNi_Gju2aJkVJJmoxnEAubfPvjaVhVF6DisaLn5kUJ3YRD=w@mail.gmail.com>
	<20130412180525.aa5b8eacd691a427244d6ab5@domain007.com>
	<CAJiNi_GQZf8BRkTR8+j6YjdcqUH1J1NATSrNUjZ=65V+ip6okQ@mail.gmail.com>
	<CACsJy8AfVjhsBtfwJomRmoYsA3EMPja--y5Twq=T7-bCUQRU-w@mail.gmail.com>
	<CAJiNi_FBzz2Tqp_P8BB=X7UnAaHiNH8s0FyzW4K9Xp6WZijECw@mail.gmail.com>
	<CAJiNi_HA5bNO8gMHkts_e+dWG26n=S7MRF5wc_L+v=rbnM91oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git <git@vger.kernel.org>
To: Sivaram Kannan <siva.devel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 09:53:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT68Y-00044c-5I
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 09:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204Ab3DSHxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 03:53:34 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57022 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281Ab3DSHxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 03:53:33 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 19 Apr
 2013 09:53:20 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 19 Apr 2013 09:53:30 +0200
In-Reply-To: <CAJiNi_HA5bNO8gMHkts_e+dWG26n=S7MRF5wc_L+v=rbnM91oQ@mail.gmail.com>
	(Sivaram Kannan's message of "Thu, 18 Apr 2013 20:46:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221751>

Sivaram Kannan <siva.devel@gmail.com> writes:

> Hi,
>
> The git crashed during one of the commits by a developer I think, the
> remote is not even showing the working branch. The local branch of is
> all right, but the remote repo is corrupted and could not git fsck
> also. Is restoring the last night's backup is my only option??

By commit, do you mean push?  I.e., something crashed while a push was
going on?

The recovery strategy depends a lot on how valuable/recoverable the work
that happened since the last backup was, but restoring from backup,
running 'git fsck' on all involved repos (including devs' workstations!)
and then having the devs re-push what they had locally seems like a good
strategy to me.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
