From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Sun, 29 Jul 2012 17:37:17 +0200
Message-ID: <501558AD.6010402@web.de>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, hvoigt@hvoigt.net
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 17:37:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvVYm-000491-O9
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 17:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab2G2Ph1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 11:37:27 -0400
Received: from mout.web.de ([212.227.17.11]:64383 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab2G2Ph1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 11:37:27 -0400
Received: from [192.168.178.48] ([91.3.154.32]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MJTdf-1Sxyey15vn-002ofG; Sun, 29 Jul 2012 17:37:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
X-Provags-ID: V02:K0:FQPn1oC7mDccunVgNNUCTkD6I/bzYrLl6ec0cglyjXC
 gwtcc4wQPUtxuUce+Uz37stCC4ogHFsdo6m/YwT1txon9bIyx8
 wdT36CFm0wR2+ij/f0/uPQ1mT8FqA6kumXPyIh1f8OJNPJa6MA
 NZv94TB4eYUnQl9GurbolfOc3kSSsDRJEy0wuk+bSB4XGtrc1V
 FsKZLxBxU4S6I9f4R5CYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202484>

Am 27.07.2012 20:37, schrieb Stefan Zager:
> The --jobs parameter may be used to set the degree of per-submodule
> parallel execution.

I think this is a sound idea, but it would be good to see some
actual measurements. What are the performance numbers with and
without this change? Which cases do benefit and are there some
which run slower when run in parallel?
