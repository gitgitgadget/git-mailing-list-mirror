From: Mike Hommey <mh@glandium.org>
Subject: Re: branch description
Date: Wed, 16 Apr 2008 07:55:08 +0200
Organization: glandium.org
Message-ID: <20080416055508.GA28725@glandium.org>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com> <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com> <7vej97x78v.fsf@gitster.siamese.dyndns.org> <m3abjushvs.fsf@localhost.localdomain> <9b3e2dc20804152028s571ea2edm3cdbac7db57e6d8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>, git@vger.kernel.org
To: Stephen Sinclair <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 08:22:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm0d1-0002Yg-Tw
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 07:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbYDPFze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 01:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbYDPFze
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 01:55:34 -0400
Received: from vuizook.err.no ([194.24.252.247]:33880 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbYDPFzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 01:55:33 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1Jm0c0-00078s-QS; Wed, 16 Apr 2008 07:55:23 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Jm0bs-0007VT-3j; Wed, 16 Apr 2008 07:55:08 +0200
Content-Disposition: inline
In-Reply-To: <9b3e2dc20804152028s571ea2edm3cdbac7db57e6d8d@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79678>

On Tue, Apr 15, 2008 at 11:28:49PM -0400, Stephen Sinclair wrote:
> On Tue, Apr 15, 2008 at 9:33 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> >   (such as branch names in case of Mercurial, or branches
> >  descriptions in this case)
> 
> This got me thinking...
> It's a little crazy, but: since branch descriptions would essentially
> just be an extension of the branch name, play basically the same role
> and have the same requirements for storage, cloning, etc., what about
> using some syntax in the branch name itself to separate a "short name"
> and a "long name"..
> 
> That is, you could store it as,
> refs/heads/wip:work_in_progress

Why not simply add the text after the sha1 in the refs/heads/branch_name
file ? Obviously current and older git code should be checked to know
whether they could cope with the extra data without failing...

This would also have the advantage that renaming the branch would not
lose the description.

Mike
