From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 19 Apr 2008 18:34:35 +0200
Message-ID: <8c5c35580804190934q3ea27328j76418745b7e7665e@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
	 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
	 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
	 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
	 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
	 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
	 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
	 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
	 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:16:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnG2C-0005QC-1w
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 18:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbYDSQeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 12:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761312AbYDSQeo
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 12:34:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:3755 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759970AbYDSQef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 12:34:35 -0400
Received: by wa-out-1112.google.com with SMTP id m16so1722672waf.23
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7gq7M9jHcGzRE90hKudv2vnNjt6f2DJQLLtYgGQzUac=;
        b=uWFjq3XQdU5AaNOqmISyQpCcq78sq6M2S6tIuzUNAiqhqt8KI+r3M1sAmDFPIhH2ct3WbYkso5v7frq+sRNPHbh1/LTeh7Ur/T4cG9096tgarlRjs4M0rmpgH9jKYB6eC0FB/fvgyEX9YU1EY6j3v08IDAYpCEybDvRzL+7hHlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OrLmm9Nksk2P5x38rBJuU0+uxxNB/T8oC1b5qRcsFJvIeVCwE1xtsW7OAAPd4pkuqZJftOEImxGglcGRn9UHLFJsC2rwJeqp0UAKB0DQMeh05qhHoXuiGxdw8o9iYTAdIJw3J/9S9XywxyWLSlkSczGTAAR9IrMlCy83Zqn/ekc=
Received: by 10.114.124.1 with SMTP id w1mr4019078wac.45.1208622875520;
        Sat, 19 Apr 2008 09:34:35 -0700 (PDT)
Received: by 10.114.241.18 with HTTP; Sat, 19 Apr 2008 09:34:35 -0700 (PDT)
In-Reply-To: <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79909>

On Sat, Apr 19, 2008 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * lh/branch-merged (Fri Apr 18 18:30:15 2008 +0200) 3 commits
>   - Add tests for `branch --[no-]merged`
>   - git-branch.txt: compare --contains, --merged and --no-merged
>   - git-branch: add support for --merged and --no-merged

I notice that you moved the test script into t3201 while still adding
t3202, which probably wasn't your intent.

Would you like me to resend the patches with your fixups to tests and
docs (and maybe even squash them into a single patch)?

--
larsh
