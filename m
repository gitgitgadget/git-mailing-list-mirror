From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] t7502-commit.sh: test_must_fail doesn't work with
	inline environment variables
Date: Thu, 19 Jun 2008 19:39:32 +0200
Organization: glandium.org
Message-ID: <20080619173932.GA32593@glandium.org>
References: <JvISWq5uUteLVQOl-3QkroLV8SsQufGuWrfseMUjpYY@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:41:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9O8U-0001qv-Av
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 19:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbYFSRkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYFSRkK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 13:40:10 -0400
Received: from vuizook.err.no ([194.24.252.247]:42941 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbYFSRkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 13:40:08 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K9O6g-0002cu-0G; Thu, 19 Jun 2008 19:39:40 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K9O6e-0008Ub-P4; Thu, 19 Jun 2008 19:39:32 +0200
Content-Disposition: inline
In-Reply-To: <JvISWq5uUteLVQOl-3QkroLV8SsQufGuWrfseMUjpYY@cipher.nrlssc.navy.mil>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85497>

On Thu, Jun 19, 2008 at 12:32:02PM -0500, Brandon Casey wrote:
> -	test_must_fail GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
> +	# We intentionally do not use test_must_fail on the next line since the
> +	# mechanism does not work when setting environment variables inline
> +	! GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&

Doesn't GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" test_must_fail git commit
work ?

Mike
