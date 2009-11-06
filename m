From: Mike Hommey <mh@glandium.org>
Subject: Re: Allowing push --dry-run through fetch url
Date: Fri, 6 Nov 2009 10:21:15 +0100
Message-ID: <20091106092115.GA3449@glandium.org>
References: <20091106073707.GA14881@glandium.org>
 <7vtyx82g2a.fsf@alter.siamese.dyndns.org>
 <20091106085917.GA497@glandium.org>
 <7v4op82fh0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:21:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6L0q-0003hJ-Jh
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 10:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbZKFJV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 04:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbZKFJV0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 04:21:26 -0500
Received: from vuizook.err.no ([85.19.221.46]:58959 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbZKFJVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 04:21:25 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N6L0Z-0004Iw-LJ; Fri, 06 Nov 2009 10:21:30 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N6L0N-0000to-E6; Fri, 06 Nov 2009 10:21:15 +0100
Content-Disposition: inline
In-Reply-To: <7v4op82fh0.fsf@alter.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132289>

On Fri, Nov 06, 2009 at 01:02:35AM -0800, Junio C Hamano wrote:
> > Maybe I'm missing something, but the only missing thing I can see at
> > first thought is whether the server is going to reject non fast-forward
> > updates. Are there any others ?
> 
> Hooks, for a starter.

AFAICS, they are not run when using --dry-run.

Mike
