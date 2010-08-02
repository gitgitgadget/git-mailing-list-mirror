From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC v2] Documentation: flesh out 
 =?utf-8?q?=E2=80=9Cgit_pull=E2=80=9D?= description
Date: Mon, 2 Aug 2010 14:34:13 +0200
Message-ID: <201008021434.13748.trast@student.ethz.ch>
References: <20100801025439.GA9592@burratino> <7vbp9lprcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Geoff Russell <geoffrey.russell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 14:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfuDl-0000yd-IP
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 14:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690Ab0HBMeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 08:34:16 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:54494 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab0HBMeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 08:34:15 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 2 Aug
 2010 14:34:14 +0200
Received: from thomas.site (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 2 Aug
 2010 14:34:14 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <7vbp9lprcs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152407>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Junio: ideally for this to work, git-pull.html would need to get the
> > same special treatment as git.html gets.  Does that seem doable?  Is
> > Meta/dodoc.sh still the script to do it?
> 
> I am a bit reluctant to see stalenotes[] being abused; that ugly hack is
> in effect _only_ while k.org documentation is being built to hang the "You
> are reading the latest dev version, newer than anything released" sign on
> the front door.
> 
> People with older git have documentation shipped with their versions, no?

The problem is that google invariably turns up the 'master' docs at
k.org when you look for a git commmand (and that we point people to
them all the time on #git).  Hence I suggested not outright removing
this safety warning from the docs that even people running 1.5.x will
read.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
