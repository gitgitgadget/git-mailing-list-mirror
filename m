From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 15:43:49 +0200
Message-ID: <5370D015.10300@alum.mit.edu>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch> <53709788.2050201@alum.mit.edu> <5370a47bee98c_139611a92fc29@nysa.notmuch> <5370B920.2060506@alum.mit.edu> <5370beb4b2483_168f13a72fc57@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1cw==?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Mon May 12 15:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjqWV-0003DX-Fa
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 15:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbaELNn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 09:43:59 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62230 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752682AbaELNn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 09:43:58 -0400
X-AuditID: 12074412-f79d46d000002e58-78-5370d01d1422
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 36.61.11864.D10D0735; Mon, 12 May 2014 09:43:57 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1CF6.dip0.t-ipconnect.de [93.219.28.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4CDhnRi001405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 12 May 2014 09:43:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <5370beb4b2483_168f13a72fc57@nysa.notmuch>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTcRjH/e1ut3N6cZvafs1SHIRWzAojLwmJ8I8rKEwLyn/snJcbbbdx
	t0mGxMpBOc3eMaVESlYaaeyPZWL5UiEKa6M3wjAic7FVNErBl8ruXL789/ye7/f5fvjxPDii
	npBrcRNnZ3mOMeswJapWFGTo1wVtxVtaB3KoWX8PSl2PfFFQ7dM/MGpgnKN6Ol5glPt1nYx6
	F+iRU9OueoQadJVRteemwC4lfS1wiH7UPKagey8NY7T/00eEftvRh9ETz38q6ND5XkD/8qbR
	70M+tDC+JGFnGWOvLDZVcJvzjyYYRz1RzDaOnpi+34k5QQRxg3gcktvgUNsvNFavhsEPXZgb
	KHE1+QpA72Tk/yMgg02+nwrJRZAb4I2PYZlUo+R6+H3+y0ISRurhrfoasY/jKWQR/O3PiNlV
	cLjp8wIgmTTC+WB4wY6QD2RwZlYr1UlkHvzW+RiJsUYAnHzqXTDFk7nw+uUmTMqEpAbWny6S
	SoTMhF0t6lhMOnz4/QZyEaiaV9Cal13NK1ytAOkAaYzZYdFbGJNZYA16wcBwHMvrt2dbTPZs
	ttzhBbE1qbtB13DaICBxoEskonG2YrWcqRSqLINgDS7TpRBkr9haVWYtrzIygrGUd5hZYRBA
	HNElE3NeUSPKmaqTLG9dlFJxVKchZm5n7leTFYydPc6yNpZfVNfiuA4SLQFxUMWzFeyJYyaz
	fVmW4fFSuFKbLLBcOcszDruxVFpvqSDuV5ISRW6jNE4INsYidmOjI0CPB513XTI1ylk5Vqsh
	Sl6IJlIyGR3cEmLxOiNAI/44iSiQohLF211KiogQmQjJS7VKEDuzLGmdwFd4QG/V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248707>

On 05/12/2014 02:29 PM, Felipe Contreras wrote:
> Michael Haggerty wrote:
> [...]
>> 2. Moving git-remote-hg into the core would require you to continue your
>>    presence on the Git mailing list.
> 
> That is another red herring. Moving them back to the contrib/ area which
> is what Junio proposed would also require my presence on the list. Is
> that what you want?

No, actually my preference is that git-remote-hg be separated from the
Git project altogether, for the reasons that I stated earlier.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
