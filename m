From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 20:17:37 +0100
Message-ID: <54738451.1090604@web.de>
References: <5471EC26.3040705@web.de> <20141124175947.GN6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Jonathan Nieder <jrnieder@gmail.com>,
	=?windows-1252?Q?Torsten_B=F6?= =?windows-1252?Q?gershausen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 24 20:17:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsz8t-0006lX-Hm
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 20:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbaKXTRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 14:17:42 -0500
Received: from mout.web.de ([212.227.17.11]:52491 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbaKXTRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 14:17:41 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0McFTf-1XbjEr0MKN-00JaFy; Mon, 24 Nov 2014 20:17:38
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141124175947.GN6527@google.com>
X-Provags-ID: V03:K0:C8RJLgxL8lW8T7pKI87xC7w2HuRljLBfJaf5Scg3VNUuKQDHKOw
 r0d+GfeYR2e0u2rJ6sObP7m4Lzk3VXmIaOWKPsXhOyyV9V7ocEmC914gLt4GFfxMs06Mrqz
 B+1d7mRvJzVaq9n4z/9YB9QY6BlcrB8m+AnaeMeCgQkOj5MV8a0A/C9qSJjUl6QWwzEmAQx
 Figrojj0Kwnn2mI8XqvxA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260138>

> 
> Patch looks good to me.  Do you know if this has been reported to the
> Cygwin maintainers?  The behavior seems counterintuitive --- I would
> expect _GNU_SOURCE to override everything else (since I thought that
> was the point of _GNU_SOURCE).
I don't know, it seems that CYGWIN is now in class with some BSD and Mac OS X.
Actually Ramsay did send a patch, so that this is obsolete now.
