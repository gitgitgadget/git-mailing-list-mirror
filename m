From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: commit summary, --pretty=short and other tools
Date: Tue, 18 Sep 2007 11:13:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181109130.28586@racer.site>
References: <20070917112136.GA30201@glandium.org>
 <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr> <46EF7BF7.3070107@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXa6S-00015R-5L
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbXIRKOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbXIRKOj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:14:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:33049 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753320AbXIRKOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:14:38 -0400
Received: (qmail invoked by alias); 18 Sep 2007 10:14:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 18 Sep 2007 12:14:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JCecA8S+JYQzyx5i7xW6xMFZEoM7L5iJSfTRVGb
	A3of8iKXsE5MZr
X-X-Sender: gene099@racer.site
In-Reply-To: <46EF7BF7.3070107@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58568>

Hi,

On Tue, 18 Sep 2007, Andreas Ericsson wrote:

> const char *find_commit_subject_end(const char *commit_msg)
> {
> 	const char *dot, *paragraph_end;
> 		paragraph_end = strstr(commit_msg, "\n\n");
> 	dot = strchr(commit_msg, '.');
> 		return min_non_null(dot, paragraph_end); }
> 
> would probably get it right very nearly always.

Counterexample (not even mentioning the missing handling of NULL):

http://brick.kernel.dk/git/?p=qemu.git;a=commit;h=eb66d86e295cd5a8f13221589806e15db62a62fa

And no, the responsible developer showed a strong unwillingness to adapt 
to better tools and workflows.

Ciao,
Dscho
