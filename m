From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 10:37:22 -0700 (PDT)
Message-ID: <m3tzbhk94k.fsf@localhost.localdomain>
References: <20081010083720.GA32069@elte.hu>
	<alpine.LFD.2.00.0810101040200.3271@apollo>
	<48EF14FC.1000801@cn.fujitsu.com>
	<alpine.LFD.2.00.0810101046260.3271@apollo>
	<48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com>
	<20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com>
	<20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz>
	<20081012165954.GA2317@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Oct 12 19:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp4v7-0001EK-NB
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 19:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbYJLRh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 13:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbYJLRh0
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 13:37:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:42508 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbYJLRh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 13:37:26 -0400
Received: by ug-out-1314.google.com with SMTP id k3so331756ugf.37
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Eg6R1D0Ox0ePAirMA+DXNr7OAKiSbwS2NbQzI/ANqa4=;
        b=GD4S8g8ilTLM/bkeqFFGIp1zDIt5zCpj8HtSgaNNuxWUnuFGvoS9tCUC4Jvb8f90Z3
         od4qtR4vrWqPY7RdFRoVBdBTL6cSwOC5rOJ+kXDjlZLAqvbFf+STvDSVU2obj9FE7ZA+
         K/zKmjan+FBd3+lJP7v1myviesgMohc3JCDaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=IobAaeDkhigNQyVUeXHRySWoiaqh/EZYJwep6K5bVcf1NFZSe8LFaubDwy0PJ5taA+
         NGj7ErFtIrnbc6DIjn4c1YQP6w9onz38kY3Te47WaVllfVuV6AiwSnJtGtNiSWgJgb0E
         KyRz9T6JHDi7+wL/dEZrOTivC8HehmsNKNBmc=
Received: by 10.210.129.19 with SMTP id b19mr4080168ebd.9.1223833044024;
        Sun, 12 Oct 2008 10:37:24 -0700 (PDT)
Received: from localhost.localdomain (abxa211.neoplus.adsl.tpnet.pl [83.8.250.211])
        by mx.google.com with ESMTPS id 5sm8274736eyf.8.2008.10.12.10.37.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 10:37:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9CHbJBT028404;
	Sun, 12 Oct 2008 19:37:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9CHbFPq028400;
	Sun, 12 Oct 2008 19:37:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081012165954.GA2317@elte.hu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98038>

Ingo Molnar <mingo@elte.hu> writes:

> Soapbox: in fact it would be outright stupid to limit the kernel 
> source's availability artificially by not making HTTP a tier-one access 
> method.
> 
> Fighting against HTTP-only firewalls is like constantly pointing it out 
> to the popular press that they should say 'cracker' instead of 'hacker'. 
> It is pointless and only hurts the availability our own project.

Hopefully there should soon be here "smart" HTTP server (as for
example CGI script), which encapsulates git protocol, modified for the
fact that HTTP is stateless protocol, in HTTP.  It would unfortunately
require git installed on server.

It is WIP, but I'm not sure how far it is from completion.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
