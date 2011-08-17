From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: shallow clone not very shallow due to tags
Date: Wed, 17 Aug 2011 21:35:52 +0700
Message-ID: <CACsJy8BGf1uV13PrPHi621N_aeXzamOFv_yZQoL0gxUxqv-_hQ@mail.gmail.com>
References: <CAJo=hJuyZMj+qwFr_=stbQtGh2SCCpjfsBxm+2wbfJK=i_VTdw@mail.gmail.com>
 <CACsJy8DF49PJtv41vZEOX0fLg4U1+m6JEW28+iYD6jJxGctEzg@mail.gmail.com>
 <CAJo=hJv_NnZyGnedTQBL_mj3baS8O5Z2wiEbZCvv8305No4ehA@mail.gmail.com>
 <CACsJy8CXiZ8uGruAk5XGFhY8MJsTHAPv3Mvh0euQdFE3U43MCg@mail.gmail.com> <CAJo=hJvySfuWmz6vGUveC5KoR1NZGC4ji0saByVX40UxLqHqdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 16:36:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QthEK-0002Pt-8N
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 16:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab1HQOgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 10:36:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51906 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab1HQOgX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 10:36:23 -0400
Received: by bke11 with SMTP id 11so744318bke.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=STWIZeUUNKtkjeS2qXdD2BzsCwSFXg6Pz3MUs1e7+Yw=;
        b=OboJ48Qy18pEFXmnGmlysKqj1mpw8I1oKorrH3yeV+/9+HNsgczuhrVBvDgRgc5dri
         tmT9XNp8hXCWD8njvPQxneepEx274oa0xRlX7PZ13EUe2KmO/luriGM6tvuuZ6UCS0bS
         WUcLu4SI4YSywvSw5PXvk7BEMDJTrkI24eWTQ=
Received: by 10.204.231.201 with SMTP id jr9mr448519bkb.279.1313591782356;
 Wed, 17 Aug 2011 07:36:22 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Wed, 17 Aug 2011 07:35:52 -0700 (PDT)
In-Reply-To: <CAJo=hJvySfuWmz6vGUveC5KoR1NZGC4ji0saByVX40UxLqHqdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179515>

On Wed, Aug 17, 2011 at 9:19 PM, Shawn Pearce <spearce@spearce.org> wrote:
> Of course a placeholder ref cannot be used as a starting point to
> checkout something, can it? It has no commit object available. So if
> you did decide to checkout a placeholder, you would need to first
> fetch that placeholder. So why not use git ls-remote to list the
> remotely available branches?

Ah.. ls-remote is the answer. Thanks, placeholders are gone (for me).
-- 
Duy
