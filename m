From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Anomalous AUTHOR and DOCUMENTATION sections in manpages
Date: Wed, 22 Jan 2014 22:41:49 +0100
Message-ID: <52E03B1D.4060207@alum.mit.edu>
References: <52DFA9EF.4080309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 22:42:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W65Yf-0005RQ-Jn
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 22:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbaAVVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 16:41:57 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43654 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527AbaAVVlz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 16:41:55 -0500
X-AuditID: 1207440c-b7f566d000004272-86-52e03b22ebdd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 20.A9.17010.22B30E25; Wed, 22 Jan 2014 16:41:54 -0500 (EST)
Received: from [192.168.69.148] (p57A248A5.dip0.t-ipconnect.de [87.162.72.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0MLfoTK004117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Jan 2014 16:41:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <52DFA9EF.4080309@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsUixO6iqKtk/SDIYOdzTYuuK91MFg29V5gt
	Vq7Zw2wx7+4uJov+5V1sFm9vLmG06J7yltFi/qGJrA4cHivP1nrsnHWX3ePDxziPSy+/s3lc
	vKTs8ef8HlaPz5vkAtijuG2SEkvKgjPT8/TtErgzfnS9ZS64xl1xtaeNsYHxOGcXIweHhICJ
	xNE1Dl2MnECmmMSFe+vZuhi5OIQELjNKHFw5hQXCOc8kcW3/dBaQKl4BbYmGiQeYQGwWAVWJ
	2/8+sIPYbAK6Eot6msHiogLBEqsvP4CqF5Q4OfMJmC0CVLPr2VU2EJtZoIVZYtJbAxBbWMBF
	4v2DmYwgthDQ/LbeM2BzOAV0JNbf6WGFOFRcoqcxCMRkFlCXWD9PCGKKvMT2t3OYJzAKzkKy
	bBZC1SwkVQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihMQIzw7Gb+tk
	DjEKcDAq8fByfrofJMSaWFZcmXuIUZKDSUmUt9bsQZAQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed5lxkA53pTEyqrUonyYlDQHi5I4r+oSdT8hgfTEktTs1NSC1CKYrAwHh5IE72tLoEbBotT0
	1Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UOzGFwOjFyTFA7RX0Apkb3FBYi5QFKL1FKMu
	x4oNn/4wCrHk5eelSonzfgPZIQBSlFGaB7cClhBfMYoDfSzM+w+kigeYTOEmvQJawgS0JHrL
	PZAlJYkIKakGxgBvi4V98g5swUynOFodZm1fOO3nWeu10oxe3Fppm9KnvhPc8JI/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240863>

On 01/22/2014 12:22 PM, Michael Haggerty wrote:
> I just noticed that there are exactly four Git manpages with an "AUTHOR"
> section and five with a "DOCUMENTATION" section:
> 
>     $ make doc
>     $ grep -nIE -e '^\.SH "DOCUMENTATION|AUTHOR"' Documentation/*.[0-9]
>     Documentation/git-column.1:80:.SH "AUTHOR"
>     Documentation/git-for-each-ref.1:272:.SH "AUTHOR"
>     Documentation/git-for-each-ref.1:275:.SH "DOCUMENTATION"
>     Documentation/git-http-backend.1:404:.SH "AUTHOR"
>     Documentation/git-http-backend.1:407:.SH "DOCUMENTATION"
>     Documentation/git-notes.1:395:.SH "AUTHOR"
>     Documentation/git-notes.1:398:.SH "DOCUMENTATION"
>     Documentation/git-remote-ext.1:133:.SH "DOCUMENTATION"
>     Documentation/git-remote-fd.1:71:.SH "DOCUMENTATION"
> 
> These sections are inconsistent with the other manpages and seem
> superfluous in a project that has, on the one hand, a public history
> and, on the other hand, hundreds of contributors.  Would the mentioned
> authors (CCed) consent to the removal of these sections?
> 
> I don't want to step on any feet here.  If you want to keep these
> sections, I have no objection.  But my guess is that people added them
> in these few instances without realizing that these sections are not
> commonly used in Git documentation.

Thanks for the quick responses, everybody.  I'll prepare a patch.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
