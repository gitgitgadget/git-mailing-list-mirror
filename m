From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Sun, 20 Dec 2015 23:57:40 +0100
Message-ID: <56773264.2050806@web.de>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
 <20151220074559.GF30662@sigill.intra.peff.net>
 <alpine.DEB.2.20.1512201519590.6483@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 20 23:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAmvt-000806-TT
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 23:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbbLTW6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 17:58:18 -0500
Received: from mout.web.de ([212.227.15.3]:56724 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbbLTW6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 17:58:17 -0500
Received: from macce.local ([93.222.57.203]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MSrll-1Zj3Q91Sb7-00Roi4; Sun, 20 Dec 2015 23:57:48
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <alpine.DEB.2.20.1512201519590.6483@virtualbox>
X-Provags-ID: V03:K0:BpKxQ8hlPceX/lSVD9tvvdlJYEhWIeNlOfoAiG/MYNYoKzG95ot
 uhCHrWa3BgLkpMBXvhNXvNU8PfoZBTyWYKEdzU1+NAuiBnPYJ4DNPs2DQvO9mMuCqIkhkZ6
 qPonBAwVAxyvbVOSp6dWiUTgCgEQpGGgp3NRBN9Ikc3rizC68/+dO1pd3X8CnvV+g3uiWOJ
 VM4NvaCvEgJADQ6TWEz0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HLsrLBBEPCU=:g+hMj/XOs6BKQY2oH9A59F
 jWx5Nx9FhttTPPSqsmwRHNBs5lDZSGsQg2Fr5agRbtrs8CF2w6d2LFBMbYJrP08c06K8LcxZM
 pnxzX0r7XpKVCNGVzV4mtEXmuCK1o9bv/Fm/uQiqZaOtor2NULZiXcwNYwFS3DEVesX4/AidH
 EoP/RL0+9c3a9GnEvWUkxriFhAnBR7ZhOPT8XBYWB2wN8CBZTeM2gSm47HsVbsMTpBYi3CVD/
 jX/zpM69jE4QtJXOkq3qcjTHHdSqHd5OKkj2gc2m9xKd9pukpuxyhpWpgQZ+5zoEPj57gCuu/
 KP3BA1BUVx/Uph6Zu345bRT40vZ9Mq2O1d4+4Bcu/bqzl7mY5NYpNbiwNhiE1E7efavxzOUiH
 sUZ0+7bT9GHZIQKQHeBBWl+apjbwOK2bBpLHivQDCpjZISbfv952w1QtpxqNmNzzD94ly+oW+
 D8Dt+rfMv3VkVg8JYib354m671mF8zX18Qqq/aDd3PQTJJfGvz8Q3/Vl3EDe0jzTsAiMvzYfB
 h173YYkYW+U/B1Zck2wkYsRAa+hJ7i5unO4j3fPoOJOJYqaYZTRvwTmM7vJ+JsJqxGTnXNJNi
 ivBOFhomssKhn2X6tfSz1qBcd6QWDwhgZHSk1mJ1WsssHDDnos46DOK7tMHHsehwMyjYm2/Jz
 PJtyMOcJ1DHSZJWlRhGi6v8ojIymbApxpz9O4TJOscNaZa4gKs/QSAJdBiLnkhCZ2wtB5bS/A
 8xHluh5InKVCt8gWh88EZQi6r5arV0A9kuEWacmhiV3F4bDnnucKsqdU2R1giga8QJB1Zv8Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282775>

On 2015-12-20 15.21, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Sun, 20 Dec 2015, Jeff King wrote:
> 
>> On Sat, Dec 19, 2015 at 07:21:59PM +0100, Johannes Schindelin wrote:
>>
>>> It was pointed out by Yaroslav Halchenko that the file containing the
>>> commit message had the wrong permissions in a shared setting.
>>>
>>> Let's fix that.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> I think this is probably a step forward, but I have to wonder how many
>> other files are in a similar situation (e.g., git-am state files, etc).
> 
> True.
> 
>> I think people generally haven't noticed because shared repositories are
>> generally about a shared bare rendezvous repo. So refs and objects are
>> important, but we don't expect people to commit.
>>
>> So I don't have any real problem with this, but I suspect it's just the
>> tip of the iceberg. We might want something like:
>>
>>   FILE *fopen_shared(const char *path, const char *mode)
>>   {
>> 	FILE *ret = fopen(path, mode);
>> 	if (!ret)
>> 		return NULL;
>> 	if (adjust_shared_perm(path)) {
>> 		fclose(ret);
>> 		return NULL;
>> 	}
>> 	return ret;
>>   }
>>
>> but of course the hard part is auditing all of the existing fopen()
>> calls to see who needs to use it. :)
> 
> In principle, I agree, but I have to point out that the
> adjust_shared_perm() call must come after the *fclose()* call, to avoid
> modifying files to which we currently have open file handles.

I had the same concern, but couldn't find anything that gives a hint that we
can't adjust
the permissions on an open file.

(In opposite: We can't rename an open file (under Windows))

In fact we have this in tempfile.c

int create_tempfile(struct tempfile *tempfile, const char *path)
{
	prepare_tempfile_object(tempfile);

	strbuf_add_absolute_path(&tempfile->filename, path);
	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
	if (tempfile->fd < 0) {
		strbuf_reset(&tempfile->filename);
		return -1;
	}
	tempfile->owner = getpid();
	tempfile->active = 1;
	if (adjust_shared_perm(tempfile->filename.buf)) {
[snip] Error out

(And this seems to be the same in git.git and git-for-windows)
