From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH 1/2] format-patch: Add a signature option (--signature)
Date: Wed, 16 Jun 2010 09:13:09 -0400
Message-ID: <DB1710D5-1699-45C2-8884-5D60C5240ED9@mit.edu>
References: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 15:13:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOsQj-0004cx-8t
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 15:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab0FPNNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 09:13:15 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:56946 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478Ab0FPNNO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jun 2010 09:13:14 -0400
X-AuditID: 12074422-b7b3aae000000a51-75-4c18cde9c85c
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id B0.39.02641.9EDC81C4; Wed, 16 Jun 2010 09:13:13 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o5GDDC39022692;
	Wed, 16 Jun 2010 09:13:12 -0400
Received: from [10.0.42.106] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o5GDDAu8003736
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 16 Jun 2010 09:13:11 -0400 (EDT)
In-Reply-To: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
X-Mailer: Apple Mail (2.1078)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149260>


On Jun 15, 2010, at 1:00 AM, Stephen Boyd wrote:

> 
> This does modify the original behavior of format-patch a bit. First
> off the version string is now placed in the cover letter by default.

I don't know how important people will feel this to be, but I've occasionally
found it interesting to see how many people are using various different
versions of git in a particular development community, and having the
version in the signature is a useful gauge on that.  Putting it in the cover
letter isn't really a complete substitute for this because many patches
and short patch series go out without cover letters...

-- Ted
