From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #08; Sun, 24)
Date: Mon, 25 Jan 2010 14:43:01 -0800 (PST)
Message-ID: <m3eildbydx.fsf@localhost.localdomain>
References: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZXeL-0004OK-9q
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 23:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab0AYWnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 17:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924Ab0AYWnH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 17:43:07 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:51058 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab0AYWnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 17:43:06 -0500
Received: by bwz27 with SMTP id 27so3162223bwz.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 14:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1VDlqYQ/Bwrl5C5TB+VphM8GDQ82fj8atsezVVXVYcY=;
        b=QpEe7eny47CJ/G99pTkBMEAMupkcvvrHATXBP+EsJ8Kl6ZC82IerlT8T1x1L7evjhe
         r8qR6Lzom5yEXiuiwluGFt8k3+dSuhrDTQNS24TrTPP/WC939K/9DHzqcIvjT/+uF8HE
         Ce2kaX+G1EUw3jNx3G6u9AMsTECjPQVcmeodo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=i9XvHqONK7xcrL1pwO1d0ckk6bnmb6AOU3WjqufBsYejSMZNWIEHRg0CHRjuNQ5Txo
         ZzQ6+AdWgtH5t1Ko7LxCPiPWuMfcCCnyftnkX56ksyA4WMBqpejH07N/R0pfaJ19ms8y
         lS/zSCbe2J89RCTNRAMHwt2AXpESSe04mDiXw=
Received: by 10.204.36.85 with SMTP id s21mr569997bkd.1.1264459383420;
        Mon, 25 Jan 2010 14:43:03 -0800 (PST)
Received: from localhost.localdomain (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id 13sm2406436bwz.6.2010.01.25.14.43.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 14:43:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0PMgJII001936;
	Mon, 25 Jan 2010 23:42:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0PMflLe001927;
	Mon, 25 Jan 2010 23:41:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138002>

Junio C Hamano <gitster@pobox.com> writes:


> * jh/gitweb-cached (2010-01-13) 9 commits

>  - gitweb: File based caching layer (from git.kernel.org)
>  - gitweb: Convert output to using indirect file handle

>  - gitweb: cleanup error message produced by undefined $site_header
>  - gitweb: add a get function to compliment print_sort_th
>  - gitweb: add a get function to compliment print_local_time
>  - gitweb: Makefile improvements
>  - gitweb: Add option to force version match
>  - gitweb: change die_error to take "extra" argument for extended die information
>  - gitweb: Load checking
> 
> I know there is a series to split the later ones into smaller chunks that
> are being discussed on the list, but they don't appear here.  I'd prefer
> to pick the series up after all the dust from the discussion settles.

Well, this series actually consist of two parts: miscellaneous gitweb
improvements and actual gitweb output caching.  The first part is more
or less ready; in particular the following patches are I think ready
for inclusion:
 - gitweb: Makefile improvements
 - gitweb: change die_error to take "extra" argument for extended die information
 - gitweb: Load checking
(Although die_error improvements is used by 'force version match',
which is not ready yet).


The following patches needs minimal fixups or extensions.  In
 - gitweb: add a get function to compliment print_sort_th
 - gitweb: add a get function to compliment print_local_time
IMVHO the new (unused) get_* functions should really be named format_*
to follow gitweb convention for naming subroutines.  And of course
that would probably require accompanying change to the commit message.

The patch
 - gitweb: cleanup error message produced by undefined $site_header
solves its problem... but not fully.  There are other variables
holding file names that could, in theory, be undefined.  Also the
commit message should perhaps mention that is defensive coding against
errors in gitweb config file, as in normal situation those variables
would be set to empty string, but not undefined.


I am not sure about the
 - gitweb: Add option to force version match
patch.  It is not that useful if the feature is turned off by default;
on the other hand if the feature is turned on by default the error
message needs to be changed... and be a bit more complicated in the
case when there are no config files (see my reply in thread).


You are right that actual caching support is in flux.  The discussion
continues: it is very good that we have the voice from Pasky, too.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
