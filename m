From: Mike Hommey <mh@glandium.org>
Subject: Re: Allowing push --dry-run through fetch url
Date: Fri, 6 Nov 2009 10:53:57 +0100
Message-ID: <20091106095357.GA13389@glandium.org>
References: <20091106073707.GA14881@glandium.org>
 <7vfx8s0yy1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6LWb-0008Cs-CY
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 10:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566AbZKFJyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 04:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756341AbZKFJyM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 04:54:12 -0500
Received: from vuizook.err.no ([85.19.221.46]:59584 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756180AbZKFJyK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 04:54:10 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N6LWD-0005JV-Po; Fri, 06 Nov 2009 10:54:12 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N6LW1-00078o-Cd; Fri, 06 Nov 2009 10:53:57 +0100
Content-Disposition: inline
In-Reply-To: <7vfx8s0yy1.fsf@alter.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132293>

On Fri, Nov 06, 2009 at 01:44:54AM -0800, Junio C Hamano wrote:
<snip>
> But doesn't "branch -v" give the necessary information for that purpose
> and even a bit more?  Couldn't "git fetch && git branch -v" be a better
> solution for your real problem "X"?

Usually, when I run git push --dry-run, it's to check that what follows
(usually the refspec part) does what I want it to do, such as not pushing
tags I didn't intend to push(*), and stuff like that.

Mike

(*) the fact that all tags from all remotes are being mixed doesn't help,
here, and without dry-running, I end up pushing tags from one remote onto
another.
