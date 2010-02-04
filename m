From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
	count in bytes
Date: Wed, 3 Feb 2010 20:00:46 -0800
Message-ID: <20100204040046.GR14799@spearce.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net> <1265255308-20514-3-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 05:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcsuL-0002rd-W2
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 05:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab0BDEAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 23:00:52 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:33492 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab0BDEAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 23:00:51 -0500
Received: by iwn39 with SMTP id 39so2522527iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 20:00:50 -0800 (PST)
Received: by 10.231.169.144 with SMTP id z16mr1015460iby.25.1265256049944;
        Wed, 03 Feb 2010 20:00:49 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm345976iwn.6.2010.02.03.20.00.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 20:00:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1265255308-20514-3-git-send-email-nico@fluxnic.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138945>

Nicolas Pitre <nico@fluxnic.net> wrote:
> The value passed to --max-pack-size used to count in MiB which was
> inconsistent with the corresponding configuration variable as well as
> other command arguments which are defined to count in bytes with an
> optional unit suffix.  This brings --max-pack-size in line with the
> rest of Git.
...
>  Documentation/RelNotes-1.7.0.txt   |    8 +++++++-
>  Documentation/config.txt           |   11 +++++++----
>  Documentation/git-pack-objects.txt |    5 +++--
>  Documentation/git-repack.txt       |    8 +++++---
>  builtin-pack-objects.c             |   11 ++++++-----
>  t/t5300-pack-object.sh             |   14 ++++++++------
>  6 files changed, 36 insertions(+), 21 deletions(-)

Shouldn't we also change fast-import.c ?

-- 
Shawn.
