From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: add support for ECMerge
Date: Tue, 9 Oct 2007 08:14:24 +0200
Message-ID: <1C50C046-3D61-4D55-8D38-B2D563C1FF2A@zib.de>
References: <11918785613855-git-send-email-prohaska@zib.de> <11918785611059-git-send-email-prohaska@zib.de> <20071008214451.GB31713@thunk.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:13:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If8L3-00076B-Hh
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 08:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbXJIGM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 02:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXJIGM6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 02:12:58 -0400
Received: from mailer.zib.de ([130.73.108.11]:44599 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbXJIGM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 02:12:57 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l996Cr8q011947;
	Tue, 9 Oct 2007 08:12:53 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1f6fc.pool.einsundeins.de [77.177.246.252])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l996CqWM029399
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Oct 2007 08:12:52 +0200 (MEST)
In-Reply-To: <20071008214451.GB31713@thunk.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60360>


On Oct 8, 2007, at 11:44 PM, Theodore Tso wrote:

> On Mon, Oct 08, 2007 at 11:22:41PM +0200, Steffen Prohaska wrote:
>> Add support for ECMerge available from
>> http://www.elliecomputing.com/Products/merge_overview.asp
>
> Hmm.  A propietary merge tool.  It's not that much code, so I  
> guess....
>
> I note though that it claims on the web page that they are integrated
> with "most famous SCM's", but they don't include git.  If we add this
> support, are they going to change their web page?  :-)

You may even apply for a free (as beer) license if you contribute
to open source projects:

http://www.elliecomputing.com/Community/opensource.asp

I didn't try this, so I can't say how this works in practice.

> Also, ECmerge is supported on Linux, Solaris, MacOS X, and Windows.
> Which platforms have you tested on?

Windows. Haven't tested Unix systems yet.

> My guess is that if it works on
> Linux, it'll probably work on Solaris and MacOS, but is it a fair
> guess you haven't tested under Windows?  Not that most Windows systems
> are going to be able to use git-mergetool since it's a bash script,
> unless they are using Cygwin or some such.

I work on the msysgit project and I'd like to have mergetool
available before I advertise git on Windows. It makes merging
so much easier ;)

	Steffen
