From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 23:01:18 +0000
Message-ID: <20120727230118.GA29949@dcvr.yhbt.net>
References: <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
 <7vsjcczxgu.fsf@alter.siamese.dyndns.org>
 <20120727220753.GA7378@dcvr.yhbt.net>
 <20120727221924.GA8700@dcvr.yhbt.net>
 <7vboj0zv7t.fsf@alter.siamese.dyndns.org>
 <20120727224554.GA30385@dcvr.yhbt.net>
 <7vobn0yfm8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 01:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutXA-0001z2-6H
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 01:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab2G0XBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 19:01:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33844 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab2G0XBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 19:01:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E291F5B5;
	Fri, 27 Jul 2012 23:01:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vobn0yfm8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202393>

Junio C Hamano <gitster@pobox.com> wrote:
> Ok, please don't forget to add necessary .gitignore rule for the new
> stamp file.

I noticed/remembered that, but I forgot to mention I squashed that in,
too :)
