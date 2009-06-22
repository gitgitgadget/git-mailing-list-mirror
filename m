From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] rebase -i: save only original commit sha1 to save
 author information
Date: Mon, 22 Jun 2009 11:27:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906221126040.4168@intel-tinevez-2-302>
References: <20090622042831.3858.67926.chriscool@tuxfamily.org> <200906220935.11581.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-904472804-1245662878=:4168"
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 11:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIfp3-0001U5-8U
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 11:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbZFVJ2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 05:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755786AbZFVJ16
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 05:27:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:33154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755363AbZFVJ15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 05:27:57 -0400
Received: (qmail invoked by alias); 22 Jun 2009 09:27:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp012) with SMTP; 22 Jun 2009 11:27:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oasQxlcWoBiRp80hVqLkc/KK3GsOn0eW56Xsd4+
	Wr6pZMgT6B5guJ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200906220935.11581.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122022>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-904472804-1245662878=:4168
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 22 Jun 2009, Jakub Narebski wrote:

> Christian Couder wrote:
> 
> > +                       GIT_AUTHOR_NAME="$author_ident_name" \
> > +                       GIT_AUTHOR_EMAIL="$author_ident_email" \
> > +                       GIT_AUTHOR_DATE="$author_ident_date" \
> >                         $USE_OUTPUT git commit --no-verify \
> >                                 $MSG_OPT "$EDIT_OR_FILE" || failed=t
> 
> Why not use 'git commit -C $(cat "$SAVED_COMMIT") ...' ?

Unfortunately, the quoted part lacks context, so I can only guess that the 
issue is "squash".  You need to retain authorship, but want to present a 
message to the user that is in no commit yet.  And no, constructing a new 
commit for the purpose of passing it to "commit -C" would be way too 
shabby coding IMO.

Ciao,
Dscho

--8323329-904472804-1245662878=:4168--
