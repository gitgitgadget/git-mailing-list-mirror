From: Jeff King <peff@peff.net>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 08:49:24 -0400
Message-ID: <20090819124924.GD20381@coredump.intra.peff.net>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
 <m3ab1wnsie.fsf@localhost.localdomain>
 <a2db4dd50908190400x1cbb1506sa38c60e31587f49d@mail.gmail.com>
 <200908191418.08838.jnareb@gmail.com>
 <a2db4dd50908190528o7f16b65are1acc89c900f7014@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Rob (gmail)" <robvanb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 14:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdkbd-0000u0-Lt
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 14:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbZHSMtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 08:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbZHSMtX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 08:49:23 -0400
Received: from peff.net ([208.65.91.99]:40883 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbZHSMtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 08:49:22 -0400
Received: (qmail 19500 invoked by uid 107); 19 Aug 2009 12:49:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 19 Aug 2009 08:49:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Aug 2009 08:49:24 -0400
Content-Disposition: inline
In-Reply-To: <a2db4dd50908190528o7f16b65are1acc89c900f7014@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126539>

On Wed, Aug 19, 2009 at 08:28:04AM -0400, Rob (gmail) wrote:

> That seems like the best solution.
> How do I delete my initial repository that I created and obviously
> messed up ?

If you have nothing of value in the whole directory, just "rm -rf repo".
If you want to keep the working tree but delete all of the git bits,
just "rm -rf .git".

-Peff
