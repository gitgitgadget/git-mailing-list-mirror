From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect
 diff.ignoreSubmodules config variable
Date: Mon, 27 Dec 2010 17:43:57 -0500
Message-ID: <20101227224357.GA9947@foucault.redhat.com>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru>
 <1293240049-7744-3-git-send-email-zapped@mail.ru>
 <4D15E48A.9050805@web.de>
 <7vd3ooz6qd.fsf@alter.siamese.dyndns.org>
 <4D187511.3090104@web.de>
 <alpine.DEB.1.00.1012272256560.1794@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, Zapped <zapped@mail.ru>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 27 23:44:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXLng-0002Fq-6t
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 23:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab0L0WoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 17:44:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab0L0WoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 17:44:07 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oBRMi0Bv010312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 27 Dec 2010 17:44:00 -0500
Received: from foucault.redhat.com (vpn-8-120.rdu.redhat.com [10.11.8.120])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oBRMhvr5014338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Dec 2010 17:43:59 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1012272256560.1794@bonsai2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164228>

On Mon, Dec 27, 2010 at 11:06:38PM +0100, Johannes Schindelin wrote:
> Note: I do not think that the "plumbing" concept was not well-intended, 
> but I doubt that the concept holds up in the face of reality.
> 

I've always felt that plumbing commands existed to expose the C portion of git
to the bash portion of git. As the latter shrinks plumbing commands make less
sense (and offering those commands as a library makes more sense, which is
unfortunately close to impossible in the current git source).

--CJD
