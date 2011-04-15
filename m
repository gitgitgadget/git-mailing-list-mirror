From: Shawn Pearce <spearce@spearce.org>
Subject: Re: capturing the packfile from git-upload-pack
Date: Fri, 15 Apr 2011 11:46:44 -0400
Message-ID: <BANLkTimAt_gcp1uBR_0H7LJHUdFGqHbRvA@mail.gmail.com>
References: <1302837720729-6275146.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: madmarcos <fru574@my.utsa.edu>
X-From: git-owner@vger.kernel.org Fri Apr 15 17:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAlEq-0002dN-6M
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 17:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab1DOPrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 11:47:08 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49929 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab1DOPrF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 11:47:05 -0400
Received: by vxi39 with SMTP id 39so2165469vxi.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 08:47:04 -0700 (PDT)
Received: by 10.52.178.164 with SMTP id cz4mr3227183vdc.42.1302882424053; Fri,
 15 Apr 2011 08:47:04 -0700 (PDT)
Received: by 10.52.164.97 with HTTP; Fri, 15 Apr 2011 08:46:44 -0700 (PDT)
In-Reply-To: <1302837720729-6275146.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171615>

On Thu, Apr 14, 2011 at 23:22, madmarcos <fru574@my.utsa.edu> wrote:
> is there a git command that can capture in a separate file the packfile that
> is generated and transmitted from a "want"ed branch during the
> git-upload-pack command? I need a good sample to study.

No.

But you can create an input file yourself, the pkt-line format is
pretty simple. Pipe the input to git-upload-pack, and it will spit
back the response. :-)

-- 
Shawn.
