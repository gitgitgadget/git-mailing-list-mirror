From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rev-parse: clarify documentation for the --verify option
Date: Tue, 02 Apr 2013 09:49:13 +0200
Message-ID: <515A8D79.6050808@alum.mit.edu>
References: <1364625865-8459-1-git-send-email-mhagger@alum.mit.edu> <7vwqsnnpwj.fsf@alter.siamese.dyndns.org> <7vli92jijz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvyU-00050c-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760590Ab3DBHtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:49:18 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:48808 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760541Ab3DBHtR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 03:49:17 -0400
X-AuditID: 1207440f-b7f466d0000009dc-62-515a8d7cfb07
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.37.02524.C7D8A515; Tue,  2 Apr 2013 03:49:17 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r327nE6T031302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Apr 2013 03:49:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vli92jijz.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqFvbGxVosGsKo0XXlW4mi4beK8wO
	TB4XLyl7fN4kF8AUxW2TlFhSFpyZnqdvl8CdcfPjL/aCVu6KXWfvsTcwXuXoYuTkkBAwkWg9
	cIAJwhaTuHBvPVsXIxeHkMBlRolrJzcyQzjHmCRWL77MAlLFK6At0b1xC5jNIqAqsW7+M2YQ
	m01AV2JRTzPYJFGBMIm9F6axQdQLSpyc+QSsXkRATWJi2yEgm4ODWUBcov8fWFhYwFfi7vSD
	TBC7pjNK7L02kREkwSlgJvFhRRPYTGYBHYl3fQ+YIWx5ie1v5zBPYBSYhWTFLCRls5CULWBk
	XsUol5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pSuokREqj8Oxi71sscYhTgYFTi4XWY
	ExkoxJpYVlyZe4hRkoNJSZS3oj0qUIgvKT+lMiOxOCO+qDQntfgQowQHs5II71ZdoBxvSmJl
	VWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFqEUxWhoNDSYLXvAeoUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4Uq/HFwGgFSfEA7fUGaectLkjMBYpCtJ5i1OXoWvT5FaMQS15+
	XqqUOK8nSJEASFFGaR7cClhaesUoDvSxMK8HSBUPMKXBTXoFtIQJaMmyW+EgS0oSEVJSDYwx
	L4yTwjJTlvbmeunZcO/6kMgpuFPuUcZHXXfdqG3TCjSqGI686GbRXLrKQ54hdsX37LT5vizd
	bqWxhW6NDdJLndW5zkelxH8+PHOyv0LmHbZdC+OC21au+qVyNOZ7KP8eSc26c4Y1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219752>

On 04/01/2013 06:56 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Because the primary use case of this option is to implement end-user
>> input validation, I think it would be helpful to clarify use of the
>> peeler here.  Perhaps
>> ...
> 
> A "SQUASH???" patch on top of your original is queued on 'pu',
> together with the earlier "^{object}" peeler patch.  Comments,
> improvements, etc. would be nice.

Yes, your version is better.  I would make one change, though.  In your

+	Make sure the single given parameter can be turned into a
+	raw 20-byte SHA-1 that can be used to access the object
+	database, and emit it to the standard output. If it can't,
+	error out.

it could be made clearer that exactly one parameter should be provided.
 Maybe

+	Verify that exactly one parameter is provided, and that it
+       can be turned into a raw 20-byte SHA-1 that can be used to
+	access the object database.  If so, emit the SHA-1 to the
+	standard output; otherwise, error out.

But this makes it sound a little like the "raw 20-byte SHA-1" will be
output to stdout, whereas both the input and the output are in fact
40-character hex-encoded SHA-1s.  Perhaps a further change

    s/raw 20-byte SHA-1/full SHA-1/

would avoid the false implication?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
