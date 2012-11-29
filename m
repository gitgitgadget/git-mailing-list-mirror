From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Thu, 29 Nov 2012 05:38:47 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121129103847.GA9264@thyrsus.com>
References: <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
 <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
 <CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
 <CABYiQpnEZECU5Vj5JzMimtw-CAJQz2d=3rii4gM6d37wCnO5AA@mail.gmail.com>
 <E4C993F4-B7A4-4CB6-A9EA-BFE98BE3A381@gmail.com>
 <7va9u0sx26.fsf@alter.siamese.dyndns.org>
 <CAMP44s3ShoR7iR5QLYn_u+u_nNGnS1jumpt+iseWYKx0PX9UEA@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Michalske <smichalske@gmail.com>,
	Thomas Berg <merlin66b@gmail.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 11:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te1WY-0003ll-Mh
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 11:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab2K2KjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 05:39:03 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:52039
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab2K2KjB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 05:39:01 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 8F4874065F; Thu, 29 Nov 2012 05:38:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3ShoR7iR5QLYn_u+u_nNGnS1jumpt+iseWYKx0PX9UEA@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210827>

Felipe Contreras <felipe.contreras@gmail.com>:
> On Thu, Nov 29, 2012 at 8:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Steven Michalske <smichalske@gmail.com> writes:
> >
> >> Would having arbitrary key value pairs be useful in the git data
> >> model?
> >
> > My answer to the question is that it is harmful to the data model,
> > but the benefit of going against the data model _may_ outweigh the
> > downside.  It is all relative.
> 
> If git doesn't provide the capability, people will keep using the
> commit message to store that extra information, which I would think is
> even more harmful. An standard 'commit-extra' note or something would
> help deal with that.

Agreed.  

My use case for a capability like this is one of the more common ones.
I want to be able to store a fossil commit-ID inherited from another
VCS outside the commit comment.  The absence of a key/value store forces
me into some annoying kludges.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
