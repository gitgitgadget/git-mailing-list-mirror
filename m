From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git bisect problems/ideas
Date: Fri, 21 Jan 2011 23:04:35 +0100
Message-ID: <201101212304.36741.j6t@kdbg.org>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com> <0253BAE3-90F7-492C-ADF5-8B16DFFA1E44@gmail.com> <AANLkTikG6Ft3Y922Aaakf28cnYs26PcRHoq9GSNj04mu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Aaron S. Meurer" <asmeurer@gmail.com>, git@vger.kernel.org,
	SZEDER =?iso-8859-1?q?G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 23:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgP66-0002ek-K6
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 23:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab1AUWEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 17:04:41 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:27644 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754145Ab1AUWEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 17:04:40 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1F873CDF87;
	Fri, 21 Jan 2011 23:04:35 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 09AF419F5F0;
	Fri, 21 Jan 2011 23:04:37 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTikG6Ft3Y922Aaakf28cnYs26PcRHoq9GSNj04mu@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165397>

On Freitag, 21. Januar 2011, Christian Couder wrote:
> On Wed, Jan 19, 2011 at 8:44 PM, Aaron S. Meurer <asmeurer@gmail.com> wrote:
> > If no, I think --reverse is actually a suitable fix.
>
> Yeah, but I think that what Dscho started was probably better. The
> problem is just that it is not so simple to implement and no one yet
> has been interested enough or took enough time to finish it.

Let me throw in an idea:

Add two new sub-commands:

* 'git bisect regression': this is a synonym for 'git bisect start'.

* 'git bisect improvement': this also starts a bisection, but subsequently the 
operation of 'git bisect good' and 'git bisect bad' is reversed.

-- Hannes
