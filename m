From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to rebase when some commit hashes are in some commit
 messages
Date: Thu, 15 Oct 2015 11:41:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1510151134250.31610@s15462909.onlinehome-server.info>
References: <561C1132.3090606@orange.fr><vpqsi5fx2gr.fsf@grenoble-inp.fr><561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com> <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <561F597B.8090102@orange.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Philip Oakley <philipoakley@iee.org>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
X-From: git-owner@vger.kernel.org Thu Oct 15 11:42:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmf3M-0007Fo-2z
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 11:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbbJOJmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 05:42:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:59830 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbbJOJmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 05:42:21 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MYfre-1a7zWJ1HXu-00VSDR;
 Thu, 15 Oct 2015 11:41:49 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <561F597B.8090102@orange.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ByE3G6uBiF8GXBIS4r/LzS8qxJbSRBH8likKCrJt/MPPa6jn/TV
 /0sLW3c38yvylmQ+xAmpqc+JYnR/pXfbcDh5SAsC3ENFKZBSMX6Y+EhI3tOUfnmdzeGPQQe
 Q5XFBlcnlVYgyBM5u+RyVy8+0TVM6grOioolXh+LTLk/Qh3c597svHAZl76MM7UWh6JQR95
 sewrZem+X/oPLtL+CgWIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kZ09Zuq6chc=:pG5NRmlTzHktCD+F4syENf
 C5hOCmPue0UKX1cN0U4Yb1wKB2znFwHRAYdciRdeGTmVXqBOWJrngX+aJlwUjl/GK/iGjZEF6
 JX+72jxmk5OP/fS2LtKxPha2NC+h+1axwKDgZxqQUSSc7bPLpCDc0bov+wJvxS0AK7M64uy5q
 CQYbytjJ11m24ofIZybvaR8UUU1EznaJJj1jcD45Kl927lzLi8/rDGZ6xhbrNrm2DzAEkONwl
 8tCC1cBXhT0lQ8Uf538pvDLxx/HWDVaZ95KhLX6s21+lvFujzKSv96pZGb7W/GPuLCPSwndVc
 LPofIfLXQDjXF1gcFA7agxQHoUn/kCJvxkLC2pb/mFsWF4p7lmoFdvvdZ9FifkWiCYyyyEFiT
 5lUAy/ptDgZnEzbRBBqVnumSVoAVwzb+qtZp7ocJfMvAk22pycSF1VBVsY0AJDXQ3fcwH0mAF
 fkjqAM3lA2kppFuG5G7rnN+khQVpohlwp9Ie3oWL5jhie4W9V3K+Qq4MiGsTtwxN6tgxPh4i/
 3Pcxgfa42s5J84VImHOg23FJ27UCKhx8A3kZoZJD5vslLlrG6drbedVei5cLdUM1eNXGv4IQg
 XsMFtAzpWhyMxq+s6jRFXLDK3Od/+7Bz0OwCgR1Td7AR1coULtDj/75Nn2o2+4WfmUeYPQQzv
 v+cGMM5EWFVeYaauk0IDBPdCscDZih5g5xWmcrDTGzqfJpHsPTgcD1SXkuuvvdFgsJqdhKEft
 E2xX9fYzk38bTU7ZZwYNZfwYDVIVipXrlWl2Hlx0mB7zbSdiF66AvNd2mt0Dx7D0KAeCPdPd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279656>

Hi Francois-Xavier,

On Thu, 15 Oct 2015, Francois-Xavier Le Bail wrote:

> On 13/10/2015 15:29, Philip Oakley wrote:
>
> > Thus the only sha1 numbers that could be used are those that are
> > within the (possibly implied) instruction sheet (which will list the
> > current sha1s that will be converted by rebase to new sha1's).
> 
> Yes.

So what happens for commits that are in the pick list but then end up not
being rewritten at all, e.g. when a patch has been applied upstream (and
the --cherry logic did not detect that) and then you end up with a "No
changes to commit"? And what if a patch ends up in merge conflicts and the
user just skips it? And what if the referenced commit is to be picked
*afterwards* due to the commits being reordered?

It would appear that the strategy you propose is still too ill-defined to
make for a robust feature.

Ciao,
Johannes

P.S.: The recommended way to refer to a commit is not only using the SHA-1
but also mentioning the one-line, and even the date. That way, even
rebased commits can found most of the time. This is not fool-proof, by
far, of course, but still better than trying to rewrite a SHA-1 and
failing.
