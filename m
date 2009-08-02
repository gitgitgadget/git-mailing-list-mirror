From: skillzero@gmail.com
Subject: Re: git show on bare repository?
Date: Sat, 1 Aug 2009 23:08:15 -0700
Message-ID: <2729632a0908012308t48623e42nc1222d9c2afd2fc8@mail.gmail.com>
References: <2729632a0908012051i28654bb7m418ff2ed00138815@mail.gmail.com>
	 <20090802044402.GA21369@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 02 08:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXUF8-00057i-EJ
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 08:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbZHBGIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 02:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbZHBGIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 02:08:16 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:45098 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZHBGIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 02:08:15 -0400
Received: by qyk34 with SMTP id 34so2336931qyk.33
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 23:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UqaFwJI6qVRxhpowSCXe5fKzwCZf9obucDpm0/hJUzw=;
        b=BtR/m5IzJpcvd07G5Lh4islvU9IN5Q+0z2RJ7DpeuIS8NdfC65D8M6oaJP6oCpSjxQ
         FZuTwD5hEAd1vRrGW3aSLkc3HOf2S1s1pN96RdLYRNXN6UMxdgXjQTz8sSfcuRpCz557
         D1JLp8AV6sBwASSHJT7LvjNVKAPtEpnKBkzRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DynYQqKZ0L7Rd1YcpZFMWsPuuPvttlnz+9c+LwYZPZmUy+FIrLYyp/F3A5hHhsXw1Z
         1FCDc5mnJq6d4UI8+dlY4jNH7/k/MYrmxzQTiUmNIKfkRjRO6CwpMI8befrqFGiGI+Sn
         Yp39ody7Wc0U3ASfAkXwh+UDVQmJ13+N48/kc=
Received: by 10.224.2.77 with SMTP id 13mr3580254qai.121.1249193295687; Sat, 
	01 Aug 2009 23:08:15 -0700 (PDT)
In-Reply-To: <20090802044402.GA21369@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124666>

On Sat, Aug 1, 2009 at 9:44 PM, Jeff King<peff@peff.net> wrote:
> Either you don't have a 'master' ref, or the commit there doesn't have
> 'file.txt'. Try "git show master" and "git show master^{tree}" to see
> which.

It turns out the file just didn't exist because the repository is at a
slight different path.

Thanks for the help. I didn't know about the ^{tree} thing.
