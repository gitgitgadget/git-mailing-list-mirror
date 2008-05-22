From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] perl/Makefile.PL: teach makefiles about possible
 old Error.pm files
Date: Thu, 22 May 2008 10:26:14 -0700
Message-ID: <7vd4new8qx.fsf@gitster.siamese.dyndns.org>
References: <20080517011614.GA11029@foursquare.net>
 <20080521222150.GA29696@foursquare.net>
 <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org>
 <20080521235647.GA21340@foursquare.net>
 <alpine.DEB.1.00.0805221245240.30431@racer>
 <20080522164300.GA19765@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Thu May 22 19:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzEZW-00023X-2h
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 19:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbYEVR03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 13:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754196AbYEVR03
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 13:26:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYEVR02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 13:26:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E2F911C22;
	Thu, 22 May 2008 13:26:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 15423195C; Thu, 22 May 2008 13:26:19 -0400 (EDT)
In-Reply-To: <20080522164300.GA19765@foursquare.net> (Chris Frey's message of
 "Thu, 22 May 2008 12:43:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 354D2654-2824-11DD-A0E7-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82639>

Chris Frey <cdfrey@foursquare.net> writes:

> On Thu, May 22, 2008 at 12:46:12PM +0100, Johannes Schindelin wrote:
>> I do not see how it is _Git_ that breaks itself by repeated installs.  It 
>> detects that there is an Error.pm.  Fine.  You _remove_ it while 
>> installing Git.  Not fine.  Not Git's error.
>
> I guess I take the view that anything _installed_ by git is a part of git.
> If git installs Error.pm, it can't expect the user to keep it around
> if he uninstalls that version of git.

True, as we do not give "uninstall" target.  That's what distros are for.
