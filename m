From: Nelson Elhage <nelhage@MIT.EDU>
Subject: Re: [PATCH] git-push: Accept -n as a synonym for --dry-run.
Date: Sat, 12 Sep 2009 23:54:21 -0400
Message-ID: <20090913035421.GP4275@mit.edu>
References: <1252800302-26560-1-git-send-email-nelhage@mit.edu> <7vfxar5zsi.fsf@alter.siamese.dyndns.org> <20090913034031.GO4275@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 05:54:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmgAc-0000zi-Lw
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 05:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbZIMDyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 23:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbZIMDyW
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 23:54:22 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:60739 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754878AbZIMDyV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 23:54:21 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n8D3sML5028955;
	Sat, 12 Sep 2009 23:54:23 -0400 (EDT)
Received: from LUNATIQUE.MIT.EDU (LUNATIQUE.MIT.EDU [18.208.0.153])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n8D3sL9i014358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 12 Sep 2009 23:54:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090913034031.GO4275@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128332>

On Sat, Sep 12, 2009 at 11:40:31PM -0400, Nelson Elhage wrote:
> On Sat, Sep 12, 2009 at 07:44:29PM -0700, Junio C Hamano wrote:
> Can you point to an example of a git command supporting --dry-run, and
> using -n for something else? I personally would find that confusing,
> since -n is a common alias for dry-run both inside and outside of git
> (c.f. make, rsync, libtool). I guess patch(1) has that property, but
> none of your examples from git use -n to mean something else.

Oops, I missed 'commit' in your list, which I see (as of recently) has
that property. In that case, though, --dry-run was added after an
established -n option had been there for a long time; I think my
general argument still stands for commands where that is not the case.

- Nelson
