From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sun, 27 Jan 2013 09:41:11 +0100
Message-ID: <5104E827.2040906@alum.mit.edu>
References: <cover.1358686905.git.john@keeping.me.uk> <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk> <20130126175158.GK7498@serenity.lan> <7vwquzzkiw.fsf@alter.siamese.dyndns.org> <5104B0B5.1030501@alum.mit.edu> <CAGdFq_icLDEdJJKHZsht8bXpZzSNProLt3F_u=0en2rFBvxLKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 09:41:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzNo3-0006kG-19
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 09:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab3A0IlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 03:41:16 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:63037 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756220Ab3A0IlP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 03:41:15 -0500
X-AuditID: 1207440f-b7f276d0000008b2-88-5104e82a59c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 56.65.02226.A28E4015; Sun, 27 Jan 2013 03:41:14 -0500 (EST)
Received: from [192.168.69.140] (p57A25FD5.dip.t-dialin.net [87.162.95.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0R8fBNk009166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Jan 2013 03:41:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <CAGdFq_icLDEdJJKHZsht8bXpZzSNProLt3F_u=0en2rFBvxLKw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqKv1giXQYPMNdYuuK91MFg29V5gt
	bpzfxWox/8ZZRgcWj52z7rJ7nH30gNnj4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4MyYt+cpa
	cIet4sH9tcwNjJtYuxg5OCQETCSW9HB2MXICmWISF+6tZ+ti5OIQErjMKPFlbQ87hHOGSeLc
	gzNMIFW8AtoSl9f/BbNZBFQl3j2cA2azCehKLOppBrNFBcIkel+fY4SoF5Q4OfMJC4gtAtR7
	7sc0sDizQJHE2v7PYLawgIvEqZYWJohl25gkfjetZQNJcAoESqzd1MoIcimzgLrE+nlCEL3y
	EtvfzmGewCgwC8mKWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pS
	uokREsz8Oxi71sscYhTgYFTi4f2VxhIoxJpYVlyZe4hRkoNJSZT37jOgEF9SfkplRmJxRnxR
	aU5q8SFGCQ5mJRHe+ZVAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eS
	BK/Uc6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO01xeknbe4
	IDEXKArReopRl2P77/bnjEIsefl5qVLivP9BDhcAKcoozYNbAUtdrxjFgT4W5jUAGcUDTHtw
	k14BLWECWpLdywyypCQRISXVwLhTNKojXVGZYUH3GQs7ofvMmn4tbt9qjlw4VtsuEL+BpYrF
	3XNyt+jDDasfCTlsj7s2jTG+ZfFsq5KybxnmAXLWbXXXblj0/FWfNS9Qriv1kLXb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214687>

On 01/27/2013 06:30 AM, Sverre Rabbelier wrote:
> On Sat, Jan 26, 2013 at 8:44 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> So to handle all of the cases across Python versions as closely as
>> possible to the old 2.x code, it might be necessary to make the code
>> explicitly depend on the Python version number, like:
> 
> Does this all go away if we restrict ourselves to python 2.6 and just
> use the b prefix?

repo.path ultimately comes from the command line, which means that it is
a bytestring under Python 2.x and a Unicode string under Python 3.x.  It
does not come from a literal that could be changed to b"value".  (Nor is
a six.b()-like function helpful, if that is what you meant; that is also
intended to wrap literal strings.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
