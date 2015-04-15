From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 16:22:40 +0200
Organization: gmx
Message-ID: <20bd52de595018f49eeeea64128e3a77@www.dscho.org>
References: <552E628C.7040809@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git-owner@vger.kernel.org
To: Pirate Praveen <praveen@debian.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 16:23:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiODN-0002uH-Hv
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 16:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbbDOOWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 10:22:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:58999 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754786AbbDOOWt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 10:22:49 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJWAZ-1YfvVS2Pyl-0038pJ; Wed, 15 Apr 2015 16:22:41
 +0200
In-Reply-To: <552E628C.7040809@debian.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:IvTFdj68nC5Fa2St9cZZK2lnwPTKFkjwThlsVJ/rhsTkTN5dY/P
 1sHF4viaCHBbucbuR2IdmbuZIy7qT3zD/kezsrayvxaGrMwOEtfoSMWZTYakSeECttoXWCy
 UqshZG/osudMJQo9DJ1Jlb5ptQ0ST+QmGsQWNv8OVOzm+kbvRBkW+47P1V/S0c9fwU9A2VO
 24AY2l1wCq2uW1To73DXQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267201>

Hi Praveen "Arrrr",

On 2015-04-15 15:07, Pirate Praveen wrote:

>  When working with big projects over a slow, unreliable connection,
> currently there is no way to resume a clone or pull when the connection
> breaks. mosh is a better replacement for ssh over unreliable
> connections. supporting git+mosh protocol will go a long way in
> supporting people who work with unreliable, mobile networks, especially
> in developed countries (I personally have to try many times when working
> with large projects as my 3g mobile connection keeps dropping. I
> recently discovered mosh and it works like a charm. More about mosh
> https://mosh.mit.edu/

>From https://github.com/keithw/mosh:

> Mosh does not support X forwarding or the non-interactive uses of SSH, including port forwarding.

In particular it "does not support [...] the non-interactive uses of SSH", which the git+mosh transport would require, though.

That means that you would have to invest quite a bit of effort into enhancing mosh to *support* the non-interactive uses of SSH before you could start implementing `git-remote-mosh`...

Ciao,
Johannes
