From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 18:04:19 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121127230419.GA26080@thyrsus.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:04:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUCm-0005Pr-DX
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab2K0XEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:04:25 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:58150
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab2K0XEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:04:24 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 73E844065F; Tue, 27 Nov 2012 18:04:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210620>

Junio C Hamano <gitster@pobox.com>:
> fsck_ident() in fsck.c rejects anything but " [1-9][0-9]* " after
> the author and committer ident (i.e. the timestamp has to be
> integral number of seconds since the epoch, not before it, nor
> with fractional seconds).

Is this architecturally significant?  It sounds like another
implementation detail.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
