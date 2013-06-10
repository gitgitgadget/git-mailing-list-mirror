From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/7] git send-email suppress-cc=self fixes
Date: Mon, 10 Jun 2013 11:59:33 +0300
Message-ID: <20130610085933.GA2233@redhat.com>
References: <1370455737-29986-1-git-send-email-mst@redhat.com>
 <7v8v2o1ho7.fsf@alter.siamese.dyndns.org>
 <20130605201423.GB31143@redhat.com>
 <7vy5ain9yg.fsf@alter.siamese.dyndns.org>
 <20130610065324.GA26501@redhat.com>
 <20130610072931.GH22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlxwR-0007Ay-QQ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab3FJI7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 04:59:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab3FJI7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:59:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5A8wvIM002810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 10 Jun 2013 04:58:57 -0400
Received: from redhat.com (vpn1-6-65.ams2.redhat.com [10.36.6.65])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r5A8wsoT010356;
	Mon, 10 Jun 2013 04:58:55 -0400
Content-Disposition: inline
In-Reply-To: <20130610072931.GH22905@serenity.lan>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227265>

On Mon, Jun 10, 2013 at 08:29:31AM +0100, John Keeping wrote:
> On Mon, Jun 10, 2013 at 09:53:24AM +0300, Michael S. Tsirkin wrote:
> > I vaguely remember there was some way to say
> > "head of the remote I am tracking" - but I could not find it.
> > Where are all the tricks like foo^{} documented?
> 
> gitrevisions(7) is what you're looking for here.

I see. And git(1) actually points to it.
Thanks!

> In this case I think you want '@{upstream}' or its short form '@{u}'.
> 
> > I tried fgrep '{}' Documentation/*txt and it only returned
> > git-show-ref.txt which isn't really informative ...
> 
> '{' and '}' need to be escaped in AsciiDoc so you have to grep for
> '\\{\\}'.
