From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Find the size of git push in pre-receive hook
Date: Fri, 4 Nov 2011 10:46:44 +0100
Message-ID: <20111104094644.GA31856@jpl.local>
References: <1320398420796-6962141.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: manigandans <etc.mani@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 10:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMGMP-0002um-EV
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 10:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab1KDJqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 05:46:47 -0400
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:36155 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab1KDJqr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 05:46:47 -0400
Received: from iph4.telenor.se (iph4.telenor.se [195.54.127.135])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id B072BD6EB
	for <git@vger.kernel.org>; Fri,  4 Nov 2011 10:46:45 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhQRABqzs05T46eEPGdsb2JhbABDiUGQS497GQEBAQE3MoFyAQEEATIBIyMFCws0EhQNCwEMChoTiAICtQSISGMEnliHKw
X-IronPort-AV: E=Sophos;i="4.69,455,1315173600"; 
   d="scan'208";a="2000986763"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by iph4.telenor.se with ESMTP; 04 Nov 2011 10:46:45 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 568D9423AE; Fri,  4 Nov 2011 10:46:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1320398420796-6962141.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184766>

On Friday, November 04, 2011 at 10:20 CET,
     manigandans <etc.mani@gmail.com> wrote:

> I want to restrict the size of the push on the git remote repository.
> How can I find the size of the push in pre-receive hook?

What does "size of the push" mean to you? Number of bytes transmitted
over the wire? Number of commits pushed? Number of refs updated? Number
of files modified? Number of lines modified? Something else?

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
