From: Mike Hommey <mh@glandium.org>
Subject: fast-import deltas
Date: Tue, 1 Apr 2014 19:25:54 +0900
Message-ID: <20140401102554.GA32231@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 13:05:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUwVp-0008Sq-Ij
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 13:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbaDALFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 07:05:45 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:47826 "EHLO
	zenigata.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095AbaDALFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 07:05:44 -0400
X-Greylist: delayed 2381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Apr 2014 07:05:43 EDT
Received: from glandium by zenigata.glandium.org with local (Exim 4.82)
	(envelope-from <glandium@glandium.org>)
	id 1WUvtC-0008Rd-Ha
	for git@vger.kernel.org; Tue, 01 Apr 2014 19:25:54 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245581>

Hi,

I am currently prototyping a "native" mercurial remote handler for git,
and it seems silly for git to compute deltas itself when I'm getting
deltas from the mercurial remote itself, albeit in a different form.

Would adding a fast-import command to handle deltas be considered useful
for git? If so, what kind of format would be suitable?

Cheers,

Mike
