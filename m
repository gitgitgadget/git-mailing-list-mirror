From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git status during interactive rebase
Date: Fri, 22 Jan 2016 17:28:25 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601221712520.2964@virtualbox>
References: <CAGZ79kbUwJ+CN=YoQUP=rm=EhU=fU2ynt_7Q-cd7Dic-bsx+TA@mail.gmail.com> <vpqpowvz6g0.fsf@anie.imag.fr> <CAGZ79ka7MVuHyTrjuR7BhBAxxJ-PuMCSDnRVWCbeeRSq9rGdWQ@mail.gmail.com> <xmqqtwm6woh1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:28:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMeZi-000423-Jt
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 17:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbcAVQ2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 11:28:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:55151 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157AbcAVQ2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 11:28:33 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MZTP3-1ahktL2fmP-00LG0a; Fri, 22 Jan 2016 17:28:26
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqtwm6woh1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:RLkXfzR+LKGEuvJHNUmzfeHqZZcrg0CVpyrWO2NffDxvk/SoKHc
 4IxPQAiw5vbLG4B0bWMBW5XSWA8dPS5NcV6NLGXXkzNWW+Qt9YnepqRBVSWz6FmFvD1BF/i
 jZ9XEmm+MZ2QTA+mT9kFEPR9lH+J0AfWiT1JC+eketGMoE1cb70bP4GgYNPDffbWZbvcqf5
 V8PNmbpc3NusouI/vpiEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uvzZi74vd0M=:21Vseor6QzJ0vCKfaPWx77
 stgibGp81N2xNT35xTlSUqRpYKvr/CBDKe8DcspXaG+dm/xP0+WFJ75Br2sK4XTAT2Q1XaYZB
 NLQARSS4uljQd59NoTAKgtSFJcgFaIaVH4qtQA5wSB1MvcTVN2S7xoTvHB7yiwEkW37lv75Yv
 CrmdgbqjCGppcUQiDZT03yjK8RmhRGNkdwgi31X3lNBDoIsBQ9uO/XO9vJQI0H50u2PtnMelk
 cE8f9Iwt9XK37bLbbQTMWAIHmH4tnz1KzyU/U0lsFpziEIoIQHPY34H03e12qynnhpnyXMMZ2
 cbYZexIcXs0OcT8Yx+Mx7GUgdM/YIbvfV/LbRazDCWNKT1+NU2AiT2QXWPi7N8VYuYsSLhUyh
 WjMQrTIr2NcZ2r24L4PR154YuAWQczQvqKSaPzFHcn025JOAheec6VU0twE9tn2xtUzeyZkVG
 12db628sTtzvu2Qx4Tbv2IMvmFNNxLgyEAjn5fnEhnkjO1pb+KuHZ5M6jCW8gmmFk0ddtUOKX
 9xFkHkN8hrbXiPHUWlFhxwg5My3CZb9j9InHOVY3Y14wuuDhGq3HHwfgB0IOYARIbBvaiRQeN
 eRMRwVi0qE2mbfKj/ExwGmt5DiLktBy0EV3FLiNXEm0y1N88EANUgVCYWHpKIERuHY8ScjMjV
 /aQWuwpatrLgwM0MPG4C8iN3JNjtSckXsZoSXWt1SIgIvZXpdmaMqyl+snVbiuzkAxTU0Y8yd
 JcDuCNx/UKY72S4ib1+r3HXGx/l6Uk16cCHM85+N2AoKC6j8g+9Xv5qtMNcA3AJ4BX+yfgq6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284558>

Hi,

[Stefan, please do not drop me from the Cc: list ;-)]

On Thu, 21 Jan 2016, Junio C Hamano wrote:

> Perhaps something along this line (not tested and done on 'pu', so I
> am not committing it to anywhere myself)?

I like it!

I tested it, amended it and am about to send out a mail with a commit
message.

Ciao,
Dscho
