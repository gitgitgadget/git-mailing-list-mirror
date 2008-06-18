From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: [JGIT] fnmatch Implementation.
Date: Wed, 18 Jun 2008 12:12:50 +0200
Message-ID: <4858DFA2.30203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	galder.zamarreno@redhat.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 12:14:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ugA-0007P8-Hi
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 12:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbYFRKNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 06:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbYFRKNG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 06:13:06 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:38642 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbYFRKNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 06:13:04 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 30FCAE47BB17;
	Wed, 18 Jun 2008 12:13:03 +0200 (CEST)
Received: from [84.150.114.112] (helo=[192.168.1.50])
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K8uf0-0002u8-00; Wed, 18 Jun 2008 12:13:03 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX1+9/SFIBfHOZJrbosvuqGk6inmDTiBxJ3l14iRv
	HPRM6UjOQ2hkksWzzJNXZReDeU7i7PKz2cDSUCA/mKa2+MqJQW
	IEfdgpDEUL6vOarE7oDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85371>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

when I send a large list of patches and one is wrong then you don't
accept any. That's why I now will try to get one patch in before I send
the next one.

The first patch I will commit this way is the fnmatch patch.

As suggested by Robin I replaced unicode characters not included in the
ASCII set with \uXXXX sequences.

I also added some more test cases and improved the javadoc of the
FileNameMatcher class.

Best regards,
Florian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIWN+i59ca4mzhfxMRAu8oAJ44Vjp0jvzfjRPRqVoDsUyypNVbvQCgoZRX
GK9kaAlh+Zu3nFen30tc7Rc=
=pvuB
-----END PGP SIGNATURE-----
