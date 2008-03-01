From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Add test for git rebase --abort
Date: Sat, 1 Mar 2008 09:15:11 +0100
Organization: glandium.org
Message-ID: <20080301081511.GA30613@glandium.org>
References: <1204322927-22407-1-git-send-email-mh@glandium.org> <7v63w7bb06.fsf@gitster.siamese.dyndns.org> <20080301073612.GA26767@glandium.org> <20080301074511.GB26767@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 09:12:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMpZ-0002qw-BQ
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 09:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbYCAILv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 03:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbYCAILv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 03:11:51 -0500
Received: from vuizook.err.no ([194.24.252.247]:58613 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbYCAILv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 03:11:51 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVMol-0001BT-Ta; Sat, 01 Mar 2008 09:11:46 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVMsB-0007yB-9R; Sat, 01 Mar 2008 09:15:11 +0100
Content-Disposition: inline
In-Reply-To: <20080301074511.GB26767@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75638>

On Sat, Mar 01, 2008 at 08:45:11AM +0100, Mike Hommey wrote:
> On Sat, Mar 01, 2008 at 08:36:12AM +0100, Mike Hommey wrote:
> > On Fri, Feb 29, 2008 at 03:26:01PM -0800, Junio C Hamano wrote:
> > > Mike Hommey <mh@glandium.org> writes:
> > > 
> > > >  The failing test is the third. I don't have enough knowledge in git-rebase
> > > >  to write an appropriate fix, but the problem seems to be in
> > > >  move_to_original_branch, where testing head_name doesn't seem appropriate.
> > > 
> > > Please mark such an "expected to succeed but fails due to
> > > suspected bug" with test_expect_failure.
> > 
> > I was kind of expecting the bug would be fixed before the test be
> > included ;)
> 
> ... and the test actually passes with v1.5.0. I'll bisect.

... and I'm even the one to blame
fb6e4e1f3f048898677f3cf177bfcaf60123bd5c is first bad commit

Mike
