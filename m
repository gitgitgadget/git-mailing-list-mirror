From: Mike Hommey <mh@glandium.org>
Subject: Re: git rebase -i <first_commit_in_repository>
Date: Mon, 26 Oct 2009 18:24:12 +0100
Message-ID: <20091026172412.GA30467@glandium.org>
References: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: eschvoca <eschvoca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 18:24:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2TIv-0002sq-Rn
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 18:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbZJZRYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 13:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbZJZRYQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 13:24:16 -0400
Received: from vuizook.err.no ([85.19.221.46]:40731 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbZJZRYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 13:24:15 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N2TIl-0005QP-II; Mon, 26 Oct 2009 18:24:18 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N2TIi-0007vc-KP; Mon, 26 Oct 2009 18:24:12 +0100
Content-Disposition: inline
In-Reply-To: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131256>

On Mon, Oct 26, 2009 at 01:14:47PM -0400, eschvoca wrote:
> Hi,
> 
> Is there a way to rewrite history, including the first commit.  It
> seems that the first commit can not be modified with a rebase.

Unfortunately, there is no way to do so, except by hand, by checking out
the first commit, amend it, and then rebase.

Mike
