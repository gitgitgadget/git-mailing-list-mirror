From: David Kastrup <dak@gnu.org>
Subject: Re: a475e8095aeb898c1ca60673b82df97d2300cc95 broken for docs
Date: Wed, 22 Aug 2007 07:09:16 +0200
Message-ID: <857inom9z7.fsf@lola.goethe.zz>
References: <86odh0ojx4.fsf@blue.stonehenge.com>
	<7vsl6coahd.fsf@gitster.siamese.dyndns.org>
	<86hcmso9ga.fsf@blue.stonehenge.com>
	<7v7inoo38o.fsf@gitster.siamese.dyndns.org>
	<20070822014140.GK27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INyEv-0007pz-Is
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbXHVV7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764527AbXHVV7o
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:59:44 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:46211 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764517AbXHVV7m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 17:59:42 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id B7C8117F655;
	Wed, 22 Aug 2007 23:59:40 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id A960F28EBD3;
	Wed, 22 Aug 2007 23:59:40 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-060-116.pools.arcor-ip.net [84.61.60.116])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 56165BBA25;
	Wed, 22 Aug 2007 23:59:34 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AD54A1C298A2; Wed, 22 Aug 2007 07:09:16 +0200 (CEST)
In-Reply-To: <20070822014140.GK27913@spearce.org> (Shawn O. Pearce's message of "Tue\, 21 Aug 2007 21\:41\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4032/Wed Aug 22 22:15:27 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56428>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> 
>> >>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
>> >
>> > Junio> I think we've seen it reported that docbook-xsl 1.72 and/or 1.73
>> > Junio> are broken.  Is your debug log from either of these versions?
>> >
>> > 1.71
>> 
>> Interesting.  I use 1.71 here too but it does not break.
>> 
>> I wonder what the differences are between our environments
>> (don't answer that you use OSX and I use Debian and FC -- that
>> much I already know).
>
> It broke at day-job on Cygwin today.  I don't know what version
> of docbook-xsl I'm using there.  But its fine on my OSX system.
> I had planned on debugging it at home tonight, but I can't reproduce
> it here.  Cute.  I will look at it again tomorrow and see if I can
> debug the issue.
>
> I'm pretty sure it was my recent edit to git-rev-list.txt; its
> one of the only commits that has impacted that manual page since
> the last time I had built that manual on Cygwin.  And no, nothing
> else (e.g. docbook, asciidoc, xmlto) has changed since the last
> successful build.

Maybe a line end character issue?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
