From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: "git cat-file <sha1>" shows usage but should not?
Date: Wed, 15 Apr 2009 18:56:05 +0200
Message-ID: <49E611A5.8090602@hartwork.org>
References: <49E61067.6060802@hartwork.org> <20090415165420.GB24528@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8Qf-0002zU-RV
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbZDOQ4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbZDOQ4I
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:56:08 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:39174 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbZDOQ4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:56:08 -0400
Received: from [85.179.43.251] (helo=[192.168.0.3])
	by smtprelay11.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Lu8P8-0004Pd-7B; Wed, 15 Apr 2009 18:56:06 +0200
User-Agent: Thunderbird 2.0.0.19 (X11/20090216)
In-Reply-To: <20090415165420.GB24528@coredump.intra.peff.net>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116629>

Jeff King wrote:
> That usage message is misleading. You need to use one of -t, -s, -e, -p,
> or <type>. So it should perhaps just be:
> 
>   git cat-file -t|-s|-e|-p|<type> <sha1>
> 
> though that looks terribly ugly. Suggestions welcome.

Thanks for making that clear.  How about round or curly brackets?



Sebastian
