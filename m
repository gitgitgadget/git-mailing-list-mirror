From: Mike Hommey <mh@glandium.org>
Subject: Re: git equivalent to clearcase wink-in
Date: Wed, 20 Jan 2010 22:12:51 +0100
Message-ID: <20100120211251.GA26274@glandium.org>
References: <810256.84037.qm@web45111.mail.sp1.yahoo.com>
 <7938b46a1001201305j499e05bg2654d634d7b26d76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Assal <richard_assal@yahoo.com>, git@vger.kernel.org
To: Jamie Wellnitz <jwellnitz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:13:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhrS-00044u-L3
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116Ab0ATVNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474Ab0ATVNF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:13:05 -0500
Received: from vuizook.err.no ([85.19.221.46]:52603 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754419Ab0ATVM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:12:58 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NXhrA-000378-49; Wed, 20 Jan 2010 22:12:54 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1NXhr9-0006q1-3s; Wed, 20 Jan 2010 22:12:51 +0100
Content-Disposition: inline
In-Reply-To: <7938b46a1001201305j499e05bg2654d634d7b26d76@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137583>

On Wed, Jan 20, 2010 at 04:05:46PM -0500, Jamie Wellnitz wrote:
> Would something like ccache (compiler cache) help you out?  It's not
> the same as wink-in (which, as I understand it, copies an already
> built object file from someone else who has built it).  Instead each
> user has their own cache, so everyone has to pay the expensive build
> price at least once.

Surely the ccache directory could be shared on nfs or some other network
filesystem. Or object file could be checked in, which is imho ugly, but
should work (better to do that on a separate branch)

Mike
