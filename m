From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH/RFC] autocrlf: Make it work also for un-normalized
	repositories
Date: Wed, 12 May 2010 00:52:03 +0200
Message-ID: <20100511225202.GC16974@pvv.org>
References: <20100510171119.GA17875@pvv.org> <m37hnbec16.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 00:52:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OByJB-0007IV-VS
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 00:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab0EKWwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 18:52:07 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:48890 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab0EKWwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 18:52:06 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OByJ1-0003bR-88; Wed, 12 May 2010 00:52:03 +0200
Content-Disposition: inline
In-Reply-To: <m37hnbec16.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146909>

On Mon, May 10, 2010 at 01:30:22PM -0700, Jakub Narebski wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
> How this feature relates to `core.safecrfl'?

safecrlf is about checking what you add, it does not concern itself
about what is already in the repository as far as I can tell.

The safecrlf check will only be done if autocrlf converts a file.  For
new files autocrlf is unchanged, and safecrlf will complain or die as
before.  For existing files, you will only be able to get autocrlf to
do anything (and thus do the safecrlf check) if the files are
normalized to LF only in the repo, or if you have set the crlf
attribute on them.

- Finn Arne
