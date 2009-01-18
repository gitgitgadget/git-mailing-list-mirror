From: Mike Hommey <mh@glandium.org>
Subject: Re: [WIP Patch 00/12] Refactoring the http API
Date: Sun, 18 Jan 2009 10:12:19 +0100
Organization: glandium.org
Message-ID: <20090118091219.GA6505@glandium.org>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <7v8wp9yq23.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 10:13:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOTj9-0007nJ-Jy
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 10:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757085AbZARJMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 04:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbZARJMc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 04:12:32 -0500
Received: from vuizook.err.no ([85.19.221.46]:53559 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646AbZARJMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 04:12:30 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOThc-0004BR-6F; Sun, 18 Jan 2009 10:12:22 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOThb-0002hR-4j; Sun, 18 Jan 2009 10:12:19 +0100
Content-Disposition: inline
In-Reply-To: <7v8wp9yq23.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106163>

On Sun, Jan 18, 2009 at 12:30:12AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > As it is work in progress, some error handling might have regressions, but
> > the original error handling is not necessarily much better.
> >
> > Also note I only rebased my one-year-old work on current master, and haven't
> > actually tested it, though, as the code hasn't changed much, I guess it
> > should be fine.
> > ...
> >  6 files changed, 162 insertions(+), 304 deletions(-)
> 
> Thanks.
> 
> This looks like a very nice code reduction, and the first few patches
> looked obviously correct, too ;-)
> 
> But I am puzzled by what you mean by "haven't actually tested it".  Do you
> mean you do not use http transport very much yourself, or even when you do
> you do not use a version of git with these patches applied?

I mean I haven't tested the rebased version. The original version was
tested extensively a year ago. I don't use http transport that much
now.

Mike
