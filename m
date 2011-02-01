From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 01 Feb 2011 16:44:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102011637560.8580@xanadu.home>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=oTL2_ObcyKRb7bf7ZMPZoa1BU7uNH5pJRQtVC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:44:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkO1f-0005ji-2p
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab1BAVoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:44:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28383 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab1BAVod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:44:33 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFY00LCKKDKW5B0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 Feb 2011 16:44:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTi=oTL2_ObcyKRb7bf7ZMPZoa1BU7uNH5pJRQtVC@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165864>

On Wed, 2 Feb 2011, Nguyen Thai Ngoc Duy wrote:

>  - push support for shallow clone (Elijah approach does not base on
> shallow clone, so it's non-issue)

Push support from a shallow clone should be really simple.  Either you 
can update the remote, or you can't.  If your local history does include 
the remote branch head you wish to update then there is nothing 
currently that would prevent the push from proceeding as implemented 
today.  If the remote head is outside the history subset you have 
locally then the push simply cannot proceed.


Nicolas
