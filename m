From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] commit: More generous accepting of RFC-2822 footer lines.
Date: Tue, 3 Nov 2009 17:59:51 +0100
Message-ID: <20091103165951.GA2241@neumann>
References: <20091027234520.GA11433@quaoar.codeaurora.org>
	<20091028171344.GA22290@quaoar.codeaurora.org>
	<7vd447o0jp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 18:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Mjk-0002iU-4m
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 18:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbZKCQ7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 11:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbZKCQ7u
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 11:59:50 -0500
Received: from francis.fzi.de ([141.21.7.5]:5467 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750972AbZKCQ7t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 11:59:49 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Nov 2009 17:59:51 +0100
Content-Disposition: inline
In-Reply-To: <7vd447o0jp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 03 Nov 2009 16:59:51.0890 (UTC) FILETIME=[0F442B20:01CA5CA7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131979>

Hi,

> > From: David Brown <davidb@quicinc.com>
> >
> > 'git commit -s' will insert a blank line before the Signed-off-by
> > line at the end of the message, unless this last line is a
> > Signed-off-by line itself.  Common use has other trailing lines
> > at the ends of commit text, in the style of RFC2822 headers.
> >
> > Be more generous in considering lines to be part of this footer.
> > If the last paragraph of the commit message reasonably resembles
> > RFC-2822 formatted lines, don't insert that blank line.

I think this patch was a bit too generous.  If I make a one-line
commit message with git commit -s -m which has a colon in it, e.g.
'subsystem: what I did', then this patch removes the empty line
between the subject and the SOB line.


Best,
G=E1bor
