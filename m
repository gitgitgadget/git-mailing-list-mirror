From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 16/17] editor: implement git_sequence_editor()
 and launch_sequence_editor()
Date: Wed, 16 Mar 2016 19:21:23 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603161918410.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-17-git-send-email-pyokagan@gmail.com> <alpine.DEB.2.20.1603150755450.4690@virtualbox> <CACRoPnRMOp38vfkQZjmkUqr+urN8NYcNN_oNzHtJqfyTorr1ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:21:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agG4f-0000QS-Me
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935096AbcCPSVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:21:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:65165 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933388AbcCPSVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:21:32 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lg6op-1a0arP1Sot-00pbVX; Wed, 16 Mar 2016 19:21:24
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACRoPnRMOp38vfkQZjmkUqr+urN8NYcNN_oNzHtJqfyTorr1ug@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:K+dpvFo2sf/rsbjmPTAlYrpWFjtEl3dmOqPNehxH8r644DPaHqp
 1xuJyqDIOWuEf6P7QOw4ooKvb7fSFsUs/QT/fwcUkAYtAHkLipmbJCEWgnsp2RIpazm99O/
 4Oitd/0ozSgAASuZaiOyhuJXmnNj3Dh/H5VtNXLobU8VAwGQi5FkYYDliIf9q8rdx40HBmS
 vHXldtDgVTxxsofJnt7MA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/7t9zp5+58s=:IGjTqlixFtSU6GL0jCqEDf
 eHKX+RHQhfLLLhyXkdYocEFbyOdOGumycSh3mO3FVpJIAa37I8x+eY+x2k2jmcR5H5uVWxg0g
 LhFS43R3ko2+c9IQM0PqtZLqCJV6S8VBNUeZ+2/Qmqt4WhNC0oGmGGvz9percIF5RPq9oPGqx
 oOiWXYrXYDEz0pcNZjezlnyG3fGsC/JE5f08l5wN42UaAJZxiyuvBftzIBq3MG03Fj/WYi/o4
 SJfmlyOZ+j0bGwcwa8jmMg56a5bIthnvgyf9pt2wOLSw66YsO1Onh69hsbo1W3U5GmJ6zFIr5
 Mm5Shg7e3J6LUoteoUyqVbeqYRf52oYAda2muZdW845OzbpRxKYYNXMtPcvKA9iHcdRMQl9EA
 Ssc5MkP6fIus/Mss+ZJYTPqjDrCe24pBuhNPhlPV1qehpo6gD1kf4FaDgPtMATd81MBrQr6Nh
 OKLPEjeB3ZrbvkvZdXzXXDOXVr2LfB6GImVL4h2Wy+/p3f01zZNPNtVMP26P5jIdpNhsLRP+9
 kFPxwAU2YHrvcGVj2OcjO3W/4fFxjdTi02DXh7Af7h+kZwetUjRFoeSAfxrPDNmAdHLGsBWqZ
 Xik4fkq0qZoSiU/eXqf/0Dr5SusivZi6paTCXIdsWk+xOjzpq8FGnyG3nXuFVbIZTNULz0Tie
 a3337pT0djq7af/8kehj7Tff2DcEf4YYobadRGrUpV0/lb+yuX3MWIX5Ia0U32567HuIzNJXS
 CG34L8GQn2zXvDuY1EXweBJJHJK50tD8mNR1AVNuwliBamB7/jfDhjoDaExRGbnYnEw5Q6C2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289012>

Hi Paul,

On Wed, 16 Mar 2016, Paul Tan wrote:

> Hi Dscho,
> 
> On Tue, Mar 15, 2016 at 3:00 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 12 Mar 2016, Paul Tan wrote:
> >> ---
> >>  cache.h  |  1 +
> >
> > No need to clutter cache.h with a function that is only to be used by the
> > sequencer. IOW let's make this static in sequencer.c.
> 
> The function needs to be implemented in editor.c

No, *another* function needs to be implemented in editor.c: one that
accepts the editor itself as parameter. You did that, but then you wrapped
it as git_sequencer_editor() and left the *really* useful function *still*
static to editor.c.

Or maybe the best solution would be to simply extend git_editor() to
accept the editor as an additional, first parameter, falling back to the
current behavior if NULL is passed (and then change all callers to pass
NULL).

I guess my preference would be with the latter, that would make for the
most elegant, minimally invasive and most reusable solution.

Ciao,
Dscho
