From: Ben Hoskings <ben@hoskings.net>
Subject: Re: [RFC/PATCH] Proof-of-concept streamed hashing, demoed in `git hash-object`
Date: Wed, 18 Feb 2009 01:03:19 +1000
Message-ID: <35E0E6CA-22F0-4995-B942-46B630146506@hoskings.net>
References: <0984029E-57D0-4EFA-A060-E0B6FFA77D58@hoskings.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 16:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZRVK-0004AX-69
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbZBQPD2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2009 10:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbZBQPD2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:03:28 -0500
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49446 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbZBQPD1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 10:03:27 -0500
Received: from ppp118-208-44-248.lns3.bne1.internode.on.net ([118.208.44.248] helo=[10.0.1.2])
	by mho-01-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <ben@hoskings.net>)
	id 1LZRTp-000BVN-KC
	for git@vger.kernel.org; Tue, 17 Feb 2009 15:03:26 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 118.208.44.248
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18bSJNbFmpA4fyN+ZRJgDpA
In-Reply-To: <0984029E-57D0-4EFA-A060-E0B6FFA77D58@hoskings.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110394>

On 18/02/2009, at 12:31 AM, Ben Hoskings wrote:

> Hi folks,
>
> This patch adds a proof-of-concept implementation of streaming SHA1 =20
> calculation in sha1_file.c, as demoed with `git hash-object <large =20
> input file>`. Instead of the command's memory footprint being equal =20
> to the input file's size, this caps it at SHA1_CHUNK_SIZE (currently =
=20
> 64MB).

Argh, sorry=97the patch was somehow corrupted; the single spaces at the=
 =20
start of the surrounding lines of each hunk became double spaces. I'm =20
not sure what's happening there.

Here's the commit on GitHub for anyone who would like to apply the =20
patch.

http://github.com/benhoskings/git/commit/33b3d26ca40becf00f57008ef9d215=
d9287fb8e8

Cheers
Ben
