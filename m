From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: autopacking twice?
Date: Sun, 22 Jun 2014 19:43:57 +0300
Message-ID: <20140622164357.GA31997@redhat.com>
References: <20140622055154.GA13819@redhat.com>
 <vpqbntlq893.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 22 18:43:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wykrh-00081L-QL
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 18:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaFVQne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 12:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbaFVQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 12:43:33 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5MGhUC9013294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Jun 2014 12:43:30 -0400
Received: from redhat.com (ovpn-116-28.ams2.redhat.com [10.36.116.28])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5MGhSOK012356;
	Sun, 22 Jun 2014 12:43:29 -0400
Content-Disposition: inline
In-Reply-To: <vpqbntlq893.fsf@anie.imag.fr>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252312>

On Sun, Jun 22, 2014 at 05:22:32PM +0200, Matthieu Moy wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Guess: auto-packing was started in background, did not
> > complete in time, and was restarted for the second time?
> 
> Probably once for fetch, and another after rebase.
> 
> > If true, some kind of lock file would be useful
> > to prevent this.
> 
> It is the case with recent versions of Git (>= 1.8.5). Which version are
> you running?

Sorry, forgot to mention this:

$ git --version
git version 2.0.0.542.g41d13ef

this is git master with some patches by my own.

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
