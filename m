From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/8] wrap_in_html(): process message in bulk rather than
 line-by-line
Date: Fri, 30 Nov 2012 14:40:10 +0100
Message-ID: <50B8B73A.4060801@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu> <1353841721-16269-9-git-send-email-mhagger@alum.mit.edu> <7v7gp4p00u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080703050107010408090706"
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 14:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeQpW-00025E-1D
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 14:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954Ab2K3NkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 08:40:15 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:51623 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932176Ab2K3NkO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2012 08:40:14 -0500
X-AuditID: 1207440c-b7f196d0000008bc-be-50b8b73dcbb5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 83.4E.02236.D37B8B05; Fri, 30 Nov 2012 08:40:13 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAUDeAF3005179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 30 Nov 2012 08:40:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7v7gp4p00u.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsUixO6iqGu7fUeAweSbIhZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8WPlh5mB1aPL1cbmTw+fIzzeNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M04eWchc8FKw4nCXeQPjEb4uRk4OCQETiQXLH7BB2GISF+6tB7K5OIQELjNKvDt7jhXC
	Oc4kMevlI2aQKl4BbYmZq/axg9gsAqoSe+70MoHYbAK6Eot6msFsUYEAicVLzrFD1AtKnJz5
	hAXEFhFQk5jYdogFZCizwFxGid9/Z4ENFRaIlujvfwK1bTmjxKn7P1lBEpwCZhLXZlwGm8oM
	NHXdk2a2CYz8s5AMnoUkBWHrSLzre8AMYctLbH87B8p2kVi+6jgbprivxPUdu1gWMLKvYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFLTSndxAiJFp4djN/WyRxiFOBgVOLh9ViwPUCI
	NbGsuDL3EKMkB5OSKO+frTsChPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw/t0IlONNSaysSi3K
	h0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfBqbgNqFCxKTU+tSMvMKUFIM3Fwggzn
	khIpTs1LSS1KLC3JiAdFfXwxMO5BUjxAex1B2nmLCxJzgaIQracYdTk2rG9/wijEkpeflyol
	zssNUiQAUpRRmge3ApYaXzGKA30szKsLUsUDTKtwk14BLWECWvJm2XaQJSWJCCmpBkZN9+aY
	J/HG3wSmPnrPsMovxEKxRchgZsuPgGvM3+6F9dTKGG/fZf1/Sf1L1W+JCy00pjx9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210926>

This is a multi-part message in MIME format.
--------------080703050107010408090706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/29/2012 10:33 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Now that we can xml-quote an arbitrary string in O(N), there is no
>> reason to process the message line by line.  This change saves lots of
>> memory allocations and copying.
>>
>> The old code would have created invalid output for a malformed input
>> message (one that does not contain a blank line separating the header
>> from the body).  The new code die()s in this situation.
> 
> Given that imap-send is about sending a patch the distinction would
> not matter in practice, but isn't the difference between the two
> that the new version would not allow sending a header-only message
> without a body, while the old one allowed it?

I was thinking that the end-of-header line is a required part of an
RFC2282 email message, but I was wrong.  If you squash the attached
patch onto this commit, it will handle emails without bodies correctly.

Nevertheless, the old code was even *more* broken because it added a
"</pre>" regardless of whether the separator line had been seen, and
therefore a message without an end-of-header line would come out like

    Header1: foo
    Header2: bar
    </pre>

with no content_type line, no pre_open, and </pre> appended to the
header without a blank line in between.  This is the "invalid output"
that I was referring to.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------080703050107010408090706
Content-Type: text/x-patch;
 name="addstr-xml-quoted-addendum.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="addstr-xml-quoted-addendum.diff"

diff --git a/imap-send.c b/imap-send.c
index eec9e35..e521e2f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1348,7 +1348,7 @@ static void wrap_in_html(struct strbuf *msg)
 	const char *body = strstr(msg->buf, "\n\n");
 
 	if (!body)
-		die("malformed message");
+		return; /* Headers but no body; no wrapping needed */
 
 	body += 2;
 

--------------080703050107010408090706--
