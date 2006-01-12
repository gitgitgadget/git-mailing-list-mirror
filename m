From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: git in HP-UX PA-RISC
Date: Thu, 12 Jan 2006 15:35:33 -0500
Message-ID: <20060112203533.GB4701@quicksilver.road.mcmartin.ca>
References: <5c08a49c0601121105u519fe02fq@mail.gmail.com> <7v1wzdmbrd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joan Ripoll Balaguer <joan.ripsa@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 21:37:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex9Bq-00075n-PE
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 21:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161245AbWALUgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 15:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161250AbWALUgs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 15:36:48 -0500
Received: from cabal.ca ([134.117.69.58]:28839 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161245AbWALUgr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 15:36:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fattire.cabal.ca (Postfix) with ESMTP id D13FF23E88;
	Thu, 12 Jan 2006 15:36:32 -0500 (EST)
Received: from fattire.cabal.ca ([127.0.0.1])
	by localhost (fattire [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31463-09; Thu, 12 Jan 2006 15:36:32 -0500 (EST)
Received: from quicksilver.road.mcmartin.ca (quicksilver.road.mcmartin.ca [134.117.69.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quicksilver.road.mcmartin.ca", Issuer "There Is No Cabal Certificate Authority" (verified OK))
	by fattire.cabal.ca (Postfix) with ESMTP id 989BB23E85;
	Thu, 12 Jan 2006 15:36:32 -0500 (EST)
Received: by quicksilver.road.mcmartin.ca (Postfix, from userid 1000)
	id 3275C3B05E; Thu, 12 Jan 2006 15:35:33 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wzdmbrd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cabal.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14587>

On Thu, Jan 12, 2006 at 12:28:38PM -0800, Junio C Hamano wrote:
> 
> I do not think we had a thread on bootstrapping GCC on HP-UX on
> this list ;-).
> 
> Your build log that shows compilation error messages, or if you
> can identify what GCC extension we use that HP-UX C compiler
> does not like then a short summary of the problem, would be
> helpful (of course the latter is preferred).
> 
> One thing I know we deliberately use GCC extension is flex
> array.  "make CFLAGS=-DFLEX_ARRAY=1" might help.  Maybe not.
>

An HP-UX user can fairly trivially install GCC... HP provides
the packages.

http://h21007.www2.hp.com/dspp/tech/tech_TechSoftwareDetailPage_IDX/1,1703,547,00.html 
