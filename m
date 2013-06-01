From: "Nicolas Richard" <theonewiththeevillook@yahoo.fr>
Subject: git fetch documentation
Date: Sat, 01 Jun 2013 13:04:40 +0200
Message-ID: <87sj12rt13.fsf@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 13:10:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UijhL-0004nb-SK
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 13:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242Ab3FALKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 07:10:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:33771 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485Ab3FALKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 07:10:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UijhD-0004kr-Uk
	for git@vger.kernel.org; Sat, 01 Jun 2013 13:10:03 +0200
Received: from geodiff-mac3.ulb.ac.be ([164.15.131.113])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 13:10:03 +0200
Received: from theonewiththeevillook by geodiff-mac3.ulb.ac.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 13:10:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: geodiff-mac3.ulb.ac.be
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:O6zXBz4h5e2pwItgX6QN9GwBX/A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226122>

Hello,

Regarding the git-fetch man page (IIUC, in pull-fetch-param.txt), in
particular the <refspec> explanation, I feel that two facts are missing:

- A '*' can be used both in src and dest, and it matches any name,
  including subdirectories, but not partial names (i.e. refs/heads/foo*
  is invalid).
- multiple fetch lines can be given in .git/config, each of them will be
  obeyed

These are probably obvious for most users, but I think documenting them
would be good for newcomers. (I tried to come up with a patch but I
can't find a precise yet concise way to explain the role of '*' in
english.)

-- 
Nico.
