From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: git clone failing over slow links?
Date: Tue, 9 Jun 2009 10:12:32 -0700
Message-ID: <robbat2-20090609T171032-419739557Z@orbis-terrarum.net>
References: <2729632a0906090852r124eff8eo8391ae90cbda5872@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 19:12:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME4sR-0008S8-Sj
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 19:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbZFIRMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 13:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755025AbZFIRMg
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 13:12:36 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:44494 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754332AbZFIRMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 13:12:36 -0400
Received: (qmail 14434 invoked from network); 9 Jun 2009 17:12:35 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 09 Jun 2009 17:12:35 +0000
Received: (qmail 5093 invoked by uid 10000); 9 Jun 2009 10:12:32 -0700
Content-Disposition: inline
In-Reply-To: <2729632a0906090852r124eff8eo8391ae90cbda5872@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121191>

On Tue, Jun 09, 2009 at 08:52:10AM -0700, skillzero@gmail.com wrote:
> People with slower connections are having problems cloning my
> repository. The server seems to just drop the connection. This
> repository is about 300 MB. The server is using git 1.6.1. This is
> using an ssh URL. They've tried many times and it usually dies at
> different places in the clone (5%, 80%, etc., with one successful
> clone so far for them).
For Gentoo, we saw what I think was same problem early on with our
conversion experiments. In our case however, it's going to be a
non-problem as we intend on disabling initial clone and requiring use of
a bundle.

-- 
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
