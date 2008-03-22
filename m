From: Sven Marnach <sven@pantoffel-wg.de>
Subject: Re: Rebasing a complete revision graph
Date: Sat, 22 Mar 2008 14:50:28 +0100
Message-ID: <20080322135027.GB5578@pantoffel-wg.de>
References: <20080322121954.GA5578@pantoffel-wg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 14:51:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd47v-0007g1-KE
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 14:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbYCVNuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 09:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbYCVNuf
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 09:50:35 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:41030 "EHLO
	relay.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbYCVNue (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 09:50:34 -0400
Received: from ix.urz.uni-heidelberg.de (cyrus1.urz.uni-heidelberg.de [129.206.119.235])
	by relay.uni-heidelberg.de (8.14.1/8.14.1) with ESMTP id m2MDoTIw028994
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 14:50:29 +0100
Received: from extmail.urz.uni-heidelberg.de (extmail.urz.uni-heidelberg.de [129.206.100.140])
	by ix.urz.uni-heidelberg.de (8.8.8/8.8.8) with ESMTP id OAA16777342
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 14:50:29 +0100
Received: from bagheera.suspekt (dslb-084-056-239-215.pools.arcor-ip.net [84.56.239.215])
	(authenticated bits=0)
	by extmail.urz.uni-heidelberg.de (8.13.4/8.13.1) with ESMTP id m2MDoN19022708
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 22 Mar 2008 14:50:25 +0100
Received: from sven by bagheera.suspekt with local (Exim 4.69)
	(envelope-from <sven@pantoffel-wg.de>)
	id 1Jd47A-00038v-1g
	for git@vger.kernel.org; Sat, 22 Mar 2008 14:50:28 +0100
Content-Disposition: inline
In-Reply-To: <20080322121954.GA5578@pantoffel-wg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77806>

Hi again,

Sven Marnach schrieb am Sa, 22. M=E4r 2008, um 13:19:54 +0100:
> I'm wondering if there is a way of rebasing a wohle revision graph
> with multiple branches and merges, but I didn't find anything in the
> documentation or on the mailing list.

I finally figured out this can be done using grafts and optionally
using git-filter-branch afterwards.

Greetings,
    Sven
