From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Use &#160; instead of &nbsp; for XHTML compliance
Date: Wed, 15 Apr 2009 17:50:14 +0200
Message-ID: <20090415155013.GA15518@glandium.org>
References: <20090415154012.GX13966@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Ricky Zhou <ricky@fedoraproject.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 17:52:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7PD-00078Q-3G
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 17:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZDOPu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 11:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZDOPu3
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 11:50:29 -0400
Received: from vuizook.err.no ([85.19.221.46]:44626 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbZDOPu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 11:50:27 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Lu7NQ-0008S4-3R; Wed, 15 Apr 2009 17:50:19 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Lu7NO-00043T-E9; Wed, 15 Apr 2009 17:50:14 +0200
Content-Disposition: inline
In-Reply-To: <20090415154012.GX13966@inocybe.teonanacatl.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116616>

On Wed, Apr 15, 2009 at 11:40:12AM -0400, Todd Zullinger <tmz@pobox.com> wrote:
> From: Ricky Zhou <ricky@fedoraproject.org>
> ---
> 
> This was noticed by the Fedora Infrastructure folks.  The pages
> rendered fine in Firefox, but caused an XML error when run through tor
> and privoxy together.  Part of this problem description may belong in
> the commit message -- I was hesitant to add it, as I didn't read all
> of the IRC log where the problem was noticed and debugged.

&nbsp; is very much xhtml compliant, so the problem must lie somewhere
else, possibly in privoxy.

Mike
