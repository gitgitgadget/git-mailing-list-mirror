From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Feature request: option to not fetch tags for 'git remote' branches
Date: Sat, 27 Mar 2010 20:25:15 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2010-03-27-20-25-15+trackit+sam@rfc1149.net>
References: <201003242154.29245.elendil@planet.nl>
	<4BAA7F5B.2040400@feurix.com> <201003242246.16286.elendil@planet.nl>
	<2010-03-27-20-10-25+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: John Feuerstein <john@feurix.com>, git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sat Mar 27 20:25:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvbdW-00040Z-2a
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab0C0TZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:25:18 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:45309 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab0C0TZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:25:17 -0400
Received: from localhost (unknown [IPv6:2001:6f8:37a:2:211:2fff:fe8a:af74])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id DB32415F05;
	Sat, 27 Mar 2010 20:25:15 +0100 (CET)
In-Reply-To: <2010-03-27-20-10-25+trackit+sam@rfc1149.net> (Samuel Tardieu's
	message of "Sat, 27 Mar 2010 20:10:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143346>

>>>>> "Sam" == Samuel Tardieu <sam@rfc1149.net> writes:

Sam> Add a '--no-tags' option to 'git remote add' which adds a
Sam> 'remote.REMOTE.tagopt = --no-tags' to the configuration file.

Sam> 'git add -f -n REMOTE' will create a new remote and fetch from it
Sam> without importing the tags. Subsequent 'git fetch REMOTE' will also
Sam> not import the tags.

Sam> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

I didn't notice that the subject was not appropriate. One can use:

remote add: add a --no-tags (-n) option
