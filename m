From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Teach "git apply" to prepend a prefix with	"--root=<root>"
Date: Tue, 01 Jul 2008 13:27:43 -0700
Message-ID: <486A933F.9090001@zytor.com>
References: <alpine.DEB.1.00.0807010043440.9925@racer>	 <7vvdzqnemk.fsf@gitster.siamese.dyndns.org> <486A55B0.9050404@zytor.com>	 <alpine.LSU.1.00.0807011835090.32725@wbgn129.biozentrum.uni-wuerzburg.de> <1214935848.6619.1.camel@doriath>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 22:29:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDmTB-00078N-Ph
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 22:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335AbYGAU14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757707AbYGAU1z
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 16:27:55 -0400
Received: from terminus.zytor.com ([198.137.202.10]:32777 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbYGAU1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 16:27:54 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m61KRjws027329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 Jul 2008 13:27:46 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m61KRj7Y015817;
	Tue, 1 Jul 2008 13:27:45 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m61KRhoP016257;
	Tue, 1 Jul 2008 13:27:44 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <1214935848.6619.1.camel@doriath>
X-Virus-Scanned: ClamAV 0.92.1/7606/Tue Jul  1 10:33:19 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87065>

Raimund Bauer wrote:
> On Tue, 2008-07-01 at 18:36 +0200, Johannes Schindelin wrote:
>>> There is an analogous concept in patch(1), it's just implemented by 
>>> cd'ing to a subdirectory first.  ;)
>> Hey, "--cd=" is free!  And it would make explaining easier why -p is 
>> applied first.
> 
> patch uses -d or --directory

So it does.

	-hpa
