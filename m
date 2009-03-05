From: Jeff King <peff@peff.net>
Subject: Re: ignored files stilll listed in git ls-files
Date: Thu, 5 Mar 2009 04:09:54 -0500
Message-ID: <20090305090953.GB30445@coredump.intra.peff.net>
References: <53e35fd50903041731v1a3c10c9sbb9295f322a819ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Shen <davidshen84@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:11:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9cD-0005fw-DG
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbZCEJKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 04:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbZCEJKF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:10:05 -0500
Received: from peff.net ([208.65.91.99]:60772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbZCEJKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:10:03 -0500
Received: (qmail 29271 invoked by uid 107); 5 Mar 2009 09:10:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 04:10:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 04:09:54 -0500
Content-Disposition: inline
In-Reply-To: <53e35fd50903041731v1a3c10c9sbb9295f322a819ce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112275>

On Thu, Mar 05, 2009 at 09:31:55AM +0800, David Shen wrote:

> I add all the files to git before I learned the .gitignore file. Then
> I remove those unwanted files from the index. But those files still
> appear in git ls-files. This is really annoying. Is there any want to
> prevent those ignored files from git ls-files?

If they are appearing in "git ls-files", then you didn't actually remove
them from the index. Can you show us exactly which commands you ran,
what output they produced, and how it differs from what you expected?

-Peff
