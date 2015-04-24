From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] connect: improve check for plink to reduce false
 positives
Date: Fri, 24 Apr 2015 08:37:21 +0200
Organization: gmx
Message-ID: <af8ebead06428a182fcb628301f34dd9@www.dscho.org>
References: <20150422232306.GA32705@peff.net>
 <1429747595-298095-1-git-send-email-sandals@crustytoothpaste.net>
 <1429747595-298095-2-git-send-email-sandals@crustytoothpaste.net>
 <b6b4da1f7735b834043375e3d8eaa331@www.dscho.org>
 <20150423155304.GA26018@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i?= =?UTF-8?Q?_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?Q?Torsten_B?= =?UTF-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 08:37:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlXFH-000204-GN
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 08:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbbDXGhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 02:37:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:58904 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932542AbbDXGhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 02:37:46 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MSMP5-1YsJoH402F-00TXEg; Fri, 24 Apr 2015 08:37:23
 +0200
In-Reply-To: <20150423155304.GA26018@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:YZgatxH2D1nrjN8E+aq1x3c8leo1EnMGnNJz5sdQS/8ODZU7So+
 2df2juadUdOc5X7aivhgE9hpretz7eJdH3tY8RCVkWWc33Qomc/bQY6u6KvlbeVWmtuoItb
 04lZ1JtPqNV2L+UMij0rQA6JPecv9WMGoOSffDztU7O5dF+qFi8HI5V/LbDvzs+7qY641co
 xEH7c9L9FeXXh+BHeD6Dw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267724>

Hi Peff,

On 2015-04-23 17:53, Jeff King wrote:

> What about "plink-0.83" that was mentioned earlier in the thread?

I was working a lot with Java projects where the base name is often considered to be the part before a version number that is encoded into the file name, so I think it would be a good idea here, too. Essentially, it would be the regex

    ^(.*[/\\])?plink(-.*|\.exe)$

... and maybe we should actually do exactly this, use a regex? I know that many developers try to stay away from them, but if you can read them, they are an efficient encoding of expectations.

Ciao,
Dscho
