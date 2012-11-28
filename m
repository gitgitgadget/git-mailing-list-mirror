From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 22:23:37 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121128032337.GB1669@thyrsus.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:24:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYFn-0005Kk-04
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab2K1DXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:23:47 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:58917
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab2K1DXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:23:47 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 903B640661; Tue, 27 Nov 2012 22:23:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121128011750.GA23498@sigill.intra.peff.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210687>

Jeff King <peff@peff.net>:
> But I really wonder if anybody actually cares about adding sub-second
> timestamp support, or if it is merely "because SVN has it".

There's actually one possible other reason to care.  1-second granularity 
isn't quite fine enough to guarantee that a (committer, timestamp)
pair is a unique key.  1 microsecond granularity would be.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
