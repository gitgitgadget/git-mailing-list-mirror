From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/12] t5520: implement tests for no merge candidates
 cases
Date: Thu, 07 May 2015 16:56:14 +0200
Message-ID: <554B7D0E.5040808@web.de>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>	<1430988248-18285-2-git-send-email-pyokagan@gmail.com>	<554B2AEB.3020608@web.de> <xmqqh9roscty.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 16:56:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqNEB-0001qb-RD
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 16:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbbEGO4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2015 10:56:39 -0400
Received: from mout.web.de ([212.227.17.12]:63118 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbbEGO4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 10:56:38 -0400
Received: from [192.168.209.53] ([217.211.68.12]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Le4Po-1ZbkCY0tiu-00pwRe; Thu, 07 May 2015 16:56:22
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqh9roscty.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:qANQCaodSbt81Kio1/xUlcjnzHX1xY6ps0eFrf7onJpM9cvE6WH
 rQZ0OYQizv0CkostXvGEQo43PndqrTrXPjQB01W5CjxXkGy5NeEQkuaf+OkHzzV7LUGDmIp
 T+vsMMdaDJ3MnCP9wVDyPdI5StSCrF3413FE22DyHIg8q+IGQXGlhxR/XVqm2hxn/HaiV88
 Kk9C/EPuhZcelx6yvHk1Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268534>



On 07/05/15 16:04, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> In other words:
>> test $(cat file) =3D file &&
> Is there a guarantee that file has a single word?  Can it be empty?
> Can it contain "foo bar\n"?
So true, will this work ?

test "$(cat file)" =3D file &&
