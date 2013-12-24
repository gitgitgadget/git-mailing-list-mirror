From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Tue, 24 Dec 2013 22:48:00 +0100
Message-ID: <52BA0110.4050003@web.de>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com> <1387789361-29036-1-git-send-email-pclouds@gmail.com> <52B87759.2090901@web.de> <CACsJy8A7j_ERqH_TDuKDdssaLFCvM5yVT4eUjTqkN_qW4iXuGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 24 22:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvZq3-0003TS-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 22:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007Ab3LXVsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 16:48:05 -0500
Received: from mout.web.de ([212.227.15.14]:63199 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab3LXVsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 16:48:04 -0500
Received: from [192.168.37.101] ([93.222.13.61]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lk8t4-1VJmJ93kOQ-00cCoj for <git@vger.kernel.org>;
 Tue, 24 Dec 2013 22:48:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CACsJy8A7j_ERqH_TDuKDdssaLFCvM5yVT4eUjTqkN_qW4iXuGA@mail.gmail.com>
X-Provags-ID: V03:K0:VUQtztA28ldlyIi9mOZPvC8xNBeQuDmY4Tl11++lk84lLDV7XeE
 W8x7JuEmMHAI616pm0duxHY3Bx3iZTWRUZjOdqqo5CwAAoqdmRWeMypsR95lmCzU68zalFx
 ukWo8zEXVg/wWB7jEoGb1Ui2LPZQ++r8LKnJd1RBRN7o2HzCNypJ9VDQ2Gh57hzO0uNkQcg
 bmo3I0DCIJdefOoE7ZQRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239670>

On 2013-12-24 00.46, Duy Nguyen wrote:
>
[snip]
> We don't complain about adding an empty directory before or after this patch.
Ok, thanks for the explanation.

I think that
https://www.kernel.org/pub/software/scm/git/docs/git-add.html
could deserve an update.

My understanding is that <filepattern> is related to $GIT_DIR,
but "." is the current directory. 

I will be happy to write a patch,
(or to review one, whatever comes first)
/Torsten
 
