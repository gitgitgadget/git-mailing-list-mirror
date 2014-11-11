From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [Opinions] Integrated tickets
Date: Tue, 11 Nov 2014 19:15:47 +0100
Message-ID: <54625253.4070903@ira.uka.de>
References: <20141105124429.GF15384@paksenarrion.iveqy.com>	<xmqqvbmsgocj.fsf@gitster.dls.corp.google.com>	<54620522.4060600@ira.uka.de> <xmqqioil7j20.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:16:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoFyw-0002VT-8u
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 19:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbaKKSPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 13:15:54 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43923 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859AbaKKSPy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2014 13:15:54 -0500
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1XoFyl-0004tl-Fe; Tue, 11 Nov 2014 19:15:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqioil7j20.fsf@gitster.dls.corp.google.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1415729747.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.11.2014 um 18:17 schrieb Junio C Hamano:
> Holger Hellmuth <hellmuth@ira.uka.de> writes:
>
>> Am 06.11.2014 um 19:45 schrieb Junio C Hamano:
>>> This is a tangent, but I personally do not think "ticket" meshes
>>> very well with "commit".  If you already know which commit was
>>> problematic, why are you annotating it with a ticket before
>>> reverting it first?
>>
>> I would expect a ticket to be annotating the commit or version tag
>> where the bug was found, which usually isn't the commit where the bug
>> was introduced.

[...]

> Either way, I do not see how such an arrangement is the most
> convenient way to organize the tickets and ask questions such as
> "what are the known, untriaged, or unresolved issues in v1.8.5?",
> "what are the issues that didn't exist in v1.7.0 but appear in
> v1.8.5?", "what are the outstanding issues around refs handling that
> are the highest priority?", etc.  With your arrangement of data, any
> of the common questions I think of asking would require a linear
> scan of a commit range, followed by an enumeration and parsing of
> all the notes attached to the commits to answer.
>
> So I would have to say that your expectation makes even less sense
> than annotating an exact buggy commit with a note saying what is
> broken by it.

Not less sense, because with tickets attached to the exact buggy commit 
one would have the same problems answering the questions above. I don't 
dispute that tickets and commits don't mesh, it was the reason that you 
gave the first time that didn't sound right. Sorry if I have wasted your 
time, but looking at it from the management side removed any lingering 
doubts for me that there might be a benefit to an integration, even if 
some sort of indexing or database was used.
