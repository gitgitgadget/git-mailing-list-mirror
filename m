From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Fri, 17 Apr 2009 21:49:19 +0200
Message-ID: <20090417194919.GA7611@glandium.org>
References: <1239916256-10878-1-git-send-email-mh@glandium.org> <37fcd2780904170924t61168a49uf1800098cdb1d730@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luu5Z-0001M1-G3
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 21:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbZDQTta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 15:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbZDQTta
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 15:49:30 -0400
Received: from vuizook.err.no ([85.19.221.46]:33595 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbZDQTt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 15:49:29 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Luu3s-0007Bo-U2; Fri, 17 Apr 2009 21:49:23 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Luu3r-00021X-OV; Fri, 17 Apr 2009 21:49:19 +0200
Content-Disposition: inline
In-Reply-To: <37fcd2780904170924t61168a49uf1800098cdb1d730@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116782>

On Fri, Apr 17, 2009 at 08:24:35PM +0400, Dmitry Potapov wrote:
> On Thu, Apr 16, 2009 at 11:10:56PM +0200, Mike Hommey wrote:
> > When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> > variable to what would otherwise be passed to $SHELL -c. When this
> > variable is set, we use it instead of the contents of argv.
> 
> It would be nice to provide some justification where it can be used.
> IOW, why do you want to have the force command where essentially
> you execute the original command as it were no force-command?

You're not executing any command, but only what git-shell allows.
This allows git-shell to be set as a forced-command for a specific
ssh key, for example.

Mike
