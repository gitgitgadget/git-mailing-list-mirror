From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Bisect: fix calculation of the number of suspicious
	revisions
Date: Wed, 21 Mar 2007 22:34:50 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070321213450.GB17632@informatik.uni-freiburg.de>
References: <20070317141209.GA7838@cepheus> <Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070317195840.GA20735@informatik.uni-freiburg.de> <20070321210454.GA2844@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 22:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU8SP-000571-QA
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 22:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbXCUVez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Mar 2007 17:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbXCUVey
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 17:34:54 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:44196 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752976AbXCUVey (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2007 17:34:54 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HU8SL-0002UN-15
	for git@vger.kernel.org; Wed, 21 Mar 2007 22:34:53 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2LLYouS018893
	for <git@vger.kernel.org>; Wed, 21 Mar 2007 22:34:50 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2LLYopW018892
	for git@vger.kernel.org; Wed, 21 Mar 2007 22:34:50 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070321210454.GA2844@lala>
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42819>

Hello,

Uwe Kleine-K=F6nig wrote:
>  	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
independant of my suggested patch, I wonder if that line should better
use update-ref.  (This line is older than update-ref.)

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

$ dc -e "5735816763073014741799356604682P"
