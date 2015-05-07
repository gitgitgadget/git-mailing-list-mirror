From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Thu, 07 May 2015 21:23:27 +0200
Message-ID: <554BBBAF.30705@kdbg.org>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>	<b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>	<CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>	<554A8084.10506@gmail.com> <CAPig+cQ2e4c5hYsRbZhgyvLcMPsqshqRUZGNLwhJd57YP9JEFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWk=?= =?UTF-8?B?bW1hcmE=?= 
	<sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 21:23:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqROR-00082i-32
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 21:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbbEGTXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2015 15:23:30 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:19588 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750907AbbEGTXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 15:23:30 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3ljPpS0X3Gz5tlL;
	Thu,  7 May 2015 21:23:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 1265A524C;
	Thu,  7 May 2015 21:23:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cQ2e4c5hYsRbZhgyvLcMPsqshqRUZGNLwhJd57YP9JEFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268582>

Am 07.05.2015 um 18:50 schrieb Eric Sunshine:
> On Wed, May 6, 2015 at 4:58 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> On 05/06/2015 08:57 AM, Eric Sunshine wrote:
>>> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
>>> <sebastien.guimmara@gmail.com> wrote:
>>>> -git-write-tree                          plumbingmanipulators
>>>> +git-write-tree                          plumbingmanipulators
>>>> \ No newline at end of file
>>>
>>> Your editor is perhaps dropping the final newline in the file? This=
 is
>>> an undesirable change. Patch 2/3 exhibits the same problem.
>>
>> As for the final newline, it was deliberately removed. I was not awa=
re it
>> was necessary in text files. I'll correct this.
>
> Historically, many Unix tools incorrectly handled files lacking that
> final newline; sometimes by dropping the line altogether, sometimes
> mis-processing it in some way or another. Misbehaviors still exist
> today, often in BSD tools. In fact, just a few days ago, such a
> problem was reported for git-filter-branch[1]. Consequently, retainin=
g
> newline is good insurance against misbehaving tools.

=46iles lacking the trailing new-line are not "text files" according to=
=20
the POSIX definition, BTW.

-- Hannes
