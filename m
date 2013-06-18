From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Exact format of tree objets
Date: Tue, 18 Jun 2013 19:47:04 +0200
Message-ID: <87bo73b9bb.fsf@linux-k42r.v.cablecom.net>
References: <CABx5MBRAYmO39BnMqnHZhUOwQf-7yeRuD=m7-P2xXdhkp6aWpA@mail.gmail.com>
	<20130611182649.GA24704@LK-Perkele-VII>
	<CABx5MBTtvyZT+TUj6iibFngbMnGoDvFT2wXM6oDACtuJ46kR7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:47:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uozzv-0006HK-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161Ab3FRRrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:47:11 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:44313 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933074Ab3FRRrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:47:09 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 19:47:05 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.55.184.157) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 18 Jun 2013 19:47:07 +0200
In-Reply-To: <CABx5MBTtvyZT+TUj6iibFngbMnGoDvFT2wXM6oDACtuJ46kR7Q@mail.gmail.com>
	(Chico Sokol's message of "Tue, 18 Jun 2013 12:15:52 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228288>

Chico Sokol <chico.sokol@gmail.com> writes:

> What is the encoding of the filename?

Git just considers filename a bunch of bytes that form a posix filename
(i.e., may not contain '/' and '\0').  So depending on your point of
view, it's either "no encoding" or "whatever you put into it".

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
