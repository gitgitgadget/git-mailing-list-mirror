From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v4 3/4] Allow hiding renames of individual files
 involved in a directory rename.
Date: Mon, 4 Oct 2010 20:21:36 +0200
Message-ID: <20101004182136.GT4983@home.lan>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <1286138529-6780-4-git-send-email-ydirson@altern.org>
 <AANLkTi=S0AkNdajK5MM60HUxHPG1R=Tp_iL8S8Ds4P+j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:11:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pVu-0007po-TT
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab0JDSLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:11:45 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:49064 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756324Ab0JDSLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:11:44 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 9C650D48149;
	Mon,  4 Oct 2010 20:11:37 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2pfM-0002k7-5z; Mon, 04 Oct 2010 20:21:36 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi=S0AkNdajK5MM60HUxHPG1R=Tp_iL8S8Ds4P+j@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158083>

On Mon, Oct 04, 2010 at 01:06:13AM +0200, Sverre Rabbelier wrote:
> Heya,
> 
> On Sun, Oct 3, 2010 at 22:42, Yann Dirson <ydirson@altern.org> wrote:
> > This makes it much easier to a human reader to spot content changes
> > in a commit that also moves a whole subtree.
> 
> I'd like to use this by default (but only for regular 'git diff', 'git
> log', etc., not for 'git format-patch') if/when it gets merged, can
> has config option?

Sure - I was leaving that sort of beels and whistles for after the
core feature gets cold enough.
