From: Ted Felix <ted@tedfelix.com>
Subject: Re: [PATCH 2/2] rebase: omit patch-identical commits with --fork-point
Date: Tue, 15 Jul 2014 15:48:39 -0400
Message-ID: <53C58597.9040509@tedfelix.com>
References: <20140707211456.GA2322@serenity.lan> <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405451643.git.john@keeping.me.uk> <01d69c566e04256fb0321ab9685d1f05a80cb41d.1405451643.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 21:48:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X78iV-0007lx-F2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933515AbaGOTso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:48:44 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:51327
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933276AbaGOTsl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2014 15:48:41 -0400
Received: from omta16.westchester.pa.mail.comcast.net ([76.96.62.88])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id SiV61o0031uE5Es5EjoggG; Tue, 15 Jul 2014 19:48:40 +0000
Received: from [192.168.1.105] ([76.100.236.26])
	by omta16.westchester.pa.mail.comcast.net with comcast
	id Sjof1o00E0arC9o3cjofRs; Tue, 15 Jul 2014 19:48:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <01d69c566e04256fb0321ab9685d1f05a80cb41d.1405451643.git.john@keeping.me.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1405453720;
	bh=5J7Xdh7dGEa/2TrG2AWrN3hSgbDsGPNsHyi8gIweuzY=;
	h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
	 Content-Type;
	b=obzc5213seuS/rLfgvV+A+3CJbQc+RPqL+z5uP7SvHxFwoIIZ5OarVGquBckPeVw4
	 8qeAtHhZfwoZY1YTDGgF7LvsjC/+Cnd0yRTh9KlqS0GnlnQymZ+ry6LuZLrhLEeBEG
	 EoZk9eqfW1jV3Z0/gXiPRfYLNXmp1EOdnGHHmsgp2c9IiBykvGe9/GbBT2RJ/Pdpy+
	 +7owMgXzHNw00uqR+FappglykZql76HQa+3c74L0yiTTkGIVw5RVoL7GBic8CbCZxw
	 feWeuI2P4GG/mQ2z7mhqyFvrHMqAJj4HOU7DljBZdrDKD9P5yFWqBuFYW1CuuKFOsT
	 IVLRgOhWGGTbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253595>

   Thanks, John.  My test script is working fine for me now with these 
patches.
