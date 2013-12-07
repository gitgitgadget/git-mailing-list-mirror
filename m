From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Sat, 07 Dec 2013 04:03:39 -0600
Message-ID: <52a2f27bfe07_29836d5e98f5@nysa.notmuch>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 11:16:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpEvV-00011c-9a
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 11:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171Ab3LGKPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 05:15:53 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46587 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab3LGKPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 05:15:50 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so1892461obc.29
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=0y9YxBlOPdqYLikUOLIJIEhtbL0l+tZiDX58iQ/yJ9Q=;
        b=Jo/bwYxvqpHs2fmf24qEDN/pS54+nAw847CPbHiakRY/fr+j8ja+BUhrxfdBomxurF
         JukZg6TNcTWgKDxtpWX2Ij3A+r5HXT7BaSogdslxFCRiU+6tRUwDHnirB+pcnZmmS/1l
         sd/5AY38DYDoydmtQNEgw4eCJ2dH9bs0zS0x3BogAn5opCKG6hHA5AQHt3T2ZXXnXgqh
         czgj9X8pqZESTU8sqm3EMzC79409ahVp1vANuXkhg4NsuZE1pZ+A8wzp6YiF5rPRXlCa
         Cjxk8zrz8P9z2SUpBCq8BIk8CK8aNR8hdi7oy/OSbPqrkLR3K1I5DwGN7VB287Iblq3k
         Nr0w==
X-Received: by 10.183.3.102 with SMTP id bv6mr5985789obd.18.1386411350213;
        Sat, 07 Dec 2013 02:15:50 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm1228989obo.7.2013.12.07.02.15.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 02:15:49 -0800 (PST)
In-Reply-To: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238975>

Junio C Hamano wrote:
> * fc/transport-helper-fixes (2013-11-13) 12 commits
>  - remote-bzr: support the new 'force' option
>  - transport-helper: add support to delete branches
>  - fast-export: add support to delete refs
>  - fast-import: add support to delete refs
>  - transport-helper: add support for old:new refspec
>  - fast-export: add new --refspec option
>  - fast-export: improve argument parsing
>  - test-hg.sh: tests are now expected to pass
>  - transport-helper: check for 'forced update' message
>  - transport-helper: add 'force' to 'export' helpers
>  - transport-helper: don't update refs in dry-run
>  - transport-helper: mismerge fix
> 
>  Updates transport-helper, fast-import and fast-export to allow the
>  ref mapping and ref deletion in a way similar to the natively
>  supported transports.
> 
>  The option name "--refspec" needs to be rethought. It does not mean
>  what refspec usually means, even though it shares the same syntax
>  with refspec; calling it --refspec only because it shares the same
>  syntax is like calling it --asciistring and does not make sense.

Not true. remote.<name>.fetch is a refspec, and doesn't specify what to fetch,
so does the "refspec" capability in remote helpers, and so does the proposed
--refspec option.

It is exactly what it already means.

-- 
Felipe Contreras
