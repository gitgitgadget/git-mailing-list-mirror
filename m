From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Sun, 15 Mar 2015 19:03:13 +0100
Message-ID: <5505C961.7050008@web.de>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com> <5505C6BD.5000809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCsl-0007KZ-TT
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 19:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbbCOSDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 14:03:20 -0400
Received: from mout.web.de ([212.227.17.12]:59332 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbbCOSDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 14:03:19 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LuuNx-1ZWM4Z2PAX-0103lb; Sun, 15 Mar 2015 19:03:14
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <5505C6BD.5000809@web.de>
X-Provags-ID: V03:K0:I3nxSaIltJ4lQKAqM0ijrb/x7Yx+zKU4g/j3NIiztNObtJwD8NB
 /76yjSUIktXtsFLdHWzDaOcD2SdYPnugApHGFD3OjM/x5gqrSXI7pi9anyEqmwsIN0JEhWn
 WXvjCCJuWVahaxmWuwQ68vrkUqBdezGQEfSPImEppGy/bvklsjjHw01P8245HPOdnBpRmdT
 kaH1F9fXEUzt68yfCHbuQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265506>

On 2015-03-15 18.51, Torsten B=F6gershausen wrote:
>>  	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all=
 tracked and untracked files")),
>> +	{ OPTION_CALLBACK, 0, "exclude", &exclude_list, N_("pattern"),
> What does pattern mean ?
I was too fast, take that back:
Documentation/gitignore.txt uses pattern as well.
Sorry for the noise.
