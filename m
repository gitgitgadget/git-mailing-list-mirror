From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Workflow question
Date: Wed, 26 Sep 2007 03:51:46 +0200
Message-ID: <20070926015146.GA25175@diana.vm.bytemark.co.uk>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se> <46F96493.8000607@gmail.com> <20070925201717.GB19549@segfault.peff.net> <46F97618.9010207@gmail.com> <20070926004734.GA22617@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russ Brown <pickscrape@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 03:52:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaM4V-0007Pg-95
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 03:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbXIZBwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2007 21:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXIZBwH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 21:52:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4905 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbXIZBwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 21:52:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IaM42-0006bc-00; Wed, 26 Sep 2007 02:51:46 +0100
Content-Disposition: inline
In-Reply-To: <20070926004734.GA22617@segfault.peff.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59207>

On 2007-09-25 20:47:34 -0400, Jeff King wrote:

> Personally, I think it pays to learn a little about what's going on
> under the hood, and then all of the commands Just Make Sense.
>
> There are several explanations floating around; this is a pretty
> concise one:
>
>   http://eagain.net/articles/git-for-computer-scientists/

I agree. Once you understand that history in git is just a DAG of
commits, and that "branches" are just named pointers into this DAG to
help the user remember where to attach new commits, everything starts
to Just Make Sense.

(And FWIW, that article was quite good as I recall.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
