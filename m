From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 09 Jun 2009 08:11:35 -0700
Message-ID: <4A2E7BA7.8000901@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	<7vskidcf9s.fsf@alter.siamese.dyndns.org>	<200906070932.36913.chriscool@tuxfamily.org>	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>	<4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>	<c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com> <m3prdd4t6s.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 19:55:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME5XN-0000FL-4x
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 19:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106AbZFIRy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 13:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754907AbZFIRyz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 13:54:55 -0400
Received: from terminus.zytor.com ([198.137.202.10]:60017 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbZFIRyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 13:54:55 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n59FBcV0012395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 08:11:57 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id n59FBcxR016870;
	Tue, 9 Jun 2009 08:11:38 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n59FBZin001260;
	Tue, 9 Jun 2009 08:11:35 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <m3prdd4t6s.fsf@localhost.localdomain>
X-Virus-Scanned: ClamAV 0.94.2/9442/Tue Jun  9 05:14:26 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121196>

Jakub Narebski wrote:
> 
> By the way, I have asked question about best algorithm for "bisect skip"
> on StackOverflow[1], but didn't get (yet) any good responses...
> 
> [1]: http://stackoverflow.com/questions/959324/
> 

I don't think there is a "best" algorithm, but I concur with the poster
that said broken commits tend to cluster.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
