From: Jeff King <peff@peff.net>
Subject: Re: Help a sed noob
Date: Sat, 4 Aug 2007 07:50:03 -0400
Message-ID: <20070804115003.GA9716@coredump.intra.peff.net>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com> <20070804103126.GA28402@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 13:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHI93-00053E-3a
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 13:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbXHDLuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 07:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbXHDLuG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 07:50:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2437 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbXHDLuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 07:50:05 -0400
Received: (qmail 29419 invoked from network); 4 Aug 2007 11:50:08 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 4 Aug 2007 11:50:08 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2007 07:50:03 -0400
Content-Disposition: inline
In-Reply-To: <20070804103126.GA28402@lapse.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54829>

On Sat, Aug 04, 2007 at 12:31:26PM +0200, martin f krafft wrote:

> also sprach Nguyen Thai Ngoc Duy <pclouds@gmail.com> [2007.08.04.0122 +0200]:
> >                 sed -ne '/^URL: */{
> >                         s///p
> >                         q
> >                 }' "$GIT_DIR/remotes/$1"
> 
> Looks like it prints the first matching line:
> 
>   grep '^URL: *' | head -1

No, it prints everything _except_ "URL: *" from the first matching line.

-Peff
