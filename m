From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Anomalous AUTHOR and DOCUMENTATION sections in manpages
Date: Wed, 22 Jan 2014 12:22:23 +0100
Message-ID: <52DFA9EF.4080309@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Jan 22 12:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5vtD-0001mJ-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 12:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbaAVLWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 06:22:32 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57619 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753600AbaAVLWb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 06:22:31 -0500
X-AuditID: 12074411-b7f426d000005455-99-52dfa9f63851
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id AD.52.21589.6F9AFD25; Wed, 22 Jan 2014 06:22:30 -0500 (EST)
Received: from [192.168.69.148] (p57A248A5.dip0.t-ipconnect.de [87.162.72.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0MBMOT5007570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Jan 2014 06:22:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqPtt5f0gg2UvBSy6rnQzWTT0XmG2
	WLlmD7PFvLu7mCz6l3exWby9uYTRonvKW0aL+YcmsjpweKw8W+uxc9Zddo8PH+M8Lr38zuZx
	8ZKyx5/ze1g9Pm+SC2CP4rZJSiwpC85Mz9O3S+DOODRpDXvBBq6K6y0nmRoYz3N0MXJySAiY
	SKz8d5MNwhaTuHBvPZDNxSEkcJlR4mrrCVYI5zyTxKP574EyHBy8AtoSK6aZgjSwCKhK9Ox8
	BdbMJqArsainmQnEFhUIllh9+QELiM0rIChxcuYTMFsEqGbXs6tg9cwCLcwSk94agNjCAg4S
	f47dYwUZLyEgLtHTGARiMguoS6yfJwRRLS+x/e0c5gmM/LOQDJ2FUDULSdUCRuZVjHKJOaW5
	urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCEhL7iDccZJuUOMAhyMSjy8AbvuBQmxJpYV
	V+YeYpTkYFIS5d209H6QEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHehyuAcrwpiZVVqUX5MClp
	DhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCd6LII2CRanpqRVpmTklCGkmDk6Q4VxSIsWp
	eSmpRYmlJRnxoFiMLwZGI0iKB2hvMdje4oLEXKAoROspRl2OFRs+/WEUYsnLz0uVEuedCVIk
	AFKUUZoHtwKW4F4xigN9LMy7B6SKB5gc4Sa9AlrCBLQkess9kCUliQgpqQZGpsmX5q+ZEXDx
	vdQ9jS3Ji//Vva08ciXneJ3PzBgHLnEG14cHX9asm3ZA9+0GpduKEYW3WOdEvP0V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240820>

I just noticed that there are exactly four Git manpages with an "AUTHOR"
section and five with a "DOCUMENTATION" section:

    $ make doc
    $ grep -nIE -e '^\.SH "DOCUMENTATION|AUTHOR"' Documentation/*.[0-9]
    Documentation/git-column.1:80:.SH "AUTHOR"
    Documentation/git-for-each-ref.1:272:.SH "AUTHOR"
    Documentation/git-for-each-ref.1:275:.SH "DOCUMENTATION"
    Documentation/git-http-backend.1:404:.SH "AUTHOR"
    Documentation/git-http-backend.1:407:.SH "DOCUMENTATION"
    Documentation/git-notes.1:395:.SH "AUTHOR"
    Documentation/git-notes.1:398:.SH "DOCUMENTATION"
    Documentation/git-remote-ext.1:133:.SH "DOCUMENTATION"
    Documentation/git-remote-fd.1:71:.SH "DOCUMENTATION"

These sections are inconsistent with the other manpages and seem
superfluous in a project that has, on the one hand, a public history
and, on the other hand, hundreds of contributors.  Would the mentioned
authors (CCed) consent to the removal of these sections?

I don't want to step on any feet here.  If you want to keep these
sections, I have no objection.  But my guess is that people added them
in these few instances without realizing that these sections are not
commonly used in Git documentation.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
