From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Proposal for git stash rename
Date: Wed, 09 Jan 2013 09:38:16 +0100
Message-ID: <50ED2C78.1030300@alum.mit.edu>
References: <20100620093142.GF24805@occam.hewgill.net> <AANLkTimjEksHI4nlefqmNzdNiseVyMQcw312g2AHFQDZ@mail.gmail.com> <20100620111112.GH24805@occam.hewgill.net> <loom.20130104T192132-16@post.gmane.org> <7vbod4tynt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Micheil Smith <micheil@brandedcode.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsrBJ-0006Aw-SL
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab3AIIiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:38:21 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:63102 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817Ab3AIIiU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jan 2013 03:38:20 -0500
X-AuditID: 1207440c-b7f196d0000008bc-0d-50ed2c7c9022
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 26.44.02236.C7C2DE05; Wed,  9 Jan 2013 03:38:20 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r098cH2s031964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Jan 2013 03:38:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vbod4tynt.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqFuj8zbAoO0lh0XXlW4mi4beK8wW
	3xrPMDowe1xbupPN4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDOWbXQseMZe8fbSHMYGxoVs
	XYycHBICJhIPD65nhLDFJC7cWw8WFxK4zCjxtU+xi5ELyD7GJLFr/1RWkASvgLbE3IdbwIpY
	BFQlXk68xAJiswnoSizqaWYCsUUFAiQWLznHDlEvKHFy5hOwGhEBNYmJbYfAbGYBB4kbU1eC
	zRQW0JJYcH09C8Tiz4wST6cFg9icAmYSk988Y4Wo15F41/eAGcKWl9j+dg7zBEaBWUhWzEJS
	NgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYIYHLs4Px2zqZQ4wC
	HIxKPLxWM98ECLEmlhVX5h5ilORgUhLl3av5NkCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO9d
	b6By3pTEyqrUonyYlDQHi5I4r+oSdT8hgfTEktTs1NSC1CKYrAwHh5IE7wZtoKGCRanpqRVp
	mTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoDiNLwZGKkiKB2ivE0g7b3FBYi5QFKL1FKMux62G
	m08ZhVjy8vNSpcR520GKBECKMkrz4FbA0tQrRnGgj4V5PUGqeIApDm7SK6AlTEBL5kwFea64
	JBEhJdXAOLFfi8P0wNmTWcuqVt0qyIk7HSb8wGYP90vLybNTa1hl+Es3llmvsLl2q8rPfPu5
	goB+ht+BGl/rec01dh2Scby65dkE5fU/pGIPeD2Y0JK08dR54Y+nGv5f+DXF6m2r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213052>

On 01/04/2013 10:40 PM, Junio C Hamano wrote:
> Micheil Smith <micheil@brandedcode.com> writes:
> 
>>> This patch implements a "git stash rename" using a new
>>> "git reflog update" command that updates the message associated
>>> with a reflog entry.
>> ...
>> I note that this proposal is now two years old. A work in progress patch was 
>> requested, however, after one was given this thread ended. I'm also finding 
>> a need for this feature;
> 
> The whole point of reflog is that it is a mechanism to let users to
> go safely back to the previous state, by using a file that is pretty
> much append-only.  It feels that a mechanism to "rewrite" one goes
> completely against that principle, at least to me.

The implementation of "git stash" itself seems to violate your
principle, by storing its branches-that-are-not-branches within a
mutable reflog.

Just an observation...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
