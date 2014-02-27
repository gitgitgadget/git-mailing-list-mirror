From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take
 options
Date: Thu, 27 Feb 2014 08:48:10 +0100
Message-ID: <530EEDBA.6090804@alum.mit.edu>
References: <530DA00E.4090402@alum.mit.edu> <20140226105249.GE25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 27 08:48:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIvhe-0005WK-O2
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 08:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbaB0HsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 02:48:16 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62488 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751463AbaB0HsO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 02:48:14 -0500
X-AuditID: 12074413-f79076d000002d17-9f-530eedbd1ed6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 29.E1.11543.DBDEE035; Thu, 27 Feb 2014 02:48:13 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1R7mBYf020066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 02:48:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140226105249.GE25711@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsUixO6iqLv3LV+wwd7VJhZdV7qZLPqXd7FZ
	TLjfwGzxo6WH2YHFY+esu+weHz7GeTzr3cPo8XmTXABLFLdNUmJJWXBmep6+XQJ3xrt7L9kK
	TghUvLzVytzAOJu3i5GTQ0LARGJJ8wYmCFtM4sK99WxdjFwcQgKXGSVuHl/HCOGcZ5I4P/ER
	M0gVr4C2xMc//8A6WARUJSa37Qaz2QR0JRb1NIPZogLBEqsvP2CBqBeUODnzCZgtIiAr8f3w
	RkYQm1lgFaPEih36ILawQKhEz+UzYL1CAlESK3v3A13BwcEpYC2xeWEkiCkhIC7R0xgEYjIL
	qEusnycEMUReYvvbOcwTGAVnIdk1C6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0
	zfVyM0v0UlNKNzFCAlx4B+Ouk3KHGAU4GJV4eE8w8wULsSaWFVfmHmKU5GBSEuVd8xIoxJeU
	n1KZkVicEV9UmpNafIhRgoNZSYT3kAtQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1
	ILUIJivDwaEkwWsPjGQhwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFDsxhcDoxck
	xQO0d+VrkL3FBYm5QFGI1lOMxhy32359YuS4uv3fJ0Yhlrz8vFQpcd57b4BKBUBKM0rz4BbB
	UtsrRnGgv4V5NUCqeIBpEW7eK6BVTECrjkrzgKwqSURISTUwTu/Ine3ElRIWwJ/87HwA6+VX
	ojv1GvrFbd6p3ck8Y/OvgGeXSexUw/gF8xR6zCIjvZ/eSr1VKjjlqfoFozWTLGYV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242790>

On 02/26/2014 11:52 AM, Jeff King wrote:
> On Wed, Feb 26, 2014 at 09:04:30AM +0100, Michael Haggerty wrote:
> 
>> It would be nice to support more flexibility in the todo-list commands
>> by allowing the commands to take options.  Maybe
>>
>> * Convert a commit into a merge commit:
>>
>>       pick -p c0ffeee -p e1ee712 deadbab The oneline of the commit after
> 
> This seems like a reasonable feature to me. All of your examples are
> possible with an "e"dit and another git command, but the convenience may
> be worth it (though personally, most of the examples you gave are
> particularly interesting to me[1]).

Don't forget that any of the parent commits might have been rewritten
due to the earlier lines of the rebase script.  Rebase has to map the
specified SHA-1s to their new versions.  So I don't think that this one
would be very practical to implement by hand.

Actually I think it is awkward to have to specify all of the parent
commits.  I did it this way to make it look like commit-tree's -p
option.  But any usage of this feature that *doesn't* include the
immediately preceding commit as a parent would probably be broken anyway
(for example, the preceding commit would become unreachable).

So maybe a better UI would be

    pick --merge=e1ee712 deadbab The oneline of the commit after

(even though this precludes the short form "-m" because it is already
taken by --message).

On the other hand, allowing arbitrary parents with "-p" might be a way
to make "rebase --interactive" work half-sanely with parts of history
that *already* include merge commits.  The todo list that rebase
prepares for the user would already include these "-p" lines.

What I like about allowing options in todo lists is that is that it
opens up a lot of possibilities for "git rebase --interactive" that, I
think, have previously been hampered by the restriction that commands
have to consist of a single word, and (until now) have to be abbreviable
to a single distinct letter.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
