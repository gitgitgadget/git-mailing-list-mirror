From: Mike Hommey <mh@glandium.org>
Subject: Re: is gitosis secure?
Date: Mon, 15 Dec 2008 08:17:37 +0100
Organization: glandium.org
Message-ID: <20081215071737.GA32387@glandium.org>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <4944D4F7.7050501@siamect.com> <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm> <4944E7E1.2030907@siamect.com> <alpine.DEB.1.10.0812141655150.17688@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin <martin@siamect.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Dec 15 08:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC8JK-0006Yl-9p
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 08:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbYLOHy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 02:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYLOHy4
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 02:54:56 -0500
Received: from vuizook.err.no ([194.24.252.247]:38940 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYLOHy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 02:54:56 -0500
X-Greylist: delayed 2401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Dec 2008 02:54:56 EST
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LC7fB-0004Wf-Ne; Mon, 15 Dec 2008 08:14:48 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LC7hx-0000Qp-5p; Mon, 15 Dec 2008 08:17:37 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0812141655150.17688@asgard.lang.hm>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103137>

On Sun, Dec 14, 2008 at 05:00:14PM -0800, david@lang.hm wrote:
> 1. if you are running multiple different applications that all want to be 
> exposed via port 22 (like git for 'git push') then you may need to expose 
> numerous machines. tools that use SSH don't tend to have the ability to  
> use a gateway box before they start executing commands, they assume that  
> you will SSH directly into the destination box.

But ssh itself allows you to do proxying. See ProxyCommand in
ssh_config's manpage.

Mike
