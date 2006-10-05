From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 0/2] gitweb: blame: make cut-and-paste legible
Date: Wed, 4 Oct 2006 17:57:47 -0700 (PDT)
Message-ID: <20061005005747.61529.qmail@web31811.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 05 03:06:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVHYd-0000Ab-Ls
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 02:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWJEA5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 20:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWJEA5t
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 20:57:49 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:20877 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751283AbWJEA5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 20:57:47 -0400
Received: (qmail 61531 invoked by uid 60001); 5 Oct 2006 00:57:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YmelzBDG7sxQgYgKPeNSmDKNcEsADz3HjGjmaZtJoVtN0ixoE/ud4L0nkldzzFK1hJs7i/Q2WQGXI/52cgcpcsqajWQulVikpX7Mq2hIx66BBOsn0JgZotb+JqtY8y5luw7mdHYQYGpgwXtiTu4Ei7SjKBMUycuePCsNQP4O05Q=  ;
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 17:57:47 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28335>

The following set of patches makes cut-and-paste from blame
legible in the destination buffer.  E.g.:

cae1862a	3033		if (defined $co{'parent'}) {
        	3034			push @views_nav,
        	3035				$cgi->a({-href => href(action=>"shortlog", hash=>$hash)}, "shortlog"),
        	3036				$cgi->a({-href => href(action=>"log", hash=>$hash)}, "log");
        	3037		}

It also adds "title" to all rows of data.

    Luben
