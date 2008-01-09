From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STG PATCH] add a --index option to refresh which takes the contents of the index as the new commit
Date: Wed, 9 Jan 2008 08:23:58 +0100
Message-ID: <20080109072358.GB28839@diana.vm.bytemark.co.uk>
References: <200712302003.33478.kumbayo84@arcor.de> <200801022039.27611.kumbayo84@arcor.de> <20080107105612.GA20981@diana.vm.bytemark.co.uk> <200801082142.47060.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:43:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWX2-0001aV-Cs
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbYAIInA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2008 03:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbYAIInA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:43:00 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3027 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbYAIIm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:42:59 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JCVI6-0007Xp-00; Wed, 09 Jan 2008 07:23:58 +0000
Content-Disposition: inline
In-Reply-To: <200801082142.47060.kumbayo84@arcor.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69968>

On 2008-01-08 21:42:46 +0100, Peter Oberndorfer wrote:

> On Montag 07 Januar 2008, Karl Hasselstr=F6m wrote:
>
> > So the use_index parameter to refresh_patch is actually not
> > necessary? In that case I'd rather you didn't add it, since the
> > functions in stgit/stack.py have quite enough parameters already.
>
> In the beginning i was afraid it would be to obscure to call it this
> way with all parameters set to some specific values. But having more
> parameters does not make it better :-) Done

Thanks.

> Patch now comes with a Signed-off-by and a log message that explains
> how this feature could be used. It was tested with the testcase,
> used during development of this patch and on another repo, but still
> take care when using it :-)

I may be promising too much now, but hopefully I'll get to this
tonight.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
