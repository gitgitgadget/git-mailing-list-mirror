From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] Let --decorate show HEAD position
Date: Mon, 12 Oct 2009 23:11:10 +0200
Message-ID: <200910122311.12106.trast@student.ethz.ch>
References: <200910122206.23044.trast@student.ethz.ch> <36861d16d0e21c662430882140893ad9a0b2fb25.1255379242.git.trast@student.ethz.ch> <7vk4z0e31e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	=?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDp-0002of-Hk
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179AbZJLVMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757390AbZJLVMf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:12:35 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:56535 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062AbZJLVMe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:12:34 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 23:11:47 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 23:11:49 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vk4z0e31e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130074>

Junio C Hamano wrote:
> 
> I see HEAD is given at the front in the sample output, which I think also
> makes sense.  Is it because it is pushed the last?  If so, the same commit
> at the tip of branch alpha and beta are decorated with beta and then
> alpha, I have to wonder...?

Indeed.  I wrote this off as a lucky coincidence coming from HEAD
sorting before any lowercase letters, but it's exactly as you say:

  commit a0f7579d38feb8c4d87282a6cecbc6778908f19f (test-b, test-a, next)
  Merge: 01287fd 548bc3a
  Author: Thomas Rast <trast@student.ethz.ch>
  [...]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
