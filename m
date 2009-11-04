From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v2] format-patch: autonumber by default
Date: Wed, 04 Nov 2009 03:20:05 -0800
Message-ID: <m1ws261qqi.fsf@fess.ebiederm.org>
References: <20081002205539.GA36768@Hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 12:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5duY-0007T0-1o
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 12:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbZKDLUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 06:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbZKDLUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 06:20:09 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:45679 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbZKDLUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 06:20:08 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
	by out02.mta.xmission.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1N5duN-0000er-JC; Wed, 04 Nov 2009 04:20:11 -0700
Received: from c-76-21-114-89.hsd1.ca.comcast.net ([76.21.114.89] helo=fess.ebiederm.org)
	by in02.mta.xmission.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ebiederm@xmission.com>)
	id 1N5duN-00027h-AL; Wed, 04 Nov 2009 04:20:11 -0700
Received: from fess.ebiederm.org (localhost [127.0.0.1])
	by fess.ebiederm.org (8.14.3/8.14.3/Debian-4) with ESMTP id nA4BK8bc030927;
	Wed, 4 Nov 2009 03:20:08 -0800
Received: (from eric@localhost)
	by fess.ebiederm.org (8.14.3/8.14.3/Submit) id nA4BK5NO030867;
	Wed, 4 Nov 2009 03:20:05 -0800
In-Reply-To: <20081002205539.GA36768@Hermes> (Brian Gernhardt's message of "Thu\, 2 Oct 2008 16\:55\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-XM-SPF: eid=;;;mid=;;;hst=in02.mta.xmission.com;;;ip=76.21.114.89;;;frm=ebiederm@xmission.com;;;spf=neutral
X-SA-Exim-Connect-IP: 76.21.114.89
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Version: 4.2.1 (built Thu, 25 Oct 2007 00:26:12 +0000)
X-SA-Exim-Scanned: No (on in02.mta.xmission.com); Unknown failure
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132079>


Brian Gernhardt <benji@silverinsanity.com> writes:

> format-patch is most commonly used for multiple patches at once when
> sending a patchset, in which case we want to number the patches; on
> the other hand, single patches are not usually expected to be
> numbered.
>
> In other words, the typical behavior expected from format-patch is the
> one obtained by enabling autonumber, so we set it to be the default.
>
> Users that want to disable numbering for a particular patchset can do
> so with the existing -N command-line switch.  Users that want to
> change the default behavior can use the format.numbering config key.
>
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> ---


Grumble.  I updated git last night and this change just bit me.
Grumble.
Grumble.

It is probably a good change, but it was unexpected.
Grumble. Grumble. Grumble.


Eric
