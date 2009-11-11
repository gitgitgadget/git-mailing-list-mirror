From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release workflow
Date: Wed, 11 Nov 2009 21:41:58 +0100
Message-ID: <200911112142.00209.trast@student.ethz.ch>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm> <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8K1j-0001el-D0
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 21:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758887AbZKKUmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 15:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758876AbZKKUmk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 15:42:40 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:25291 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757807AbZKKUmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 15:42:39 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 11 Nov
 2009 21:42:45 +0100
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 11 Nov
 2009 21:42:43 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.29-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132699>

It's nice to see someone work on this manpage :-) I sadly do not have
the time to read the whole patch right now, though I'll try and catch
up tomorrow or so.  In the meantime I do have one remark:

rocketraman@fastmail.fm wrote:
> +The maintainer may use the following release workflow:
> +
> +He first tags the tip of 'master' with a release tag, then he updates
> +the 'maint' branch to the current tip of 'master' for managing future
> +maintenance fixes on the current release, and lastly he optionally
> +rebuilds 'next' from the tip of 'master'.

The current gitworkflows is mostly formulated in the imperative, as in

  To test the interaction of several topics, merge them into a
  throw-away branch.  You must never base any work on such a branch!

or by directly describing the tools in the third person, as in

  * linkgit:git-push[1] copies your branches to a remote repository,
    usually to one that can be read by all involved parties;

It would certainly be nice to be somewhat consistent.  Since at first
glance your description is aimed at the maintainer himself, I assume
that would mostly mean addressing the maintainer as "you", and
formulating the rules in the imperative.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
