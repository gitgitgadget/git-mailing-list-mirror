From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a separate gitdirs.
Date: Fri, 7 Mar 2014 16:42:44 -0500
Message-ID: <BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
References: <1394178834.7891.38.camel@Naugrim>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Fri Mar 07 22:42:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM2Xb-0006jI-9A
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 22:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbaCGVmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 16:42:47 -0500
Received: from atl4mhob05.myregisteredsite.com ([209.17.115.43]:32906 "EHLO
	atl4mhob05.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033AbaCGVmq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 16:42:46 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.206])
	by atl4mhob05.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s27LgiSN032557
	for <git@vger.kernel.org>; Fri, 7 Mar 2014 16:42:44 -0500
Received: (qmail 1029 invoked by uid 0); 7 Mar 2014 21:42:44 -0000
X-TCPREMOTEIP: 69.41.14.217
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO devnet.ces.cvnt.net) (andrew@kellerfarm.com@69.41.14.217)
  by 0 with ESMTPA; 7 Mar 2014 21:42:44 -0000
In-Reply-To: <1394178834.7891.38.camel@Naugrim>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243630>

On Mar 7, 2014, at 2:53 AM, Henri GEIST <geist.henri@laposte.net> wrote:

> Adding a note in the submodule documentation signaling that the
> automatically cloned missing submodules are cloned with a separate
> gitdir. And where it is put.
> 
> Signed-off-by: Henri GEIST <geist.henri@laposte.net>
> ---
> Documentation/git-submodule.txt |    5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 21cb59a..ea837fd 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -64,6 +64,11 @@ using the 'status' subcommand and get a detailed overview of the
> difference between the index and checkouts using the 'summary'
> subcommand.
> 
> +*NOTE*: when submodule add or submodule update commands clone a missing
> +submodule, the option --separate-git-dir is passed to the clone command
> +and the gitdir of the submodule is placed outside of its working
> +directory in the .git/module of the current repository.
> +

The modules directory is 'modules'.  And, the '.git' folder is not always called '.git' -- in a submodule, for example, the directory name is the name of the module.

Also, this file contains mostly high-level documentation, and this addition feels technical in nature.  Is there a location for more technical documentation?  Or, perhaps it can be reworded to sound less technical?

> 
> COMMANDS
> --------
> -- 
> 1.7.9.3.369.gd715.dirty
> 
> 
> --

 - Andrew Keller
