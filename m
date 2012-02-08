From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: cloning a tree which has detached branch checked out
Date: Wed, 8 Feb 2012 12:17:30 +0200
Message-ID: <20120208101729.GA26551@redhat.com>
References: <20120207070628.GA24698@redhat.com>
 <m362fjklb7.fsf@localhost.localdomain>
 <20120207104100.GA24828@redhat.com>
 <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
 <20120207153225.GA14773@sigill.intra.peff.net>
 <7v4nv236xn.fsf@alter.siamese.dyndns.org>
 <20120207171604.GA26614@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 08 11:17:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv4ar-0001Tr-Ah
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 11:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab2BHKRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 05:17:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab2BHKRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 05:17:36 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q18AHTE5013300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 8 Feb 2012 05:17:29 -0500
Received: from redhat.com (vpn-203-194.tlv.redhat.com [10.35.203.194])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id q18AHQul005198;
	Wed, 8 Feb 2012 05:17:27 -0500
Content-Disposition: inline
In-Reply-To: <20120207171604.GA26614@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190229>

On Tue, Feb 07, 2012 at 12:16:04PM -0500, Jeff King wrote:
> On Tue, Feb 07, 2012 at 09:11:00AM -0800, Junio C Hamano wrote:
> 
> > > This particular bug should have been fixed before that, even, with my
> > > c1921c1 (clone: always fetch remote HEAD, 2011-06-07). And it is tested
> > > explicitly in t5707,...
> > [...]
> > What is funny is "error: Trying to write ref HEAD with nonexistant object".
> > "git grep -e nonexistant f3fb0" does not register any hit.
> 
> That misspelling of "nonexistent" was fixed by 7be8b3b (Fix typo:
> existant->existent, 2011-06-16), around the same time as my clone patch.
> Which really makes me wonder if the OP is accidentally running an old
> version of git during the tests.

Double checked and you are right: the box actually runs git 1.7.1.
Rechecked with 1.7.9.GIT and it behaves correctly.

My mistake, sorry about the noise.

-- 
MST
