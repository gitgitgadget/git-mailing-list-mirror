From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 12:47:15 +0000 (GMT)
Message-ID: <956681.9844.qm@web27803.mail.ukl.yahoo.com>
References: <2c6b72b30909040541t4c781378g3f35aeb70021050c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:47:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjYCJ-0002Ja-Ic
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813AbZIDMrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756800AbZIDMrP
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:47:15 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:29983 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756796AbZIDMrO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 08:47:14 -0400
Received: (qmail 10227 invoked by uid 60001); 4 Sep 2009 12:47:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1252068435; bh=BAS6Xftzp3bYmDRZBu8DEto1ek5E6HMDNsGhTiDuj34=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=aps9zeGTvnTdqSLY0VALpxnCFI8cM3WU3djL9LmXlWluHbCVloIKRMreLBroZImles1/VvqXkPXDBujt9bzkhUN2WoFlo86IitazaHdCMsB0tB5Ps61lCo89OwUPkuKIUVfFDGrkmfFhe4pbrEv7IeBl1eTTtHikF1G+vZsc6rM=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=MyuiHkqakzRqH2OlIf6Z9FF3R02MC8dGgOblr+ALAas2GObqwzVAdLxdb9mTf1/RWr7xn6rurZjISTk+7NkPWSOq3KUnjCDYielPNaDbQmqAxkA3gF7T0GLEFD8OxSgiBaxy8PEVskKN2HkVPBg9LjbuKcCu3zwILXf3ptbNeac=;
X-YMail-OSG: hNPNNEoVM1lwi4XJLsM2ZHKnw4lueM3jajVEGSnIondJKt5t6.W6BQrDu7ptT3W8n5RhmkEcxw89JDC14MNSlZHeqH8fiZSwZenul3IAfxBb0kUQiWQHk70j6XOt45b49yGvvk3wy00YamIVPbJ_O99oXGVUSbHGEIG91UjDWhUeh.ekZeztM3tLtoe7I3.zbvd6iNy9195vIOSqaeSITW7RuZRSLUUGUODFAcc0mjPdxwTtFA.pSXbrRsCaJQAKfTZiGxEzY4qEDlkPUVJYbC_B3J6iVupbSizJLHavvomFXMhYhyauqxo-
Received: from [81.16.153.112] by web27803.mail.ukl.yahoo.com via HTTP; Fri, 04 Sep 2009 12:47:15 GMT
X-Mailer: YahooMailClassic/6.1.2 YahooMailWebService/0.7.338.2
In-Reply-To: <2c6b72b30909040541t4c781378g3f35aeb70021050c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127730>

as an old saying tells us: how to climb a mountain? step after step! ;)

I suggest we create a fresh branch based on the Shawns current version and add all the features incrementally.

1.) move the directory structure over to mavens std layout
2.) create the scm section and try releases
3.) improve site generation and documentation
tbc


LieGrue,
strub


--- On Fri, 9/4/09, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:

> From: Jonas Fonseca <jonas.fonseca@gmail.com>
> Subject: Re: [JGIT] Request for help
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: git@vger.kernel.org, "Gabe McArthur" <gabriel.mcarthur@gmail.com>
> Date: Friday, September 4, 2009, 2:41 PM
> On Fri, Sep 4, 2009 at 03:33, Mark
> Struberg<struberg@yahoo.de>
> wrote:
> >> From: Gabe McArthur <gabriel.mcarthur@gmail.com>
> > >
> >> I'll try to submit a full patch later, using your
> >> conventions.
> 
> I have a question as well:
> 
> Support for using find bug is part of the Eclipse
> configuration (see
> org.spearce.jgit/findBugs/), and I know that there's a find
> bug plugin
> for Maven. From looking at sonatype's JGit repositories it
> is not
> integrated. Have you managed to include it?
> 
> -- 
> Jonas Fonseca
> 


      
