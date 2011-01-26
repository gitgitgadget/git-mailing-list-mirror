From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] fast-import: 'cat-blob' and 'ls' commands
Date: Thu, 27 Jan 2011 09:46:29 +1000
Message-ID: <4D40B255.4020403@vilain.net>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com> <20110103080130.GA8842@burratino> <20110126213922.GA19727@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: vcs-fast-import-devs@lists.launchpad.net,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 00:47:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiF5G-00075i-L1
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 00:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab1AZXqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 18:46:43 -0500
Received: from mx1.orcon.net.nz ([219.88.242.51]:40368 "EHLO mx1.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab1AZXqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 18:46:42 -0500
Received: from Debian-exim by mx1.orcon.net.nz with local (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PiF4S-0001MC-Pd
	for git@vger.kernel.org; Thu, 27 Jan 2011 12:46:40 +1300
Received: from [60.234.254.246] (helo=mail.utsl.gen.nz)
	by mx1.orcon.net.nz with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PiF4S-0001M4-K0
	for git@vger.kernel.org; Thu, 27 Jan 2011 12:46:40 +1300
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 7AE782E023; Thu, 27 Jan 2011 12:46:40 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [169.222.8.180] (unknown [169.222.8.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 926252E021;
	Thu, 27 Jan 2011 12:46:35 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20110126213922.GA19727@burratino>
X-Enigmail-Version: 1.1.2
X-DSPAM-Check: by mx1.orcon.net.nz on Thu, 27 Jan 2011 12:46:40 +1300
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Thu Jan 27 12:46:40 2011
X-DSPAM-Confidence: 0.5546
X-DSPAM-Probability: 0.0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165562>

On 27/01/11 07:39, Jonathan Nieder wrote:
> Hi fast importers,
>
> I would like your thoughts on a few developments in fast-import
> protocol (thanks to David, Ram, Sverre, Tomas, and Sam for work so
> far).  If they seem good, I'd be happy to help make patches to other
> backends so these can be implemented widely.
>
> Contents: cat-blob command, filemodify (M) with trees, ls command.

Ok.  My first thoughts here are to be careful about the design: this
fast-import protocol is fast becoming close to getting an RFC, having
multiple interoperable implementations available, so do consider whether
all syntax will be cleanly extensible to eventually support full basic
plumbing requirements.

ie, using the command 'cat-blob' instead of a 'cat' command with 'blob'
as an argument as git cat-file currently works seems to be an
inflexibility and may eventually be considered legacy.

Otherwise it looks fine, seems to support all the file types etc. 
Thanks for keeping the work up!

Cheers,
Sam
