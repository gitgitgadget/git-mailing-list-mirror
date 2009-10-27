From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured
	mergetool option
Date: Tue, 27 Oct 2009 23:00:43 +0000
Message-ID: <20091027230043.GA11607@hashpling.org>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:10:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2vBP-0006Qy-Ed
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 00:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbZJ0XKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755999AbZJ0XKU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 19:10:20 -0400
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:16311 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755902AbZJ0XKU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 19:10:20 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2009 19:10:19 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAMcY50rUnw4T/2dsb2JhbADaG4Q/BIJf
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.pcl-ipout01.plus.net with ESMTP; 27 Oct 2009 23:00:45 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1N2v1w-0007SO-Li; Tue, 27 Oct 2009 23:00:44 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n9RN0i6d012194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Oct 2009 23:00:44 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n9RN0hIe012193;
	Tue, 27 Oct 2009 23:00:43 GMT
Content-Disposition: inline
In-Reply-To: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 95c23af7903c172615c6c5a8434bfbad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131387>

On Tue, Oct 27, 2009 at 03:36:49PM -0700, Scott Chacon wrote:
> p4merge is now a built-in diff/merge tool.
> This adds p4merge to git-completion and updates
> the documentation to mention p4merge.
> ---

I approve (but haven't had a chance to test this). p4merge is a
good mergetool, but now I'll have to find something else as an example
that you need to use custom mergetool support for.

I'm just wondering, does this work well with unixes and Mac OS X? I
think it's recommended install practice to symlink p4v as p4merge on
*nix, but Mac OS X needs some sort of 'launchp4merge' to be called
IIRC, or is this something that users can just configure with
mergetool.p4diff.path?

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
