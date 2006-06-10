From: Christopher Faylor <me+git@cgf.cx>
Subject: Re: gitk on Windows: layout problem
Date: Sat, 10 Jun 2006 16:34:19 -0400
Message-ID: <20060610203419.GB324@trixie.casa.cgf.cx>
References: <20060530185441.GA10985@nospam.com> <17537.22986.653849.367731@cargo.ozlabs.ibm.com> <20060610111321.GA6790@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 10 22:34:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpAAG-0004p6-Hv
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 22:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWFJUeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 16:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWFJUeU
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 16:34:20 -0400
Received: from pool-71-248-179-19.bstnma.fios.verizon.net ([71.248.179.19]:23205
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1161010AbWFJUeU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 16:34:20 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id D68C613C01F; Sat, 10 Jun 2006 16:34:19 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060610111321.GA6790@nospam.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21619>

On Sat, Jun 10, 2006 at 01:13:21PM +0200, Rutger Nijlunsing wrote:
>On Sat, Jun 03, 2006 at 07:43:38PM +1000, Paul Mackerras wrote:
>> Rutger Nijlunsing writes:
>>>Is this a known problem?  gitk-du-jour on Windows starts up with an
>>>unusable layout.  Screenshot attached.
>>
>>Is that using Tk with the cygwin X server, or the native Windows Tk
>>port?
>
>I installed the default cygwin version but I don't have to start an X
>server for it.  So while it's not the native Windows Tk port, it also
>doesn't seem to be the X-server version.

Cygwin's Tk is pretty close to a pure windows version.  It doesn't even
understand cygwin path names.  Its main purpose is to support the
insight debugger and it does not require an X-server to run.
