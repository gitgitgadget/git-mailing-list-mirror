From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for long forms of -M and -C.
Date: Thu, 11 Nov 2010 19:00:05 -0800
Message-ID: <7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org> <1289420833-20602-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Nov 12 04:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGjsU-0001Ee-Ge
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 04:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab0KLDAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 22:00:10 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41037 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab0KLDAI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 22:00:08 -0500
Received: by pva4 with SMTP id 4so531500pva.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 19:00:07 -0800 (PST)
Received: by 10.142.140.7 with SMTP id n7mr1196054wfd.302.1289530807531;
        Thu, 11 Nov 2010 19:00:07 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w14sm3205611wfd.6.2010.11.11.19.00.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 19:00:06 -0800 (PST)
In-Reply-To: <1289420833-20602-2-git-send-email-ydirson@altern.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161318>

On Nov 10, 2010, at 12:27 PM, Yann Dirson wrote:

> -M[<n>]::
> ---detect-renames[=<n>]::
> +--find-renames[=<n>]::
> ifndef::git-log[]
> 	Detect renames.
> endif::git-log[]
> @@ -246,7 +246,7 @@ endif::git-log[]
> 	hasn't changed.
> 
> -C[<n>]::
> ---detect-copies[=<n>]::
> +--find-copies[=<n>]::
> 	Detect copies as well as renames.  See also `--find-copies-harder`.
> 	If `n` is specified, it has the same meaning as for `-M<n>`.

I'm not sure I like the wording --find-copies and --find-renames. Maybe I'm
just being silly, but it sounds like those are directives, saying "I want you
to find copies/renames", as opposed to just saying "while you're working you
should also detect copies/renames". The original flag --find-copies-harder
is a bit different, because it's modifying the action of finding copies
rather than making finding copies the prime directive.

On the other hand, --detect-copies and --detect-renames sounds to me like
you're just telling it that it should, well, detect copies/renames as it goes
about its business.

-Kevin Ballard
