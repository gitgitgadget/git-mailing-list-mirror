From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Summer of Code project ideas
Date: Thu, 17 Mar 2011 16:40:44 -0700 (PDT)
Message-ID: <m37hbx5ncw.fsf_-_@localhost.localdomain>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
	<20110303185918.GA18503@sigill.intra.peff.net>
	<AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
	<20110303203323.GA21102@sigill.intra.peff.net>
	<20110309174956.GA22683@sigill.intra.peff.net>
	<AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
	<20110309215841.GC4400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	"J.H." <warthog9@eaglescrag.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Mp2-0003P7-Jc
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 00:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab1CQXl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 19:41:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44981 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1CQXlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 19:41:25 -0400
Received: by wya21 with SMTP id 21so3328587wya.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=JvVlQmnjvpJt5iJSpvxHc8SDB/UvbSRD8uijJE3xKMA=;
        b=WL3fdJ0YZnBo4flvvlLHMKbogCGl0y/UQGaJGsgMj3h6DLeSOZTT6B2hS8A5zfaBGv
         lrosb4GtdasW1Zuq/orC3DOaY/Ze9A63pAONy1JzsFQUTC9hSvCaw9Dz5BBgoX/4SmJn
         fFeqX3BGntreB+Fq0okzbnsKTrB80v9Q8FWxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AZCi7k7ZLVihVwVHYRw8wUzTsYiMwpCyeUAnLVly/DPGROMr8zqmNNUAGk7jOApG3Y
         M57OR3g1dwTPL1FZJ9FpMRgBzHqVQXd7j7Cq+pplr1GqfdIqMTCe//BkPBH2olwcOwvN
         jEZW3AzPES0wqdSc7vGWv5ZcDK54+cUgvg+K4=
Received: by 10.216.152.170 with SMTP id d42mr455496wek.39.1300405245165;
        Thu, 17 Mar 2011 16:40:45 -0700 (PDT)
Received: from localhost.localdomain (aeho51.neoplus.adsl.tpnet.pl [79.186.196.51])
        by mx.google.com with ESMTPS id t72sm1331538wei.44.2011.03.17.16.40.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 16:40:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2HNdZKU014545;
	Fri, 18 Mar 2011 00:39:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2HNceTW014538;
	Fri, 18 Mar 2011 00:38:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110309215841.GC4400@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169286>

Jeff King <peff@peff.net> writes:

> https://git.wiki.kernel.org/index.php/SoC2011Ideas
> 
> If you have any ideas, please add them to the page!

A few project ideas I am not sure if they are feasible for GSoC:

* merging-in support for caching in gitweb, and benchmarking/profiling
  gitweb in high load situation

  J.H., you would probably want gitweb [output] caching to be merged-in
  sooner that the end of Google Summer of Code 2011, isn't it?

* embedding graphical diff and graphical merge tool in git-gui, e.g. as
  "git gui diff".  I think that we can use xxdiff; the license is 
  compatibile.

  Pat and Shawn, is it something worth doing?  Does it look like a good
  project for GSoC2011, or is it too small of a project for this?  Would
  we be able to find mentor for this idea?

* splitting gitk, common library (Tcl/Tk bindings) for gitk and git-gui

  Pat and Paul, do you think it is right scope, or is it too large project
  to put as an GSoC idea?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
