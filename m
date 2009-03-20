From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked
	branch
Date: Fri, 20 Mar 2009 18:08:14 +0100
Message-ID: <20090320170814.GB24968@atjola.homenet>
References: <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org> <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkiED-0002Sy-1f
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 18:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbZCTRIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 13:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757193AbZCTRIX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 13:08:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:35522 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757317AbZCTRIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 13:08:22 -0400
Received: (qmail invoked by alias); 20 Mar 2009 17:08:19 -0000
Received: from i59F553F0.versanet.de (EHLO atjola.local) [89.245.83.240]
  by mail.gmx.net (mp049) with SMTP; 20 Mar 2009 18:08:19 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19XyuZ0fqlXcmi5rh4hG6djdP7wiueX+7cSGQeQum
	SDY57z2OKzTX4r
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113980>

On 2009.03.20 17:17:01 +0100, Johannes Schindelin wrote:
> Even if a branch name can legally start with a '%' sign, we can use t=
he
> special character '%' here, as you can always specify the full ref:
> refs/heads/%my-branch (pointed out by doener on IRC).

Hm, I just recalled that "git checkout" doesn't "like" anything but the
shortname for a branch, with refs/heads/master or heads/master, you get
a detached HEAD. Though at least when reading the doc, that seems like =
a
bug to me. The man page says:

    When this parameter names a non-branch (but still a valid commit
    object), your HEAD becomes detached.

And of course refs/heads/master names a branch. Is it
expected/intended that checkout detaches HEAD anyway when given a full
ref name?

Bj=F6rn
