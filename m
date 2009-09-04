From: Ian Clatworthy <ian.clatworthy@canonical.com>
Subject: Re: [PATCH v6 5/6] fast-import: add option command
Date: Fri, 04 Sep 2009 13:42:26 +1000
Message-ID: <4AA08CA2.4060702@canonical.com>
References: <1251914223-31435-1-git-send-email-srabbelier@gmail.com> 	<1251914223-31435-2-git-send-email-srabbelier@gmail.com> <1251914223-31435-3-git-send-email-srabbelier@gmail.com> 	<1251914223-31435-4-git-send-email-srabbelier@gmail.com> <1251914223-31435-5-git-send-email-srabbelier@gmail.com> 	<1251914223-31435-6-git-send-email-srabbelier@gmail.com> <7vskf4px6j.fsf@alter.siamese.dyndns.org> <fabb9a1e0909022155r254c41c6s9ed962313c241e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 05:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjPhp-0000mo-4o
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 05:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbZIDDnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 23:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756588AbZIDDnK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 23:43:10 -0400
Received: from bld-mail12.adl6.internode.on.net ([150.101.137.97]:50034 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756576AbZIDDnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 23:43:09 -0400
Received: from [192.168.1.102] (unverified [118.208.1.199]) 
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id 4661921-1927428 
	for multiple; Fri, 04 Sep 2009 13:12:37 +0930 (CST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <fabb9a1e0909022155r254c41c6s9ed962313c241e9@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127684>

Sverre Rabbelier wrote:
> Heya,
> 
> On Thu, Sep 3, 2009 at 04:41, Junio C Hamano<gitster@pobox.com> wrote:

>> I think at least the function should be made conditional to die() if it
>> was called from parse_argv() but simply ignore unknown if it was called
>> from the input stream.
> 
> Makes sense, what do the fast-import devs think?

Sounds ok to me.

Ian C.
