From: Mike Hommey <mh@glandium.org>
Subject: Re: Allowing push --dry-run through fetch url
Date: Fri, 6 Nov 2009 09:59:17 +0100
Message-ID: <20091106085917.GA497@glandium.org>
References: <20091106073707.GA14881@glandium.org>
 <7vtyx82g2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 09:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6KfX-0003IL-VZ
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 09:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbZKFI7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 03:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbZKFI7b
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 03:59:31 -0500
Received: from vuizook.err.no ([85.19.221.46]:37532 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755242AbZKFI7a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 03:59:30 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N6KfJ-0003Rm-Pa; Fri, 06 Nov 2009 09:59:32 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N6Kf7-00008E-K0; Fri, 06 Nov 2009 09:59:17 +0100
Content-Disposition: inline
In-Reply-To: <7vtyx82g2a.fsf@alter.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132287>

On Fri, Nov 06, 2009 at 12:49:49AM -0800, Junio C Hamano wrote:
> The daemon sitting on the other end to serve "git://" URL won't understand
> an attempt to push into.  What goes over the wire in the fetch protocol
> does not give your updated "git push" enough information to guess what
> would happen if you pushed.

Maybe I'm missing something, but the only missing thing I can see at
first thought is whether the server is going to reject non fast-forward
updates. Are there any others ?

Mike
