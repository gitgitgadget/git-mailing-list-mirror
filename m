From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed
 optimization
Date: Thu, 2 Feb 2012 15:14:58 -0500
Message-ID: <20120202201458.GB1032@thunk.org>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu>
 <7vvcnpuhpo.fsf@alter.siamese.dyndns.org>
 <20120202201226.GA1032@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt33j-0001N3-PO
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab2BBUPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:15:00 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:49218 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644Ab2BBUPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:15:00 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1Rt33b-00014y-Md; Thu, 02 Feb 2012 20:14:59 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Rt33a-0008Em-Ks; Thu, 02 Feb 2012 15:14:58 -0500
Content-Disposition: inline
In-Reply-To: <20120202201226.GA1032@thunk.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189696>

On Thu, Feb 02, 2012 at 03:12:26PM -0500, Ted Ts'o wrote:
> Then do...
> 
> $ make PROFILE_USE=YesPlease PROFILE_DIR=/var/cache/FDO all
> # make PROFILE_GEN=YesPlease PROFILE_DIR=/var/cache/FDO install

Err, that last line should have been:

# make PROFILE_USE=YesPlease PROFILE_DIR=/var/cache/FDO install

of course...

					- Ted
