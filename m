From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix http-push test
Date: Mon, 7 Jul 2008 22:17:20 +0200
Organization: glandium.org
Message-ID: <20080707201720.GA1356@glandium.org>
References: <1215457357-24279-1-git-send-email-mh@glandium.org> <20080707190847.GA24489@glandium.org> <7vej6531xa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 22:18:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFxAI-0006fs-V1
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbYGGUR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755722AbYGGUR2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:17:28 -0400
Received: from vuizook.err.no ([194.24.252.247]:47915 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643AbYGGUR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 16:17:28 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KFx9B-0007Nd-Uz; Mon, 07 Jul 2008 22:17:24 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KFx9E-0000io-B5; Mon, 07 Jul 2008 22:17:20 +0200
Content-Disposition: inline
In-Reply-To: <7vej6531xa.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87648>

On Mon, Jul 07, 2008 at 12:54:41PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Mon, Jul 07, 2008 at 09:02:37PM +0200, Mike Hommey wrote:
> >> http-push test has been broken by 4a7aaccd adding a space character
> >> in the place where the test is being run.
> >> ---
> >> 
> >>  Note that the 4th test doesn't pass because of the new git clone, that
> >>  creates the clone with packed-refs instead of refs/heads/master that
> >>  push is requiring. But this also means push was already broken with
> >>  repositories with packed-refs.
> >
> > Actually, the 3rd is failing too, but fails to report an error because
> > git push returns no error code in cases where it says:
> >   No refs in common and none specified; doing nothing.
> 
> Ok, when you are done checking, care to send in a replacement patch with
> failing one marked with test_expect_failure?

Shouldn't that be two different patches ? One to fix the spaces problem
and one to handle the fact that builtin-clone broke the tests ?

Mike
