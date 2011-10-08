From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/3] completion: unite --reuse-message and
	--reedit-message handling
Date: Sat, 8 Oct 2011 03:04:32 +0200
Message-ID: <20111008010432.GA11561@goldbirke>
References: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
	<7vd3e9yap7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Teemu Matilainen <teemu.matilainen@iki.fi>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 03:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCLQj-00021H-B5
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 03:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab1JHBEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 21:04:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54228 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab1JHBEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 21:04:39 -0400
Received: from localhost6.localdomain6 (p5B131159.dip0.t-ipconnect.de [91.19.17.89])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0McRue-1RU0kS2HXE-00IBOF; Sat, 08 Oct 2011 03:04:33 +0200
Content-Disposition: inline
In-Reply-To: <7vd3e9yap7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:w1PNb90Wi6GmxseeZ3dmsnT9UGG3y215dAy82ykV8Ys
 xZLElu9Ue3g7ShE8kLdViF9YKHLctsQxocLf+jZokHHEcItKxq
 Z8+ZgGYX9mNTq8Plz8x5WRkBof4TVAp5H0uObO4ri8fW3Yb8Tr
 wR3yJ4HziFPLMu0fW38tiCrFKncCPVBKjwl2oio78m1Hr9I14S
 9w8tHK/gX3RxxmT26cTPLBgBTWeHMFDLkJHLn4x/rs40o4BXWm
 EX0HtJ0z5yMO5BbXUtVPBNzDbvvuXDpRYURMymqoTVlb8wuiWI
 HsQiouD3CAkoTm51gFqsQOkURSSQN4g5IYRq4zATv27iLXy46i
 0A+LeKbiSY/mizlgEi2k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183130>

Hi,

On Thu, Oct 06, 2011 at 04:14:28PM -0700, Junio C Hamano wrote:
> All three patches make sense to me. Thanks.

This is a good cleanup/deduplication; there are a few places where
similar cleanup can be done.  Since this conflicted with one of my
more intrusive WIP branches, I figured it's better to clean up those
first, too.


Best,
G=E1bor
