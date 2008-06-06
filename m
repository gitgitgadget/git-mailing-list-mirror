From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Change the POM file to take all the sources from the original location
Date: Fri, 6 Jun 2008 15:27:26 +0200
Message-ID: <200806061527.27212.robin.rosenberg.lists@dewire.com>
References: <1212731380-13221-1-git-send-email-imyousuf@gmail.com> <200806061420.52194.robin.rosenberg.lists@dewire.com> <7bfdc29a0806060545x5b0475cal3325f802aded505d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, imran.yousuf@smartitengineering.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 15:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4c2E-0000qM-V2
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 15:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbYFFNaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 09:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbYFFNaV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 09:30:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21532 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754513AbYFFNaU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 09:30:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 97EAC80287C;
	Fri,  6 Jun 2008 15:30:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3SZKMhVycl6M; Fri,  6 Jun 2008 15:30:18 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E39578026F0;
	Fri,  6 Jun 2008 15:30:18 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7bfdc29a0806060545x5b0475cal3325f802aded505d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84067>

fredagen den 6 juni 2008 14.45.04 skrev Imran M Yousuf:
> On Fri, Jun 6, 2008 at 6:20 PM, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com> wrote:
> > fredagen den 6 juni 2008 07.49.40 skrev imyousuf@gmail.com:
> >> From: Imran M Yousuf <imyousuf@smartitengineering.com>
> >>
> > You could make the patches more readble using -C -C. That would tell people you
> > are copying a whole directory. Maybe someone else could tell my why double -C
> > is needed. It's a 100% failtful copy of those files. Even the base names are the same.
> 
> Is the -C -C option for the binary files?

No, it's the --find-copies-harder. Reading the man page I understand why. The copied
file was not changed in the patch.

-- robin
