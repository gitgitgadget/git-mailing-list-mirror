From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 09 Jun 2009 11:42:37 -0700
Message-ID: <4A2EAD1D.7010201@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	<7vskidcf9s.fsf@alter.siamese.dyndns.org>	<200906070932.36913.chriscool@tuxfamily.org>	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>	<4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>	<c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>	<c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>	<4A2E7EEC.2050807@zytor.com> <7vljo1mf09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME6OF-0005C0-QG
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbZFIStL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbZFIStK
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:49:10 -0400
Received: from terminus.zytor.com ([198.137.202.10]:54531 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbZFIStJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 14:49:09 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n59Igbcj021148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 11:42:38 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vljo1mf09.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.94.2/9445/Tue Jun  9 07:42:26 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121204>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> My main objection to the "skip in goodness space" is exactly the same as
>> Junio's... it doesn't really buy you what it claims to sell.
> 
> It is no worse than the original "pick the next best in goodness space";
> neither try to avoid the ones close to untestable ones.
> 

Well, it's certainly better than "next best in goodness space", which is
provably pessimal in many common cases.

> So as long as it does not claim "we intelligently try to skip away from
> untestable ones", I am actually Ok with Christian's patch.  It might do
> worse than the random walk in pathological cases, but I suspect not by a
> big margin.

	-hpa
