From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [Security] gitweb local privilege escalation (fix)
Date: Sat, 20 Dec 2008 20:26:48 +0900
Message-ID: <20081220202648.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 12:29:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE01G-0005tB-S7
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 12:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbYLTL2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 06:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbYLTL2A
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 06:28:00 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36597 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471AbYLTL17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 06:27:59 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id E7B58C7AE6;
	Sat, 20 Dec 2008 05:27:58 -0600 (CST)
Received: from 7613.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id CGAP12AO4B17; Sat, 20 Dec 2008 05:27:58 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=y6fy9arR2c9tkb6gHVmQd9C4/WlTCJLm6QrfAlf6eG5DzSt1M/fBLowYaBpmvzZxFG5Dq1C28Czj0j038c62ty8QWvDPKy36V6iwVxPSRaqvzi/ViLYAilKBgIimsYM5OZFYhjIX3B0z2dJkrw1iBX8zsZ4Jg6U8dMxAxXfI20c=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103639>

Quoting Jakub Narebski <jnareb@gmail.com>:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Current gitweb has a possible local privilege escalation bug that allows a
>> malicious repository owner to run a command of his choice by specifying
>> diff.external configuration variable in his repository and running a
>> crafted gitweb query.
>> 
>> Recent (post 1.4.3) gitweb itself never generates a link that would result
>> in such a query, and the safest and cleanest fix to this issue is to
>> simply drop the support for it.  Maintenance release v1.6.0.6, v1.5.6.6,
>> v1.5.5.6 and v1.5.4.7 are already available at k.org (see the announcement
>> for v1.6.0.6 I sent out a few minutes ago), and the master branch and
>> others pushed out tonight have the same fix.
>
> From what I have found diff.external works only since v1.5.4 (see
> commit cbe02100), so when gitweb started using git-diff for old
> legacy links to not use $tmpdir and /usr/bin/diff -u it wasn't an
> issue...

Sorry, but I do not understand what you are trying to say.

The maintenance releases Junio listed above go only as far back as v1.5.4.X series, so it covers the necessary range of versions, and no further back than that.  Do you see a problem with that?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
