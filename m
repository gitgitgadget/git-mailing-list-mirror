From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: PATCH:  Less fragile lookup of gpg key
Date: Mon, 3 May 2010 07:16:55 -0400
Message-ID: <BA24F2BF-018D-403B-A23B-0F2E57A7C00A@mit.edu>
References: <4BDC45EB.8090305@grant-olson.net> <4BDC561B.4030307@gmail.com> <7vhbmr5ym4.fsf@alter.siamese.dyndns.org> <4BDC63FB.7060202@grant-olson.net> <7v7hnn4cun.fsf@alter.siamese.dyndns.org> <m1O8k0Z-000kndC@most.weird.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 03 13:17:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8te7-0001rO-DV
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 13:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757820Ab0ECLQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 07:16:58 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:46957 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757791Ab0ECLQ5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 May 2010 07:16:57 -0400
X-AuditID: 1209190e-b7b82ae000005260-4f-4bdeb0a9029e
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 9E.63.21088.9A0BEDB4; Mon,  3 May 2010 07:16:57 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o43BGuiA020713;
	Mon, 3 May 2010 07:16:56 -0400
Received: from [10.0.42.108] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o43BGth4014837
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 3 May 2010 07:16:56 -0400 (EDT)
In-Reply-To: <m1O8k0Z-000kndC@most.weird.com>
X-Mailer: Apple Mail (2.1078)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146227>


On May 2, 2010, at 8:59 PM, Greg A. Woods wrote:

> I'm not an expert on PGP internals or such, but I think that's a really
> bad thing to do.  I'm surprised you were able to get gpg to do it in the
> first place.  I would have hoped it wouldn't allow it.  As far as I can
> tell it's _not_ compatible with other implementations of PGP.

> You can of course have more than one e-mail address per key, but you
> should NEVER have more than one key per e-mail.

This is pretty common actually.  At the very least it will happen if people are trying to transition between an older and a newer key --- for example, if they are trying to move from a less secure crypto algorithm to a more secure crypto algorithm.

And most versions of PGP support it _just_ _fine_.

They may not pick the key I want, but that's why I have environment or config files set up in various programs which use PGP to use a specific PGP KeyID.

-- Ted
