From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v6 2/3] completion: add new __gitcompadd helper
Date: Tue, 30 Oct 2012 23:58:39 +0100
Message-ID: <20121030225839.GO12052@goldbirke>
References: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
 <1350870342-22653-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTKme-0004Um-V3
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758504Ab2J3W7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:59:32 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54444 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758378Ab2J3W7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:59:31 -0400
Received: from localhost6.localdomain6 (p5B130686.dip0.t-ipconnect.de [91.19.6.134])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MLOoU-1TTsjN3dZ4-000fYN; Tue, 30 Oct 2012 23:58:40 +0100
Content-Disposition: inline
In-Reply-To: <1350870342-22653-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:92keVhPhnz0Y9XHzY2DTttGpKfOc6f802IYVPK4qyXB
 1meH/EFJygi+O8jjvYG0HCNwJDz73hVR7beJXpaX7Z6OTjvR9B
 EpyoaAlt4ZtCSyDSF2n14CfiztB+IQJSGC3oi7wtNRwfO+jkNw
 /GZ7jcStg/RFz6PkSkb/pX0FFaHmABQIaa3s12mcZzzXr7P3XU
 nqu2bKGDEoA9nNAXaPUi0/00khgFOoETbR3LjMZmfANagi+FfQ
 U8iGfMgiqLtEux/U63aLj9EWAqpWCNUFamj3BUK9Y2iMWqGCbW
 2VdhEm1k7vzdVy4B1i+7qoNAqiHtQfGuSXqszqhpYrzuDIqsfC
 B5g/G8MhX8jDkmoRY13KWZ/NpvVGkGJn8FOKlO0sW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208766>

On Mon, Oct 22, 2012 at 03:45:41AM +0200, Felipe Contreras wrote:
> The idea is to never touch the COMPREPLY variable directly.
> 
> This allows other completion systems override __gitcompadd, and do
> something different instead.
> 
> Also, this allows the simplification of the completion tests (separate
> patch).

This doesn't apply anymore, does it?  The mentioned simplification is
done in the other series.
