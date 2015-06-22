From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: 'eol' documentation confusion
Date: Mon, 22 Jun 2015 08:26:58 +0200
Message-ID: <5587AAB2.80305@web.de>
References: <CAHd499CapqvC3pHszgmX2VexdmqiW4+N23YfkAP5jjXWDrbe0A@mail.gmail.com> <CAHd499Do_bpdOkL2TqdO+8L=pR53117pKR0GSwdgvFDwq_S4=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 08:28:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6vDF-00009s-5B
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 08:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbbFVG1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 02:27:54 -0400
Received: from mout.web.de ([212.227.15.3]:56386 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992AbbFVG1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 02:27:39 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MEVQ1-1ZM1Mf0JKL-00Fn75; Mon, 22 Jun 2015 08:27:36
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAHd499Do_bpdOkL2TqdO+8L=pR53117pKR0GSwdgvFDwq_S4=w@mail.gmail.com>
X-Provags-ID: V03:K0:OH859zgK24v34HCNltVGwXuiOc7Tb2fbE69uJ6jEUTTnujiI0nH
 jL2bnrX8ub7jZ0HrNclD9ylXkL84K51Lc08mjVSsatFa0mVP4HXPDY67vIYJhOb5f3b9mr2
 LuQVPA1Q46javihW4N3is7FxDU+XWih8XgrEawgYNC8yHIn3h2sOTRRK2a+AXwawNTflkPe
 2LRUDsz1VBalG+AToSpUg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272316>

On 06/21/2015 04:16 PM, Robert Dailey wrote:
> On Sun, Jun 21, 2015 at 9:04 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> Upon inspection of the gitattributes documentation page here:
>> https://git-scm.com/docs/gitattributes
>>
>> When comparing the documentation for 'text' with 'eol', I see the
>> following missing explanations for 'eol':
>>
>> * eol
>> * -eol
>>
>> Maybe the fact that these are missing means they are not valid to use.
>> There is also the issue that `text` usually controls EOL anyway. Is
>> there ever any reason to set eol in a way differently than explained
>> in the documentation (that is, `eol=lf` or `eol=crlf`)?
No.
eol=lf or eol=crlf are the only useful settings.
Everything else is ignored because it does not make sense.

See convert.c:
static enum eol git_path_check_eol()
