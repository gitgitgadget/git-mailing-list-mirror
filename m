From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Mon, 15 Jun 2009 06:16:05 -0700
Message-ID: <4A364995.2010703@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	 <c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com>	 <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>	 <200906110602.54861.chriscool@tuxfamily.org>	 <4A308B5D.2010704@zytor.com> <4A309083.9090907@zytor.com>	 <c07716ae0906120456j1a14af52n47c3a3542201aaf@mail.gmail.com>	 <4A33F7E4.4020201@zytor.com> <c07716ae0906150059m7f9706x6f9022afde15d3b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 15:17:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGC4R-0003yH-Ik
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 15:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbZFONRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 09:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbZFONRN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 09:17:13 -0400
Received: from terminus.zytor.com ([198.137.202.10]:50970 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZFONRM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 09:17:12 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5FDGBxv030107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2009 06:16:12 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id n5FDGAQN019164;
	Mon, 15 Jun 2009 06:16:10 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n5FDG5vL004717;
	Mon, 15 Jun 2009 06:16:06 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <c07716ae0906150059m7f9706x6f9022afde15d3b0@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/9467/Mon Jun 15 01:11:58 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121606>

Christian Couder wrote:
> Yes, but I feared that there could be rounding related differences
> between platforms.

Doesn't matter for this application.  Really.  Anything you're going to
do yourself will be much worse.  Realistically, you might have a
difference in the 53rd bit.

> By the way, could you explain why power 1.5 is better than 2? It would
> be much simpler if we could avoid square rooting anything in the first
> place.

It is the power function that most closely creates a distribution which
matches the value curve (rounded to a small fraction.)

> I don't think this is a real problem for this application. In fact I
> think it's already quite overkill and there are better things to do,
> like looking for a commit on a different branch among the first ones
> in the list, if we want to improve the current behavior.
> 
> So unless there is a real flaw, I am going to work on something else.

Makes sense.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
