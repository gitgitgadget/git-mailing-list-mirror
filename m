From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git log --no-walk --tags produces strange result for certain
 user
Date: Thu, 16 Jan 2014 11:31:20 +0100
Message-ID: <52D7B4F8.1010209@alum.mit.edu>
References: <5EE449B7-AB75-4EFF-85F9-292727FA1C53@jetbrains.com> <01D3F259-94E1-4084-9210-34E2DB7B7545@jetbrains.com> <52AEB181.9020006@alum.mit.edu> <AEF2BC21-6EE1-479F-BC63-7A5B95406A7F@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 11:31:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3kET-0001C6-6M
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 11:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaAPKbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 05:31:25 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:42232 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751552AbaAPKbY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 05:31:24 -0500
X-AuditID: 12074412-b7fc96d0000023d5-bd-52d7b4fbfc39
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C3.8E.09173.BF4B7D25; Thu, 16 Jan 2014 05:31:23 -0500 (EST)
Received: from [192.168.69.148] (p4FDD4898.dip0.t-ipconnect.de [79.221.72.152])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0GAVLbi004898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Jan 2014 05:31:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <AEF2BC21-6EE1-479F-BC63-7A5B95406A7F@jetbrains.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqPt7y/UggzmvRS26rnQzWby7v5XF
	gclj7rw3rB6fN8kFMEVx2yQllpQFZ6bn6dslcGfcmtjKUvCKvWLFmn+MDYz72boYOTkkBEwk
	3m19zQphi0lcuLceKM7FISRwmVHix7o9YEVCAueZJM69CQWxeQW0JQ4c7gRrYBFQleg89osJ
	xGYT0JVY1NMMZosKBEusvvyABaJeUOLkzCdgtoiAucTjX0vBbGYBfYlPfw6A1QsLBEh0XJnL
	CLH4FKNE16P1QEUcHJwCjhLHmphATAkBcYmexiCIVh2Jd30PmCFseYntb+cwT2AUnIVk2ywk
	ZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERK+QjsY15+UO8Qo
	wMGoxMObcP9akBBrYllxZe4hRkkOJiVR3nmbrwcJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuH1
	Xg6U401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4E0BxqmQYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCh+44uBEQyS4gHaawXSzltckJgLFIVoPcWoy7Fi
	w6c/jEIsefl5qVLivF4gRQIgRRmleXArYMnqFaM40MfCEJfwABMd3KRXQEuYgJYEV1wFWVKS
	iJCSamCc5n+mPi1R48k3Xn7Dnq32Nzek+lrdrDyYpzZps98drZcNKu+P6zVNl9x7e11OvpAA
	745zM5t9jpvbrkk8qOx2pTdW0z2iVbD9lIZjZOJxdrbdwZxHDnBNnHE+M5rrlpf3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240510>

On 12/16/2013 12:52 PM, Kirill Likhodedov wrote:
> I received one more complaint for this issue, and now it appears in a public repository https://github.com/spray/spray 
> 
> To reproduce:
> 
> # git clone https://github.com/spray/spray 
> # cd spray
> # git log --no-walk --tags --pretty="%H %d" --decorate=full | tail -3
> 3273edafcd9f9701d62e061c5257c0a09e2e1fb7  (tag: refs/tags/v0.8.0-RC1)
> ff3a2946bc54da76ddb47e82c81419cc7ae3db6b  (tag: refs/tags/v0.7.0)
> 8b4043428b90b7f45b7241b3c2c032cf785479ce 
> 
> So here the last hash doesn't have a decoration.

The problem is that reference refs/tags/v0.5.0 points at a tag object
8f6ca98087 which itself points at another tag object 2eddbcbff4 which
finally points at commit 8b4043428b.  Probably we should handle
recursive tag objects like this, but OTOH I can't think of a reason why
one would want to create them in the first place.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
