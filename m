From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: [PATCH resend] perl/Makefile.PL: teach makefiles about possible old Error.pm files
Date: Wed, 21 May 2008 19:56:47 -0400
Message-ID: <20080521235647.GA21340@foursquare.net>
References: <20080517011614.GA11029@foursquare.net> <20080521222150.GA29696@foursquare.net> <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 01:58:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyyC0-00082o-HU
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 01:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762340AbYEUX5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 19:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761762AbYEUX5G
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 19:57:06 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:60805 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761302AbYEUX5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 19:57:05 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4LNul61026278;
	Wed, 21 May 2008 19:56:47 -0400
Content-Disposition: inline
In-Reply-To: <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82588>

On Wed, May 21, 2008 at 03:51:40PM -0700, Junio C Hamano wrote:
> I think this is a wrong direction to go.
> 
> We do not currently deal with broken installations, and "stow" is just one
> easy way to install and keep a stale version.  The right solution would be
> to check if "Error.pm" we find on the system (be it installed by previous
> incarnation of git or some other packages) works as expected, and refrain
> from using it if it doesn't.

Thank you for your response.

The problem as I see it, is that the decision about whether the existing
Error.pm "works as expected" is done at compile time.  And git will break
itself by repeated installs.

Is it really valid to expect users to uninstall their current version of
git before they can compile a new one correctly?  For systems without
a working Error.pm, this is currently how git behaves.

- Chris
