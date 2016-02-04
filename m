From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 4 Feb 2016 16:27:49 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602041619430.2964@virtualbox>
References: <cover.1454587284.git.johannes.schindelin@gmx.de> <20160204121437.GF29880@serenity.lan> <alpine.DEB.2.20.1602041334450.2964@virtualbox> <20160204130111.GG29880@serenity.lan> <alpine.DEB.2.20.1602041411520.2964@virtualbox>
 <20160204140609.GH29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elia Pinto <gitter.spiros@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Feb 04 16:28:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRLpA-0006vf-I5
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 16:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965970AbcBDP14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 10:27:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:54542 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965015AbcBDP1z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 10:27:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MOOJl-1aNmuh28bF-005mYZ; Thu, 04 Feb 2016 16:27:50
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160204140609.GH29880@serenity.lan>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Dn5DxwFJ3gNkx4ozE8UDvmSPWxMBIInt8SDGjR30j2zZnDqFbT/
 OJc8WBV5mnW2/zhz941XjWaQt3olZ+5+CNBAx7tYoFXQf1bgSHhVg1uP+/Za2jJdpbZP1se
 ZDwMYg8knjqewByl299iqyJWL5PQvNrSgr0WpehNREiZoI152z+kTM4SB8NGdzhD7Qi/Wcv
 zLTvXUbdaQBWm1GQQK7kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B8jO86zzMPM=:z7JXHeHPTAm39SDyIWtp8S
 /m4KsY/mYSke+GzgZo+IIzhYJ68kqB0xxaNjhD71Qe939vMG/vgVxtz+zKpxymY699BaWVulF
 3fOnqe6xn+iA8UhfThS9gv0ITMmtZyeaXGJekH5k755VevJzsGwEl3wfsbOLyRLEwULf7Ah3A
 pYR31e4e9xi3eY0br2sZM0mrusLhPhxZEDNtYYIgK3xDvLdbzu7GgnXTM0TyG5lhnUHHdrMY2
 Zh7t0wOgN9IYZOdriqXew1CjIFLIYynxop2oDvjo87RjAvuhMvNO0ys4tUuWmivb/2/vwT05x
 8aLXECF+A6iyGRNhv5qzu61HHVMoxb4x22MMSJxdlcuoGhsZx0cB0xD1fq0OoZX9tXxsEHJSG
 xZe3zs7YSfNk9H//zBZ5QlomKi9mfj9IXeFTDiRXnrU/enVb82e4b99IerebCX1k6HzlbS23w
 1eDetyJi/dyMOIE1YyR23b6GUveJG/KZJAmdzbKeOGKk52RqzCZVbJvZ0RELHoGTpdrRKWbWl
 oKYat/LMI9m+lvxsYUDWiSBMoPINg4/Yf5SPV+oEA/zmnA4LZQUxZLzNlq/5F96DGgDrHkjYo
 i3DyzSvYd9sLoylIg2yZWwoJAqeHrKr2hPIWu4eUuTL87XnQA/8b484Hhin9jA5/udRAHxbcv
 tdCVhJ4uHD5VnxXiXpr6iT88BhPNIm7msLuspvNfr96yVQ4YbyC1kk239o0qbA/R7L+1U6oL2
 a9UNcnzuR/HthvenSKTCQlIlY3a+uG28GMyQ7BtILmmBsytj2UBF9o58ZcyEHCQIYrwwNXo+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285465>

Hi John,

On Thu, 4 Feb 2016, John Keeping wrote:

> On Thu, Feb 04, 2016 at 02:13:47PM +0100, Johannes Schindelin wrote:
> > Whatever the outcome, the inconsistency must be fixed.
> 
> I disagree.  Unless there are other changes in the same area, the noise
> isn't worth it.
> 
> However, I do think we need to agree on a policy so that new code can be
> consistent.  This should then be documented in CodingGuidelines.

If you want to enforce it in the future, how can you possibly be against
fixing the inconsistency in the existing code? Sorry, I am really unable
to understand this.

Also, we *did* document the policy in the CodingGuidelines:

	As for more concrete guidelines, just imitate the existing code

So. There you are. By that token, my patch series was the correct thing to
do because the first arithmetic expression introduced into a shell script
in Git's source code had no spaces.

At this point I am a bit fed up with the discussion because by now it
feels to me more like a Slashdot thread than a technical discussion with a
direction.

As far as technical direction goes, here is the summary of what I have to
say: I still think that the changes I submitted are good because they seem
to me to reinstate the coding style with which we started out.

And that's really all I have to say about this matter.

Ciao,
Johannes
