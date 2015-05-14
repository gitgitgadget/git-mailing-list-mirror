From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: sh -x -i -v with continuous integration, was Re: [PATCH 1/4] t7601:
 test for =?UTF-8?Q?pull=2Eff=3Dtrue=20overrides=20merge=2Eff=3Dfalse?=
Date: Thu, 14 May 2015 18:53:19 +0200
Organization: gmx
Message-ID: <81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
 <1431510740-9710-2-git-send-email-pyokagan@gmail.com>
 <2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
 <xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 18:53:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswO5-0005ir-MF
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 18:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbbENQx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 12:53:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:65106 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933006AbbENQx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 12:53:27 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeiJ8-1ZY4yc3Ucg-00qTcq; Thu, 14 May 2015 18:53:20
 +0200
In-Reply-To: <xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9VdflxwQ1pgMaW7/tlMWnBlHwv9h9jRehN46Z5dfvn830ta5ejM
 S2yuWRm+1VCQ6qd18tjO5bUkN51NOCuEuX8OF4LOkKk4Vz6Kble2u8eC8tLP7eMAVaTuyDk
 KVUJSp6jnIUERd+juomssP9SQ0fjZWyMgYYdZOgb5qDfggsV1WcH9OX+F6LUwjcQIbi4f81
 lmQ019iFfgGj2pOI/5Iow==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269043>

Hi Junio,

On 2015-05-14 18:45, Junio C Hamano wrote:

> By the way, I cannot think of a reason why your CI cannot always run
> the tests with GIT_TEST_OPTS="-v -x" exported.

Asketh and ye shall be given: without running the tests in parallel, our Jenkins would take *even longer* than the three hours per test suite run (which is really painful, still, by the way). And as you know, running the tests with "-v -x" is awfully useless if you run the test suite in parallel.

Come to think of it, the proposed "verbose test" will not help this use case one bit, neither would test_eq.

Ciao,
Dscho
