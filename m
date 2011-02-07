From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 11:06:16 +0100
Message-ID: <201102071106.17269.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102070958.11551.johan@herland.net> <AANLkTiksUqVnWeZOm-9XN3BbfVcjc6fWdwPcPJ-PLb88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 11:06:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmNzX-0005iL-23
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 11:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab1BGKGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 05:06:37 -0500
Received: from smtp.opera.com ([213.236.208.81]:50116 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab1BGKGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 05:06:33 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p17A6HaZ019280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 7 Feb 2011 10:06:17 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTiksUqVnWeZOm-9XN3BbfVcjc6fWdwPcPJ-PLb88@mail.gmail.com>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166248>

On Monday 07 February 2011, Sverre Rabbelier wrote:
> On Mon, Feb 7, 2011 at 09:58, Johan Herland <johan@herland.net> wrote:
> > This is the same technique we use when talking about branch names:
> > On this mailing list, nobody is confused when I refer to 'maint',
> > 'master', 'next' and 'pu'. Still, in our own work repos (at least
> > in mine), these branches are actually called
> > "refs/remotes/origin/<name>" (commonly referred to by their
> > shorthands "origin/<name>"). Here we are, juggling the same kind of
> > namespaces that I propose for tags, and it seems to work well
> > without causing much confusion.
>
> With the difference that you can't refer to "maint" as just "maint"
> unless you've created "refs/heads/maint" iff it is unambiguous.

Except that with 'git checkout', you can:

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ cd git/
$ git checkout maint


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
