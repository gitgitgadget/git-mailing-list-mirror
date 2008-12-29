From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STGIT][PATCH] new: translate non word characters in patch name to '-'
Date: Mon, 29 Dec 2008 22:21:19 +0100
Message-ID: <20081229212119.GA3015@diana.vm.bytemark.co.uk>
References: <49562413.0437560a.287d.5133@mx.google.com> <20081228204938.GA13143@diana.vm.bytemark.co.uk> <154e089b0812291215h72dfe04aod080f665eb7f5592@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
X-From: git-owner@vger.kernel.org Mon Dec 29 22:23:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHPZq-0001jz-Gh
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 22:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbYL2VVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 16:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbYL2VVn
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 16:21:43 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1063 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbYL2VVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 16:21:43 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LHPY7-0000o7-00; Mon, 29 Dec 2008 21:21:19 +0000
Content-Disposition: inline
In-Reply-To: <154e089b0812291215h72dfe04aod080f665eb7f5592@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104127>

On 2008-12-29 21:15:44 +0100, Hannes Eder wrote:

> What about instead of 'fail with an informative message', just issue
> a warning that the name has been mangled. I use pathnames in patch
> names frequently, so this would be very handy.

Hmm, I'm still skeptical. Programs that try to be too clever all too
often end up just being annoying and unpredictable.

> I guess some with with more python skills needs to clean that up,
> this is the first stuff I do in python ;).

The code looks OK -- but as I said, I don't agree with what it's
trying to do.

There's a small inconsistency: you fail if the name contains "..", but
correct single bad characters.

And as I recall, stgit.namelength is about the automatically generated
patch names -- there's no limit for the names provided by the user.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
