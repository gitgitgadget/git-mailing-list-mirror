From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] RPM spec: include bash completion support
Date: Fri, 26 Mar 2010 13:07:45 +0000
Message-ID: <c23f5db54cc8e5a4a5ee10c6533ac9fb@212.159.54.234>
References: <1269569690-sup-4884@pinkfloyd.chass.utoronto.ca> <1269592797-18487-1-git-send-email-icomfort@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, <git@vger.kernel.org>
To: Ian Ward Comfort <icomfort@stanford.edu>
X-From: git-owner@vger.kernel.org Fri Mar 26 14:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv9GX-0001Ys-GD
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 14:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0CZNHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 09:07:51 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:37346 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753089Ab0CZNHr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 09:07:47 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 3B2FC819A66B;
	Fri, 26 Mar 2010 13:07:44 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 373442072E1;
	Fri, 26 Mar 2010 13:07:46 +0000 (GMT)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 56UnMqDsrQ+K; Fri, 26 Mar 2010 13:07:45 +0000 (GMT)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 918AD20724F;
	Fri, 26 Mar 2010 13:07:45 +0000 (GMT)
In-Reply-To: <1269592797-18487-1-git-send-email-icomfort@stanford.edu>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143228>

On Fri, 26 Mar 2010 01:39:57 -0700, Ian Ward Comfort
<icomfort@stanford.edu> wrote:
> Unfortunately, nothing in the above clarifies how other packages are
> expected to ship their own completion support.  Currently, however,
> the Git packages (and what other packages I've found with completions)
> in all these distros -- with the possible exception of Gentoo, which
> I haven't been able to verify -- install completions directly into
> /etc/bash_completion.d.  This seems natural, given that the symlink
> mechanism's current function is to have completions for all and only
> installed packages in /etc/bash_completion.d.

FWIW, Gentoo installs the completion script as
/usr/share/bash-completion/git - since installing a package isn't supposed
to enable completion but only to make it available.  Since Gentoo doesn't
use RPMs this isn't actually relevant though ;).

-- 
Julian
