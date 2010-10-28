From: Gerrit Pape <pape@smarden.org>
Subject: Re: Why /var/cache/git?
Date: Thu, 28 Oct 2010 15:53:02 +0000
Message-ID: <20101028155302.11273.qmail@17f1bb531c10eb.315fe32.mid.smarden.org>
References: <20101025103006.GA18782@brong.net> <4CC5A13F.2090702@eaglescrag.net> <20101026012224.GA3360@brong.net> <1288099299.8291.6.camel@drew-northup.unet.maine.edu> <20101026152218.3931.qmail@d862ae2b10e11a.315fe32.mid.smarden.org> <7viq0ohknn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Bron Gondwana <brong@fastmail.fm>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 17:53:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBUmv-0007XS-8P
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 17:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759091Ab0J1PxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 11:53:07 -0400
Received: from a.ns.smarden.org ([109.68.224.7]:45412 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754724Ab0J1PxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 11:53:05 -0400
Received: (qmail 11274 invoked by uid 1000); 28 Oct 2010 15:53:02 -0000
Content-Disposition: inline
In-Reply-To: <7viq0ohknn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160183>

On Tue, Oct 26, 2010 at 11:30:04AM -0700, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > Hi, it's also not my preference, but Debian adheres to the FHS.
> > Unfortunately /var/git is not allowed by the FHS, so a different
> > location must be chosen for Debian.
> 
> It seems that /var/lib/ seems to be more appropriate place to store
> persistent database-y stuff. I see e.g. /var/lib/postgresql there.

I agree and re-opened
 http://bugs.debian.org/483788

Regards, Gerrit.
