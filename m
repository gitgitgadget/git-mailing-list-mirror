From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH RFC] t0027: check the eol conversion warnings
Date: Fri, 21 Nov 2014 13:37:05 +0100
Message-ID: <546F31F1.5050701@web.de>
References: <546E5D26.8030109@web.de> <xmqqr3wx1oth.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:37:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrnSj-0001Ue-Ow
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 13:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbaKUMhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 07:37:14 -0500
Received: from mout.web.de ([212.227.15.14]:58712 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbaKUMhN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 07:37:13 -0500
Received: from birne.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M5flQ-1YBnBL3TQm-00xYKY; Fri, 21 Nov 2014 13:37:07
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqr3wx1oth.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:BothEsYIq9mHyc1b3zOMSjyjmrjcFBPMY0yS37bEF69hgUXiRry
 ozQDYpAH6frKd6mkmmKFn0Zklu4xpuGDea3rX8AhEc9Yi6z3GgsRbUW77qXZEBtXHkiddD/
 qD3YEjznjUxp3AQBILAA2DHlk9ujX90a9tAhXaPLBErSEjH/aZJfrQK/W7L3OMXtnEdRNhr
 xkbPNlT6vtcBNzVzBy1zg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 20.11.14 23:37, Junio C Hamano wrote:
>
> ---
> At a glance it is very hard to see what we might be _losing_ with this
> change that claims to "add" new kinds of tests on top of existing ones.
>
> I am guessing that add-check-warn roughly corresponds to the old
> create-file-in-repo but they have different calling conventions, or
> something?
>
> Perhaps split it into two patches (or more), each of which does one
> thing and one thing well?  I suspect that even with a two-patch
> split (e.g. the first of which only renames the function without
> adding the new "grep in error messages that could be localized and
> give false failures" code, and the second adds the lf/crlf stuff)
> might make this at least readable.
>
> I dunno.
>
We shouldn't loose anything.
The diff is hard to read, as some code
is re-defined and re-used (and a diff side-by-side looks nicer than the patch)

I will come back with a new commit message, which should explain things better
( or a 2-stepped patch)

The long term idea is to improve the gray areas in convert.c, and to do that we need a reliable
test frame work, to see what is improved or broken.
