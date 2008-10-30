From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 11:06:58 -0700
Message-ID: <1225390018.19891.38.camel@maia.lan>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu> <vpqmygmw1mr.fsf@bauges.imag.fr>
	 <alpine.LFD.2.00.0810301259130.13034@xanadu.home>
	 <20081030170329.GK24098@artemis.corp>
	 <alpine.LFD.2.00.0810301316220.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:08:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvbwe-0002f6-Lg
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 19:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbYJ3SHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbYJ3SHP
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:07:15 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47328 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999AbYJ3SHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 14:07:14 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id EBD2B21C610; Fri, 31 Oct 2008 07:07:11 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 66AD221C469;
	Fri, 31 Oct 2008 07:06:59 +1300 (NZDT)
In-Reply-To: <alpine.LFD.2.00.0810301316220.13034@xanadu.home>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99514>

On Thu, 2008-10-30 at 13:17 -0400, Nicolas Pitre wrote:
> > errrrm, git reset <file> resets the index notion of the file to its status
> > in HEAD... which I'm sure is *somehow* useful to "some" people ;P
> 
> Too bad...

The changes need to not unnecessarily break scripts or let down people's
expectations.  I'd be happy to deprecate the use of reset with file
arguments, to keep 'reset' focused on resetting the current HEAD and not
concerned with files; but changing its behaviour on a subtle level like
this is sure to annoy...

Sam.
