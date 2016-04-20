From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] replace --edit: respect core.editor
Date: Wed, 20 Apr 2016 08:37:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604200836050.2826@virtualbox>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de> <xmqqoa9536wi.fsf@gitster.mtv.corp.google.com> <20160420035353.GA31890@sigill.intra.peff.net>
 <CAP8UFD189+AcLstEx4s_2ZYWp6UOtDb=vWGYhCpJayM8ma5hxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 08:37:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asllm-0007Yy-ER
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 08:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbcDTGhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 02:37:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:56861 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbcDTGhn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 02:37:43 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MAQMg-1b3Bss0Ouw-00BbsZ; Wed, 20 Apr 2016 08:37:24
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD189+AcLstEx4s_2ZYWp6UOtDb=vWGYhCpJayM8ma5hxw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+M4Ide4I34IIi73IwChnajEsa0nf9xDnIqRJqt4iF1j9h+6zpjB
 LGJOdDekZ2WWszlFEfzPqWBiGRzgGoHdnFx2hDLLB6IjOH0AtvzNhY6A58X+g2yQTlJju7W
 xmCzoEr90W3EZnF/TS4dQ8hF5Oh850s6Oy+1oC3Z68w5vQKC5vLdV9F6/1rM9Ijf5uwmSg6
 qWdAY0qxqqPPaowa1grPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oeug/9cUO3U=:aALE/bk7vsgpia6TlyFWl7
 ysieIoX+/Oe4DqZkUIyuz8AwNoDxKOaqmqRy/wllswtvbLdolL93fwXGB1o9bATkKSBxAqT+x
 dqqQ+VMiFAg3Ubu949aOsw04yVEWrPFNLpoAE7VGfDQQLlePDSI/HWqoolghNijktPrIUyW+b
 ivsWuT/sB/pV+CYGsgCEHMGHmjw/C99YKPNDoSh1VOBkDpdqOT/xnDZ2JXaclDIx3rdIbt7Hq
 oFixzazoyvx5lrw1JvlxmMmFlUTBw6SfANo4uETJJqZlU1evuoA0+0kWncoL6msNoFnlT0V83
 yOO/FGNChu/9iQVbsUKML2/5XBTduVFUxRbgguPPeKPBfEQiAZ6fL+RtoyNnsm4mWpmfwk03B
 wy6VUdmmUehnGvGfLZiLkCzbk8+NeVt1PwiV2qDvSW8xdHzkOZHJo7xrLYNC1x6oTQF4Iy+eq
 zKUBfvzfJXE4tb+RAvZLwWh8DL2QtEk4rjjUe50L/iEGXOK8dCwmZnOPXhPNWbccaq2zBLVuv
 na1K4TTg44Xy3eBX7pGYvc3/zPJGU4G387qxgnkhpoTxeph7AV1Cj4wgGN6uMcOUas1Xj/oE/
 tGBe8l7nxVnKT38GadXIDzrAAW4+4lTsAURK2QPH98qGcKMmdSfL0TVPq9ou12xYSDbEYb/+o
 kCaLBpeiZSD8jNwRkg9NN1+yOj6D/+lk2cJExHeXFGL2QKPxGdtCRQ6LbXugvplfl0T9D8SaA
 NCwqz4CogI1xxf/+Pbfpw446OjsWtDIXYf2euknatogCbjBLCE54nWD4aGv/tq5JoArrsxpF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291985>

Hi Christian & Peff,

On Wed, 20 Apr 2016, Christian Couder wrote:

> On Wed, Apr 20, 2016 at 5:53 AM, Jeff King <peff@peff.net> wrote:
> > On Tue, Apr 19, 2016 at 09:22:37AM -0700, Junio C Hamano wrote:
> >
> >> I can understand "we only know edit mode needs config, and we know it
> >> will never affect other modes to have the new call here", and it
> >> would be good for an emergency patch for ancient maintenance track
> >> that will not get any other changes or enhancements.  I do not think
> >> it is a sound reasoning to maintain the codefor the longer term,
> >> though.
> >
> > Yeah. I agree the patch here is not wrong, but I would prefer to just
> > have git-replace load the config when it starts. It's _possible_ that
> > something might break or misbehave, but IMHO any program which breaks
> > when git_default_config() is run is probably in need of fixing.
> 
> I agree.

Okay. I tried to err on the side of caution (side effects? Ever heard of
side effects? ;-))

v2 coming.

Ciao,
Dscho
