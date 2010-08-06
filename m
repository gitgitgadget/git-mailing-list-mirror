From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 11/18] Add tests for line history browser
Date: Fri, 6 Aug 2010 11:04:05 +0200
Message-ID: <201008061104.05828.trast@student.ethz.ch>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com> <201008052238.36892.trast@student.ethz.ch> <AANLkTinZPwtdon-qCWEx5L2c-LnfrjKdBA0pdGFmFQig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 11:04:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhIqh-0005Zt-F4
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 11:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760668Ab0HFJEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 05:04:13 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:36333 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760555Ab0HFJEL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 05:04:11 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 6 Aug
 2010 11:04:09 +0200
Received: from thomas.site (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 6 Aug
 2010 11:04:09 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <AANLkTinZPwtdon-qCWEx5L2c-LnfrjKdBA0pdGFmFQig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152773>

Bo Yang wrote:
> On Fri, Aug 6, 2010 at 4:38 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> > Bo Yang wrote:
> >> t4301: for simple linear history only
> >> t4302: for history containing merge
> >>
> >> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> >> ---
> >
> > Note that applying this with --whitespace=fix will make the tests
> > fail, as there are diffs contained which must preserve the SP TAB
> > sequence of context lines.
> 
> So, should I write the above into the commit message?

You can just write it after the ---, since it ceases to be relevant
after the email has been turned into a commit.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
