From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 14
Date: Tue, 3 Aug 2010 18:23:54 +0530
Message-ID: <20100803125352.GA17010@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 03 14:56:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgH36-0000pn-BD
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 14:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab0HCM4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 08:56:47 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55961 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab0HCM4q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 08:56:46 -0400
Received: by pxi14 with SMTP id 14so1620536pxi.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=yrL5f1bhgv97JVvJ4W4NpdYNlD5hy377qEetYNjxOOE=;
        b=Kf6hcyTNAdNznL3ZYRSgRMlZgjMcByITggPq2rW0o0wTN9IhhHbDqlKXfS9RiIDHeO
         TUaraxBMkqKVCJpriuA0NF4c6LC44gnSE45B3g6gQk9/Xx/7e8gLhqSmbHn6QpLzpoFQ
         mGMX61QhPk0DmTE6vQbdrbJhsTYKwfZdTAIhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=ORWxakINpboW5OJA1kqdn4sH6fQJO2A0+nQqbbu+Uq5BFIgKudj3V7OXHQumVcKLV8
         ViCLK9MpS4Z0pCsNqtMBhqBYbTL6QE4Hp5C97WLIfaJlKZJQngBBRqvopCbhJf58Agfh
         xV2REurhYapyYhCDapup4KkpzOShe8F7Yj1lg=
Received: by 10.143.20.10 with SMTP id x10mr6374642wfi.342.1280840205691;
        Tue, 03 Aug 2010 05:56:45 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm9135174wfa.22.2010.08.03.05.56.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 05:56:44 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152509>

Hi,

I'm happy to report that the flesh and blood of the `svnrdump load`
implementation is done and merged in with tests. Unfortunately, it's
still buggy and doesn't handle some cases- fortunately, this is minor
and shouldn't take me too long to fix up. Collge is eating into my
hacking time, and I don't think I'll be able to do much else before
the SoC officially ends in a couple of weeks. I'll post a full report
then, but if there's anything urgent that I can do before then, do let
me know.

Thanks for reading.

-- Ram
