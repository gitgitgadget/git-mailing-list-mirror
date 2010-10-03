From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 6/6] Support case folding in git fast-import when core.ignorecase=true
Date: Sun, 3 Oct 2010 15:00:23 +0200
Message-ID: <AANLkTim=PnESiRa4urT4ADnUAj4BzfQrWKwoc-1XTzDe@mail.gmail.com>
References: <20101003043221.1960.73178.stgit@SlamDunk> <20101003043257.1960.60639.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 15:01:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2OBX-0003a1-SQ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 15:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab0JCNAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 09:00:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58229 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab0JCNAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 09:00:43 -0400
Received: by iwn5 with SMTP id 5so5743263iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=g19VQASqJF8x6xN4+C2K1lYpNZw0UqbPAHQvQWqNfRQ=;
        b=KFxQAgCoC6h+0ezvesPrGyawnLoDiCVxPtKipToOA+WcDi/+W6nEbyGyvl+VErvhwC
         gXLxLr0RuVnDTTv0x16eyr9BQ1P8Xer7hHfTqsk3aCCgIjV65VYyHgdyp2OxJb8f8t/+
         j7voYL70i0oYeJXj7q8L13ZHJ0J8uEPjwzWyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bfHibDhakEBlp6lYS0AhBIbvMZBSUcR1xyOn+BiHd52ShVb9HS+npQh2khZVD7d7SI
         1pfZ2G2Be+cw92axpJFyX0m7VAoeh70YUioya3hpK67K/G/de3XdPPVD5fMW6WDiPSmk
         F1DgWH/QcfnZ1Dz1dARqecT8if7AgcB4Pbf2A=
Received: by 10.231.171.3 with SMTP id f3mr8398974ibz.145.1286110843367; Sun,
 03 Oct 2010 06:00:43 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 06:00:23 -0700 (PDT)
In-Reply-To: <20101003043257.1960.60639.stgit@SlamDunk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157870>

Heya,

On Sun, Oct 3, 2010 at 06:32, Joshua Jensen <jjensen@workspacewhiz.com> wrote:
> When core.ignorecase=true, imported file paths will be folded to match
> existing directory case.

I haven't checked if you got all the relevant cases in fast-import.c,
but the cases you do address look good.

How would this handle incremental imports? How does this handle
someone adding a file twice, with the same name but different case?

-- 
Cheers,

Sverre Rabbelier
