From: Mike Hommey <mh@glandium.org>
Subject: Bug in git-verify-pack or in its documentation?
Date: Mon, 16 Mar 2015 17:05:58 +0900
Message-ID: <20150316080558.GA30234@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 09:06:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXQ2O-0004zN-MR
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 09:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbbCPIGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 04:06:07 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:33299 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbbCPIGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 04:06:06 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YXQ2A-00083J-T2
	for git@vger.kernel.org; Mon, 16 Mar 2015 17:05:58 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265549>

Hi,

git-verify-pack's man page says the following about --stat-only:

   Do not verify the pack contents; only show the histogram of delta
   chain length. With --verbose, list of objects is also shown.

However, there is no difference of output between --verbose and
--verbose --stat-only (and in fact, looking at the code, only one of
them has an effect, --stat-only having precedence).

The text above also implies that this should only display the stats
without doing any sha1 validation, but afaict from a quick glance at
the index-pack code, they are always performed.

Is it an implementation problem or a documentation problem?

Cheers,

Mike
