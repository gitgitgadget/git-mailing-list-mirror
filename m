From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy config option is not set
Date: Sun, 11 Mar 2012 12:56:53 -0400
Message-ID: <m3pqcjt6s2.fsf@carbon.jhcloos.org>
References: <4F4CCE8A.4010800@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, sam.vilain@catalyst.net.nz,
	sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Sun Mar 11 18:12:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6mK4-0000vz-Ql
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 18:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553Ab2CKRMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 13:12:40 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:53498 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab2CKRMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 13:12:39 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Mar 2012 13:12:39 EDT
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 7692D401B9; Sun, 11 Mar 2012 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1331485444;
	bh=trQ0nNbOX2bz7an9MH0aH6K+2GIoBUd7YV9XK9YzoLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=qcrrByVCYlBJ1EJ/ZafZaoDyQ0U/Ke0g4JulD5tswAGxqq8wuBRFtCdc2iengWwsj
	 XtIoKnFVLX0dHKpdFYKL+0ZqOKiOBt38HBjgWqJxcf/Rhunx1K+lXgMDRjw9+w4ydj
	 GIt/ewa0u2KygS+qEH7p2KtBjm89won4n3/wQqvs=
Received: by carbon.jhcloos.org (Postfix, from userid 500)
	id 3185136004C; Sun, 11 Mar 2012 16:56:53 +0000 (UTC)
In-Reply-To: <4F4CCE8A.4010800@seap.minhap.es> (Nelson Benitez Leon's message
	of "Tue, 28 Feb 2012 13:54:34 +0100")
User-Agent: Gnus/5.130004 (Ma Gnus v0.4) Emacs/24.0.94 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAACVBMVEX///8ZGXBQKKnCrDQ3
 AAAAJElEQVQImWNgQAAXzwQg4SKASgAlXIEEiwsSIYBEcLaAtMEAADJnB+kKcKioAAAAAElFTkSu
 QmCC
Copyright: Copyright 2012 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:30:120311:nelsonjesus.benitez@seap.minhap.es::QKl0/uJV8YnIivRw:000000000000000000000000001sI8d
X-Hashcash: 1:30:120311:git@vger.kernel.org::QWdlDhK+2kLqET5U:00000000000000000000000000000000000000000XTRoZ
X-Hashcash: 1:30:120311:peff@peff.net::L2jAozLcPvcYI35i:000FhuYd
X-Hashcash: 1:30:120311:sam.vilain@catalyst.net.nz::RySQDtkKSHN8oM7+:0000000000000000000000000000000000e5rWM
X-Hashcash: 1:30:120311:sam@vilain.net::5/O3VSS/Hm15MTv5:007ix5O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192816>

Please include a way, eg via ~/.gitconfig, to ignore any http_proxy in
the environment and connect directly.

The proxy might exist solely to aggregate a cache and not as a necessary
link to the outside; forcing git to use it in such cases is more harmful
than beneficial.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
