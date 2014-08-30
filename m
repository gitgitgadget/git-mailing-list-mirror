From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/2] t0027: Tests for core.eol=native, eol=lf, eol=crlf
Date: Sat, 30 Aug 2014 11:01:03 +0200
Message-ID: <540192CF.7070407@web.de>
References: <53EFBC3A.5020805@web.de> <xmqqha0wa09z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:01:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNeXB-0000py-8P
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 11:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbaH3JBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 05:01:10 -0400
Received: from mout.web.de ([212.227.17.11]:57516 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbaH3JBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 05:01:08 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MXpdL-1Xtulj3Cch-00WlJ0; Sat, 30 Aug 2014 11:01:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqha0wa09z.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:j42G1QVjPni5WMZi0XSlf+xq0qJItJtm3dOVgbbhuTT1+Nw1qdq
 B5NdpM31vdLLMPVsDyQdgtAE4tLpfjvjupfWMglkW/Kmvc8f8gF95g+/YeOuDvwLPYYdi7b
 g0KAohlkOayZcSuKYlwc5Dz2f/yE22sNmVbyxa49BQtd1R/g9DCPConbFaZQoBP2LEIdRXA
 KOWLzpLw8sI3y9VQHMZ3g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256243>


On 2014-08-28 21.20, Junio C Hamano wrote:
> It appears that I missed this patch?  You seem to have rerolled the
> corresponding 2/2, to which I responded ($gmane/255507).  Is this
> one still viable/necessary?
It seems that both the t0027 and the native_crlf fixes (from MINGW)
deserve a re-roll from my side, so you didn't miss anything.
Thanks for the comments below
>
> If you are doing the whole-sale style fixes for this script, can you
> also fix the case/esac statement in create_gitattributes?  The case
> arm labels are indented one level too deep, making it harder to spot
> them than necessary.
>
> Test files "setup master" step creates appear to end in an
> incomplete line.  Is this intended or by mistake?  Making sure
> things work even on files that end in an incomplete line is a good
> thing, but it looks somewhat strange not to test normal cases (in
> other words, it makes it appear as if normal cases work OK but
> incomplete lines cause corner case bugs and these tests are meant to
> check them, or something).
>
> Thanks.
