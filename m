From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/6] whitespace: more accurate initial-indent highlighting
Date: Mon, 17 Dec 2007 16:32:09 -0800 (PST)
Message-ID: <m3y7bsq1vo.fsf@roke.D-201>
References: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
	<1197822702-5262-1-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-2-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-3-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-4-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-5-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-6-git-send-email-bfields@citi.umich.edu>
	<ACA0791E-189F-4E19-AE87-C7D1163C0366@wincent.com>
	<7vwsrdd9wa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:32:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4QO3-0000Ej-09
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbXLRAcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 19:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757303AbXLRAcO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:32:14 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:52552 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbXLRAcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 19:32:12 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1734212fkz.5
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 16:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=t1DBAqPKxdgd+dkBhf3fss0ORpTTwcHS2P3l16Xpcdk=;
        b=VcPk17+zifVouYR9ie0vAWDiowpCY5O4WRIOjzNne2RqKErJ5cLTPEXjb/OuWEdmSHi8Xzxy9BMqZzlSEMA2YDu/Kza3uivFQGCTMxm+nQJ3qK0rU5bhlbjGHkkAqsWdMjA8VOaqdrMj2jXuEpDyVVceUqng9X8bn8EvQUERCo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=I/EGDGG1rsFVGys2Fi2EuJzuOcJrcWn057jrl9Ij1Hr4ntpJC+rwzG4+1dI7EklXsTP1IwjJkRAO8QgV34ZwQLhl0Hn4f6orOMOaTVKK0tH7mfuhbVLFs/v+LYQCsIb7C5VoLM44WDncMIfe8oawTNp+g4GKm4LCZsfGtgMUtYE=
Received: by 10.82.158.12 with SMTP id g12mr16799589bue.21.1197937931255;
        Mon, 17 Dec 2007 16:32:11 -0800 (PST)
Received: from roke.D-201 ( [83.8.196.52])
        by mx.google.com with ESMTPS id f8sm17130664nfh.2007.12.17.16.32.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2007 16:32:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBI0Vw3N006438;
	Tue, 18 Dec 2007 01:31:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBI0VuTw006435;
	Tue, 18 Dec 2007 01:31:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vwsrdd9wa.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68673>

Junio C Hamano <gitster@pobox.com> writes:

> Wincent Colaiuta <win@wincent.com> writes:
> 
> > Basically I would have proposed extracting out each type of whitespace  
> > error into an inline function in ws.c, where it could be used by both  
> > check_and_emit_line() in ws.c and apply_one_fragment() in builtin- 
> > apply.c.
> >
> > Unfortunately, mixing checking and emission phases makes this proposed  
> > refactoring a little bit ugly.
> 
> The right refactoring would be what JBF hinted in his message, to record
> and return a list of suspicious ranges from the checker function and
> have the highlighter and the fixer make use of that list.
> 
> Such a refactoring is still possible but I think it is beyond the scope
> of pre 1.5.4 clean-up.

By the way, does "trailing empty lines at the end of file" whitespace
error get detected and hightlighted with refactored whitespace checking?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
