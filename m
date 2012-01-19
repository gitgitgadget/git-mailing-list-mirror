From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: diff --minimal as default?
Date: Thu, 19 Jan 2012 15:22:04 +0100
Message-ID: <8762g7u60j.fsf@thomas.inf.ethz.ch>
References: <CAA5Ydx_ZqnaWRK3cEvMkULcrGx8B1MUyi2-Ca8eSBmbDg==fDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 15:22:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnssX-00087y-HA
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 15:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab2ASOWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 09:22:09 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:13894 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab2ASOWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 09:22:07 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 15:22:02 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 15:22:05 +0100
In-Reply-To: <CAA5Ydx_ZqnaWRK3cEvMkULcrGx8B1MUyi2-Ca8eSBmbDg==fDQ@mail.gmail.com>
	(Victor Engmark's message of "Thu, 19 Jan 2012 14:41:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188813>

Victor Engmark <victor.engmark@gmail.com> writes:

> Git v1.7.8 supports `diff --minimal`. I've got cycles to spare and
> usually small files - Is there (or will there be) a configuration
> option to set this as the default? If not I'll just use an alias, but
> there should still be an inverse option to be able to override it in
> special cases.

AFAIK no config option is planned; you could make a patch :-)

But there's --no-minimal, following the usual pattern for boolean
options.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
