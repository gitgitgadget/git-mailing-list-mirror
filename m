From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series
 overview)
Date: Fri, 12 Sep 2014 23:52:16 +0200
Message-ID: <54136B10.4050001@alum.mit.edu>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>	<20140820231723.GF20185@google.com>	<20140911030318.GD18279@google.com>	<xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>	<20140912004717.GY18279@google.com>	<xmqqsijwaclo.fsf@gitster.dls.corp.google.com>	<20140912191812.GZ18279@google.com> <xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 23:59:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSYsG-0003ZD-Oz
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 23:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbaILV7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 17:59:21 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48347 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752337AbaILV7U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 17:59:20 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2014 17:59:20 EDT
X-AuditID: 1207440c-f79036d000005e77-c0-54136b126857
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 86.C6.24183.21B63145; Fri, 12 Sep 2014 17:52:18 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CLqGJ3027364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 17:52:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqCuULRxi0HlDzqLrSjeTRUPvFWaL
	tzeXMFr8m1DjwOKxc9Zddo8Fm0o9Ll5S9vi8SS6AJYrbJimxpCw4Mz1P3y6BO+PD4Z8sBdPY
	Kx6ffcXewHiWtYuRk0NCwETiS+9yRghbTOLCvfVsXYxcHEIClxklvs75xgThnGeSePDiFztI
	Fa+AtsSD9sdg3SwCqhK7D+1kBrHZBHQlFvU0M4HYogIBEh86HzBC1AtKnJz5hAXEFhHwkdh5
	uRksziwQL/Ho+Vk2EFtYIEri6YaHLBDL9rBITHz0HmwQp4C1xI2T11ghGvQkdlz/BWXLSzRv
	nc08gVFgFpIds5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZG
	SDjz7GD8tk7mEKMAB6MSD6+DtnCIEGtiWXFl7iFGSQ4mJVFe9XSgEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHeqCCgHG9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgvdk
	JlCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCha44uB8QqS4gHaWwjSzltckJgL
	FIVoPcVozNHS9LaXiWNd57d+JiGWvPy8VClx3haQUgGQ0ozSPLhFsET2ilEc6G9h3vcgVTzA
	JAg37xXQKiagVe/mCIGsKklESEk1MKbMWuZzIOVj+ew+npAlf1Q437b84BW6nznr/G7RSxPm
	xgo75rbOY668meHy6qLRVImvoZuL3PfFRhhXd6apB6utiLY1/nNY86LAu9m/ksQM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256950>

On 09/12/2014 09:56 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> [...]
>> There were a few other minor changes, and I think with them the series
>> should be ready for "next".  My "send and hope that more reviewers
>> appear" strategy didn't really work,...
> 
> You sent them just a few days ago.  Expecting anybody to have a
> solid time to sit thru a 19-patch series inside that timeframe is
> not so realistic.

It's hard to tell from my glacial (tectonic?) pace, but I really do plan
to work through all of Ronnie's ref-related patches. Of course it's up
to you whether to wait for me. I really hope to get through the third
series by the end of next week.

>> so I'll send a reroll of the series as-is in an hour or so.

Jonathan: Is a current version of this patch series set up for review in
Gerrit?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
