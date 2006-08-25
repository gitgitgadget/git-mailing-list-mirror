From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Running gitweb under mod_perl
Date: 24 Aug 2006 18:13:38 -0700
Message-ID: <86lkpdobwd.fsf@blue.stonehenge.com>
References: <eck6sq$agn$1@sea.gmane.org> <eckor9$jje$1@sea.gmane.org>
	<20060824193220.G4a28fdc4@leonov.stosberg.net>
	<ecl3v4$s14$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 03:13:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGQGV-0006p9-Fq
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 03:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbWHYBNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 21:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422816AbWHYBNk
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 21:13:40 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:33558 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1030494AbWHYBNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 21:13:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id F07478FA99;
	Thu, 24 Aug 2006 18:13:38 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 05969-02-26; Thu, 24 Aug 2006 18:13:38 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 817C48FA9A; Thu, 24 Aug 2006 18:13:38 -0700 (PDT)
To: Jakub Narebski <jnareb@gmail.com>
x-mayan-date: Long count = 12.19.13.10.9; tzolkin = 7 Muluc; haab = 2 Mol
In-Reply-To: <ecl3v4$s14$1@sea.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25991>

>>>>> "Jakub" == Jakub Narebski <jnareb@gmail.com> writes:

Jakub> Is there any way to check at _runtime_ if script is run under mod_perl,
Jakub> or would it be simplier (after script reorganization) for install time
Jakub> selection of using CGI, FastCGI, or Apache2::something...?

Yeah, look at the first few dozen lines of CGI.pm - it has to do different
things based on whether it's being run under mod_perl.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
