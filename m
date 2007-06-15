From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT vs. guilt: What's the difference?
Date: Thu, 14 Jun 2007 20:05:42 -0700
Message-ID: <20070615030542.GA30110@diana.vm.bytemark.co.uk>
References: <4671B96A.1080202@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 05:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz28U-0002qS-7R
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 05:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbXFODFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 14 Jun 2007 23:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbXFODFt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 23:05:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3538 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbXFODFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 23:05:49 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hz286-0008Ap-00; Fri, 15 Jun 2007 04:05:42 +0100
Content-Disposition: inline
In-Reply-To: <4671B96A.1080202@midwinter.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50232>

On 2007-06-14 14:55:54 -0700, Steven Grimm wrote:

> I've asked this on IRC a couple times and nobody seemed to have a
> good answer, so: These two tools seem like they are solving the same
> general problem using similar approaches. They are both under active
> development. In what areas is each of them stronger than the other?
> Why would one choose to use one of them instead of the other?

I have never had a close look at guilt, but from what I remember it
stores patches as plain old plaintext patches (corrections to this
statement welcome). StGIT uses git's object database.

I doubt there's anything that one model can handle that the other
cannot; the question is whether the two _implementations_ are feature
equivalent or not. And I can't answer that, since I know too little
about guilt.

I'm guessing guilt's creator might be a bit more qualified to answer;
from what I recall, he looked at StGIT, but decided to build his own
tool because StGIT did not meet his requirements.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
