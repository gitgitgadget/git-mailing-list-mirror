From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Letting remote repositories override local configuration
Date: Mon, 19 Mar 2012 13:21:33 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1203191319360.15290@ds9.cixit.se>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1203190945560.15290@ds9.cixit.se> <20120319093505.GA10017@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 13:21:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9bau-0001qp-5c
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 13:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227Ab2CSMVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 08:21:42 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:58993 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964819Ab2CSMVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 08:21:41 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q2JCLYcq028314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 19 Mar 2012 13:21:34 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q2JCLXit028311;
	Mon, 19 Mar 2012 13:21:33 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20120319093505.GA10017@burratino>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 19 Mar 2012 13:21:34 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193429>

Jonathan Nieder:

> What would I be missing?

If you can manage to do that and never mis-push, then, yes, that would be 
fine. As soon as you have local branches checked out it starts getting 
problematic; we also have different servers with different branch namespaces 
that we push to, and making sure the wrong branch doesn't get pushed to the 
wrong server can sometimes be difficult.

-- 
\\// Peter - http://www.softwolves.pp.se/
