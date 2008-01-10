From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Showing abbreviated commit hash of the versions in Compare editor.
Date: Fri, 11 Jan 2008 00:46:40 +0100
Message-ID: <200801110046.41786.robin.rosenberg.lists@dewire.com>
References: <200801072315.30122.rogersoares@intelinet.com.br> <200801082312.00329.robin.rosenberg.lists@dewire.com> <4784247B.10604@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Fri Jan 11 00:47:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD77D-0005l5-Lx
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 00:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYAJXqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 18:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbYAJXqs
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 18:46:48 -0500
Received: from [83.140.172.130] ([83.140.172.130]:24489 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752820AbYAJXqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 18:46:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B54298030C9;
	Fri, 11 Jan 2008 00:46:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o-ntm7VH2+6R; Fri, 11 Jan 2008 00:46:42 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id BBA2F8028A7;
	Fri, 11 Jan 2008 00:46:41 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <4784247B.10604@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70110>

onsdagen den 9 januari 2008 skrev Roger C. Soares:
> Robin Rosenberg escreveu:
> > I'm implementing fetch (with some help from Shawn). Progress in
> > place. I still need to update refs and get in consistent with native
> > git behaviour.
> >
> > I'm also updating the javadocs.
> Cool.
> 
> I use a lot the eclipse feature that highlights all occurences of a 
> variable or method but with all the warnings in the project it is 
> difficult to visually find these occurences. So I'm anxious to remove a 
> lot of warnings. Public methods without documentation are one of them. 
> Is it ok if I send you a patch removing all the warnings I know how but 
> the ones about public methods needing documentation as you're already 
> documenting them? I also want to remove the auto generated TODOs, as 
> they don't actually say what to do, like this one:
> // TODO Auto-generated catch block

I pushed my doc-branch as pu, you can look at it. My intention is take a look again
and then push it as master if there are no objections. Is it ok and good to flags 
public stuff without javadoc as an error (tip pu commit)?

The abbr commit patch is already pushed to master.

-- robin
