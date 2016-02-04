From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: git 2.7.0 crashes when top-down memory allocation preference is
 set
Date: Thu, 4 Feb 2016 16:29:26 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602041628180.2964@virtualbox>
References: <9e3cc44087134954a3414fa8998c3ce6@USNAEXCP2.pc.cognex.com> <alpine.DEB.2.20.1602040844330.2964@virtualbox> <43fbdf617f8d412db7b0d5c7d06df3ad@USNAEXCP2.pc.cognex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Klinger, Xia" <Xia.Klinger@cognex.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 16:29:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRLqj-0000NA-9y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 16:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567AbcBDP3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 10:29:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:64702 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756597AbcBDP3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 10:29:32 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LrevR-1a407300nF-013RVj; Thu, 04 Feb 2016 16:29:28
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <43fbdf617f8d412db7b0d5c7d06df3ad@USNAEXCP2.pc.cognex.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:i/BOP8DbBmD2obz9x7oRnpn0mrRg5yqbPpAnnWhPISivGuqBQmS
 7GlWQ9mcs3tgbBz399G3JlWZh931F5pe1z11nWgnttRKC5Pyl4CYuOMLSYyYAmbJAVPcg1f
 ysbQexer56hOdUKOii62fowKfU2BVBXuCRdP8FkVYczNgKMqElEqpw0Tc0ZNSS1dpQKkBLQ
 QzK6q3dnQ3uVE4WxGxeeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:exokXO30O/M=:gnxcbDKPT2kfpDE9nQCZ9c
 +Cn7RXDN3WyjH+jVKJOpURWJXGETovUkfMTtp4HIdGx8U18foto2VlFi94AaytKHhwByBJEgp
 Np/ju3FRE60v2T197BaFG6gYttmCBiK6KCFJn/E0Wlof32L5qxGAoZ46JfbC0NT9FZdo3N0NG
 cTmKyp8yy4UgN3Pz+5xyAdclfZ0kjW7eNT0NRnxmFgIshgS0xSiN1ZRlo4Di6Zt4oujmlFaP0
 HFn+8bTPzmTLtvee0t1iUdePywG2aLI43ul0ZodrNzIcl2RdItfpdoupfBvSyoahnga9nPKX0
 HxA620HrJsXLIFsDrJov28kRVHEfeYs8M1wIY288CuuxTTE5ocp1FURdadYX9HhpZnRWkWE43
 FyZKxYBgi+EMU78SrqgpgvZD+SDbUgIxeEmn8jj9w+31X02EfAZtipD8lFfe6jyv/tuGCmzh7
 9VDm2D5aiRk1ttfDGNQveUmUG9o6clKyCQpbu9za3zJSDtOWWVBFBDMqcfg7lnoZ8cntWGsJR
 ukwXO+N7cMcadbqepF+qqPazGcaVzTM3ImLvadVEdUEpiMjFPtN4s2Bu9dgAdd377rkbexIyq
 ecExdBVXJVdEGehXonAs3ishhuS5fE14rr8DH6to/NRLDtEXiT/2Io4i7wqtGK/jG/jli7pQP
 +pjddmzw+BjS5F350wqRmDQkV7YKg0z3lAx1YwbVtzGKnRwTyOVEEXCDxGEA7u5GMm8KlXmAQ
 ekg5stjbWS5wPfQXWXXmbKQ1/zLD1kZaEK5+QHx12+UCcD7gnKVCogVXfgUGL9r6MguGWRkU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285466>

Hi,

On Thu, 4 Feb 2016, Klinger, Xia wrote:

> I am not sure the Fast Track release means. Do you refer to Windows 10
> builds (updates)? I am running Windows 7 x64 and haven't gone to Windows
> 10.

The Fast Track release to which I referred is indeed Windows 10. In the
meantime, I verified that the problem you described still exists on
Windows 10, but has nothing to do with the issue 627 in Git for Windows'
bug tracker.

Ciao,
Johannes
