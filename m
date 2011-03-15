From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1-2/3 v2 0/3] Re: tests: suppress global and system
 gitattributes
Date: Tue, 15 Mar 2011 04:02:25 -0500
Message-ID: <20110315090225.GA1576@elie>
References: <20110315064909.GA25738@elie>
 <20110315065643.GB29530@elie>
 <20110315071625.GA11754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 10:02:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzQ9I-0001yG-Ni
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 10:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab1COJCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 05:02:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44205 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1COJCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 05:02:32 -0400
Received: by gxk21 with SMTP id 21so142805gxk.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OykbrDXAvVparhBF7uK80U0cEvTNcjXjPXwhFONTaK0=;
        b=n+Nr+goL0odX4dhq8pqBUtJJBBGOkDZoQnjYp5Fo952/mZkjFmaXwene0DPZA6pAoN
         WwNQfx4rDrCRsUTbj2bl/3VjeqISR2nD8Vm4XYeGTJ+3Azeyo8YHLXrFF7FnVo760528
         AcKNbQAYpU96wmVOIn/shnD4UnUWAN25EIuU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AVWg7sJuflBG3q1GUI5CD5avhq6AtfVd5i/svuMbUZ8JkG8lTGxDYaXkCLSTjlcU4r
         foftuneCkIqPgwVv4vFPEW413yh0yAciOgFryPA/ab8rIklFhMRshyxL1QG0nStvdEL1
         fIzgbI/p0K8T9+jrminJgbaxMBTnDks3Q7Dzk=
Received: by 10.236.168.8 with SMTP id j8mr1443539yhl.284.1300179751820;
        Tue, 15 Mar 2011 02:02:31 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id 8sm5990528yhl.44.2011.03.15.02.02.29
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 02:02:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315071625.GA11754@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169051>

Jeff King wrote:

> The alternative would be to
> drop your 1/3 and unset GIT_ATTR_NOGLOBAL in test-lib.sh.

Hmm, how about this?  These are meant as a replacement for 1/3
and 2/3.

Jonathan Nieder (3):
  gitattributes: drop support for GIT_ATTR_NOGLOBAL
  config: drop support for GIT_CONFIG_NOGLOBAL
  tests: suppress system gitattributes

 attr.c                          |    7 +------
 builtin/config.c                |    2 +-
 cache.h                         |    1 -
 config.c                        |    7 +------
 t/t0001-init.sh                 |    5 +----
 t/t5601-clone.sh                |    1 -
 t/t9130-git-svn-authors-file.sh |    1 -
 t/test-lib.sh                   |    4 ++--
 8 files changed, 6 insertions(+), 22 deletions(-)
