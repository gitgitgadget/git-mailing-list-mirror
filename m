From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Configure the maven surefire plugin to
	specifically include all tests
Date: Fri, 12 Sep 2008 07:47:09 -0700
Message-ID: <20080912144709.GC22960@spearce.org>
References: <20080911213927.GA20238@diku.dk> <200809120047.58484.robin.rosenberg.lists@dewire.com> <20080912000007.GA31931@diku.dk> <9e85b2570809111851y756fdb3en2c17c69bf5ac444e@mail.gmail.com> <20080912084030.GA4964@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imran M Yousuf <imran@smartitengineering.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Sep 12 16:49:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke9x5-0004AL-2c
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 16:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbYILOrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 10:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbYILOrL
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 10:47:11 -0400
Received: from george.spearce.org ([209.20.77.23]:47430 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbYILOrK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 10:47:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3D4EB3835C; Fri, 12 Sep 2008 14:47:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080912084030.GA4964@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95728>

Jonas Fonseca <fonseca@diku.dk> wrote:
> By default, the test cases named T000* were not included. With this
> patch maven reports that 508 tests have been run.

Thanks.  508 is the correct current number of tests.
 
> +            <plugin>
> +                <artifactId>maven-surefire-plugin</artifactId>
> +                <version>2.4.2</version>
> +                <configuration>
> +                    <includes>
> +                        <include>**/*Test.java</include>
> +                        <include>**/*TestCase.java</include>
> +                        <include>**/T000*.java</include>
> +                    </includes>
> +                </configuration>
> +           </plugin>

-- 
Shawn.
