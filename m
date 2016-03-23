From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 12:22:21 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603231220560.4690@virtualbox>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com> <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com> <alpine.DEB.2.20.1603221552100.4690@virtualbox>
 <CAFZEwPNg8-X5dsBbMfg5ni1XpOVekRd13y-zgwYJpX0fCwg3Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:22:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigry-0008Cs-Ii
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 12:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbcCWLW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 07:22:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:64450 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbcCWLW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 07:22:26 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LtZfc-1ZkDyk44rU-010xWV; Wed, 23 Mar 2016 12:22:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPNg8-X5dsBbMfg5ni1XpOVekRd13y-zgwYJpX0fCwg3Ug@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:mjJCE+n7evPeP7BGXRsedfvidW4bUktr/knHA5ofVb/pxplcmyl
 +Q4iisW2NskKhHdFNUz09aCb3heprZygJOKmsiHjkTeU6a5ll0Gg/YntdhUhwfd0Oaqbn/v
 8s/0lGWFf1FqaN1vN4vEsj/Y78/o58JTbKDelNMskrLV5fRP9Nsr6G3ptSH+4sWTg5OPyrL
 eLyztP7PF5eKgRVnrje7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/K9LC5HRyfc=:AI/DkGjoeZvs0lxeM7tVUH
 /f/tpkO++1JsEx97ZSRmkYc4+ZNNM06T2p/h6KBKBLxZdGBzV1kj2tr0Q6F5b9Lg7ESI1tAgw
 nHRWkYd5jya5qXwSXNN9xWF7ITsA+Vdr1yJwIvT9X1xYRL7oyWxMkW9CFLJnjCjJ3eOVLfXiq
 gGFyHJx6mv8zS9Fcs6PDctGkdrWzr1T5PktIPkokNGBa55m5nVim+KSYMDc2rYEEwp++imAzP
 MDYNQOrx05+TlR4Y5KE19OQ8F3fb1lLYSCUFPpiGdY4PbTq3B8VsXpkpPMSF6oyMNPAT8L8hc
 UEW+6c06UCWZxEbtrmawzakGAEXmhmgX0Kr9FzHZLlURfd8sJxB/fHIpE/m7g8HBsAS5GMJbo
 azfhotSg2FDsWI2gJjYQWPUe34JFyK/tFb8kxnmzMZybBumxu+VSSTyg7tQaHLRBcmhBD0OLc
 0c87xAlekRkp1o0k0K/QnFINETgTW3P6f7hE++SB8dkDCZpF4C69V0UxbcL6BrCmMBrP3CAgb
 68RQbYAHAWJIdm0TSWOd2WcSWAk8at28p9YOz9JNQ7h9x/Jjmila+8B4agdC43s/YxpwwA4KO
 F+KkpojKAs3zVhvV8qwDe3XRjI8mqS7N2VETyB6P2xbmEKcHy/neJAZqFRxAkVNd6LwS1LPwW
 blYqXVb94BaM3zZMA2ZyRTRp2AeGBUk/IF7KYxF3yeToHprRHyxFTI1edeFkbcVCsk0DchazK
 6o1PW6bIlEonAqO7af54IlwMIne53+Hlk2zJW46c/8PdE+rKE9lp/ATg58s1DmjCmUbVqzYg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289650>

Hi Pranit,

On Tue, 22 Mar 2016, Pranit Bauva wrote:

> I did run the tests. They produce the same results as they did before.
> To ease review I will next time include these the output of the tests
> in the commented section.
> 
> t6002-rev-list-bisect.sh : http://paste.ubuntu.com/15473728/
> t6030-bisect-porcelain.sh : http://paste.ubuntu.com/15473734/
> t6041-bisect-submodule.sh : http://paste.ubuntu.com/15473743/
> 
> Is there any other test I would need to run?

Oh, I just meant to point out that you need to make sure that the entire
test suite passes after your patch series (and ideally, after every patch,
that is at least what I frequently test before sending out patch series).

There is not really a need to mention that you ran the test suite. There
is only a need to run it ;-)

Ciao,
Johannes
