From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Mon, 27 Jan 2014 18:59:54 +0100
Message-ID: <20140127175953.GA18041@camk.edu.pl>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
 <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 19:33:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7qzt-00080b-3e
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 19:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbaA0SdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 13:33:18 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:56342 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbaA0SdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 13:33:18 -0500
X-Greylist: delayed 1991 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jan 2014 13:33:17 EST
Received: from localhost (localhost [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 063715F0005;
	Mon, 27 Jan 2014 19:00:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PFpbxAIVwg64; Mon, 27 Jan 2014 19:00:18 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 859FE5F0001;
	Mon, 27 Jan 2014 19:00:18 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 5164C4812C; Mon, 27 Jan 2014 18:59:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241151>

On Tue, Jan 21, 2014 at 02:14:22PM -0800, Junio C Hamano wrote:
> It has been reported that turning git.rc into git.res does not like
> the new 2-dewey-decimal release numbering scheme; packagers of
> various distro might find similar issues in their build procedures,
> in which case they have about 3 weeks to update them until the final
> release.

The change in release numbering also breaks down gitolite v2 setups. One
of the gitolite commands, gl-compile-conf, expects the output of git --version 
to match /git version (\d+)\.(\d+)\.(\d+)/. 

I have no idea how big problem it is, as I don't know how many people
hasn't migrate to gitolite v3 yet. 

-- 
  Kacper
