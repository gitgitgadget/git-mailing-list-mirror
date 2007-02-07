From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-fast-import
Date: Wed, 07 Feb 2007 23:31:59 +0100
Organization: At home
Message-ID: <eqdk0t$jo5$2@sea.gmane.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com> <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org> <20070206164441.GA4949@spearce.org> <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl> <Pine.LNX.4.64.0702061832020.8424@woody.linux-foundation.org> <20070207055352.GB7138@spearce.org> <200702072218.l17MIeSD005420@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 23:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvNq-00006y-Md
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbXBGWfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422920AbXBGWfS
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:35:18 -0500
Received: from main.gmane.org ([80.91.229.2]:57177 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422794AbXBGWfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:35:17 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HEvNW-0006eo-3w
	for git@vger.kernel.org; Wed, 07 Feb 2007 23:35:02 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 23:35:02 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 23:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38983>

Horst H. von Brand wrote:
> Shawn O. Pearce <spearce@spearce.org> wrote:

>> Unlike the `raw` format above, the timezone/UTC offset information
>> contained in an RFC 2822 date string is used to adjust the date
>> value to UTC prior to storage.  Therefore it is important that
>> this information be as accurate as possible.
> 
> Say what? If I use the "raw" format with UTC offset, the offset is just
> ignored then?

It is saved, and used only when _displaying_ human readable date.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
