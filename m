From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Makefile: determine the list of header files using a
 glob
Date: Wed, 30 Dec 2009 09:00:02 +0100
Message-ID: <20091230080002.GA31088@glandium.org>
References: <4B0F8825.3040107@viscovery.net>
 <20091127082624.GA19875@glandium.org>
 <4B0F92E7.8090403@viscovery.net>
 <20091127085802.GA21217@glandium.org>
 <7v7htbom95.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 09:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPtU4-0005Si-4h
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 09:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbZL3IAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 03:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbZL3IAS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 03:00:18 -0500
Received: from vuizook.err.no ([85.19.221.46]:58652 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbZL3IAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 03:00:15 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NPtTP-0000RL-9d; Wed, 30 Dec 2009 09:00:06 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1NPtTO-00086K-A2; Wed, 30 Dec 2009 09:00:02 +0100
Content-Disposition: inline
In-Reply-To: <7v7htbom95.fsf@alter.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135867>

(Nanako's bunch of reminders reminded me of this thread)

On Fri, Nov 27, 2009 at 10:28:38AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Fri, Nov 27, 2009 at 09:50:47AM +0100, Johannes Sixt wrote:
> >> Mike Hommey schrieb:
> >> > I don't know if the current Makefile works with Solaris' make,...
> >> 
> >> No, it doesn't. You have to use GNU make anyway.
> >
> > Then it's fine. But shouldn't that be noted somewhere, like in the
> > INSTALL file ?
> 
> Surely.  Please make it so.

I had another idea in the interim. If GNU make is necessary, why not
make the Makefile an explicit GNU make only Makefile, by renaming it
GNUmakefile ?

That wouldn't remove the need to add a note in the INSTALL file, though.

Mike
