From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Tue, 10 Feb 2009 08:07:40 +0100
Message-ID: <200902100807.40417.robin.rosenberg@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <7vwsc0uow1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 08:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWmkg-0002Iq-C5
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 08:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbZBJHHs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 02:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbZBJHHs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 02:07:48 -0500
Received: from mail.dewire.com ([83.140.172.130]:3781 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbZBJHHs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 02:07:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 48DD2147E89A;
	Tue, 10 Feb 2009 08:07:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TtKIC1bYRBR; Tue, 10 Feb 2009 08:07:41 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 8094F147E88D;
	Tue, 10 Feb 2009 08:07:41 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <7vwsc0uow1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109183>

m=E5ndag 09 februari 2009 07:04:46 skrev Junio C Hamano:
> What's troubling more is that this would seem to leave the result eve=
n
> more inconsistent if there are more than one packs that need to be
> replaced.

Why? We don't prune the old objects if we fail. The result might be a l=
ot
of redundancy, but nothing should be lost.

-- robin
