From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 06 Feb 2012 09:51:56 +0100
Message-ID: <4F2F94AC.6010800@alum.mit.edu>
References: <4F24E287.3040302@alum.mit.edu> <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu> <7v39axc9gp.fsf@alter.siamese.dyndns.org> <7vaa55ar4v.fsf@alter.siamese.dyndns.org> <20120130215043.GB16149@sigill.intra.peff.net> <7vobtcbtqa.fsf@alter.siamese.dyndns.org> <20120206043012.GD29365@sigill.intra.peff.net> <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com> <20120206050637.GA4263@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuKJ2-0007hB-NG
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2BFIwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:52:07 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50224 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2BFIwG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:52:06 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q168pvaf023879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 Feb 2012 09:51:57 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <20120206050637.GA4263@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190050>

On 02/06/2012 06:06 AM, Jeff King wrote:
> I kind of agree that we shouldn't be unnecessarily restrictive. On the
> other hand, I am stretching to find the plausible reason that one would
> want to throw away the normal convention. Code aside, it simply
> introduces a slight communication barrier when talking with other git
> users, and for that reason should be something you don't do lightly. I
> don't recall seeing anybody complain seriously about it in the past six
> years of git's existence.

In the real-world situation when I noticed this bug, I wasn't trying to
use a nonstandard name for "master".  What I was doing is importing a
snapshot of some code from another non-git project onto a "vendor
branch", which I knew I would later want to merge into my own work
(which I planned to do on master).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
