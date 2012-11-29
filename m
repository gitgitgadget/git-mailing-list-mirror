From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Thu, 29 Nov 2012 01:16:50 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121129061650.GB25537@thyrsus.com>
References: <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
 <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
 <CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
 <CABYiQpnEZECU5Vj5JzMimtw-CAJQz2d=3rii4gM6d37wCnO5AA@mail.gmail.com>
 <E4C993F4-B7A4-4CB6-A9EA-BFE98BE3A381@gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Berg <merlin66b@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	git <git@vger.kernel.org>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 07:17:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdxQu-00017J-2I
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 07:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab2K2GQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 01:16:58 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:40062
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab2K2GQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 01:16:57 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id C7AD940661; Thu, 29 Nov 2012 01:16:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <E4C993F4-B7A4-4CB6-A9EA-BFE98BE3A381@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210810>

Steven Michalske <smichalske@gmail.com>:
> Would having arbitrary key value pairs be useful in the git data
> model?  We could have ones that affect the sha1 and others that are
> transparent.

My tools would have several uses for these.

bzr's implementation of import streams has a commit-propperties extension.
reposurgeon can read, display.. and manipulate these key/value pairs.
I do wish they were in core git.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
