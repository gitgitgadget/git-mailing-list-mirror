From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Avoid apache complaining about lack of server's FQDN
Date: Mon, 7 Jul 2008 22:48:51 +0200
Organization: glandium.org
Message-ID: <20080707204851.GA4311@glandium.org>
References: <1215462135-3222-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 07 22:50:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxet-0000O5-Lk
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757558AbYGGUs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 16:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbYGGUs5
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:48:57 -0400
Received: from vuizook.err.no ([194.24.252.247]:52484 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092AbYGGUs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 16:48:56 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KFxdg-0008GV-Ng; Mon, 07 Jul 2008 22:48:54 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KFxdj-0001As-2u; Mon, 07 Jul 2008 22:48:51 +0200
Content-Disposition: inline
In-Reply-To: <1215462135-3222-1-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87652>

On Mon, Jul 07, 2008 at 10:22:15PM +0200, Mike Hommey wrote:
> On some setups, apache will say:
> apache2: Could not reliably determine the server's fully qualified
> domain name, using $(IP_address) for ServerName
> 
> Avoid this message polluting tests output by setting a ServerName in
> apache configuration.

Signed-off-by: Mike Hommey <mh@glandium.org>

for the 3 patches I sent today, obviously...

Mike
