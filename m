From: Garry Dolley <gdolley@arpnetworks.com>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 14:21:49 -0700
Message-ID: <20080827212148.GA7952@garry-thinkpad.arpnetworks.com>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com> <7vtzd6nqqo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 23:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYSTh-0001m9-9C
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYH0VVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbYH0VVw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:21:52 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:41546 "HELO
	penguin.filetron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751003AbYH0VVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:21:51 -0400
Received: (qmail 19222 invoked from network); 27 Aug 2008 21:20:06 -0000
Received: from unknown (HELO garry-thinkpad.arpnetworks.com) (gdolley@arpnetworks.com@205.134.237.48)
  by mail.arpnetworks.com with SMTP; 27 Aug 2008 21:20:06 -0000
Content-Disposition: inline
In-Reply-To: <7vtzd6nqqo.fsf@gitster.siamese.dyndns.org>
X-PGP-Key: http://scie.nti.st/pubkey.asc
X-PGP-Fingerprint: A4C2 A268 0A00 1C26 94BC  9690 4255 E69B F65A 9900
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93954>

On Wed, Aug 27, 2008 at 01:32:31PM -0700, Junio C Hamano wrote:
> Garry Dolley <gdolley@arpnetworks.com> writes:
> 
> > [garry@garry-thinkpad] ~/dev/ebay4r-bare (master) $ git shortlog -e -s
> > <hang>                                                                   <----- *** It hangs here ***
> 
> Tryp typing ^D here.  I think it is operating in the filter mode.

Yeah, ^D just gets me back to the prompt, no output.  It does indeed
seem to be waiting for something.

-- 
Garry Dolley
http://scie.nti.st
