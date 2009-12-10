From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 13:47:01 +0100
Message-ID: <20091210124701.GA12521@atjola.homenet>
References: <87ljhb87nj.fsf@jondo.cante.net>
 <3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 13:47:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIiQK-0001Lr-ET
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 13:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758542AbZLJMrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 07:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758115AbZLJMrB
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 07:47:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:50687 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752833AbZLJMrA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 07:47:00 -0500
Received: (qmail invoked by alias); 10 Dec 2009 12:47:05 -0000
Received: from i59F576CC.versanet.de (EHLO atjola.homenet) [89.245.118.204]
  by mail.gmx.net (mp057) with SMTP; 10 Dec 2009 13:47:05 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Qa+p+/OIQj9BsC2DZhqpO/LIQFGKV8WokdY2mm1
	14LQcJnuxVcXgq
Content-Disposition: inline
In-Reply-To: <3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135021>

On 2009.12.10 13:23:43 +0100, Michael J Gruber wrote:
> Print the sha1 of the deleted tag (in addition to the tag name) so that
> one can easily recreate a mistakenly deleted tag:
> 
> git tag -d tagname
> Deleted tag 'tagname' DEADBEEF
> git tag 'tagname' DEADBEEF # for lightweight tags
> git update-ref refs/tags/'tagname' DEADBEEF # for annotated tags

Using "git tag 'tagname' DEADBEEF" should actually work in both cases.
As that does nothing but creating the ref in the refs/tags/ namespace.

Bjoern
