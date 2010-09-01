From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: next no longer compiles on non-gnu platforms
Date: Wed, 1 Sep 2010 16:35:13 +0000
Message-ID: <AANLkTi=5gz5pTZtV8y2d-XWfCCTSRqt0m11zke04t9bv@mail.gmail.com>
References: <8DusojDb7VpklNHC3-7Gf5asKbh2H3Cql9FiAGL1ccyieG0lQClVow@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, jjensen@workspacewhiz.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 01 18:35:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqqHW-0007R9-Px
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 18:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab0IAQfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 12:35:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40722 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab0IAQfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 12:35:15 -0400
Received: by fxm13 with SMTP id 13so4852091fxm.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=/NP9hP4xw1RnzN/mhvw3Gog9FokmPPVOY3yvks+SOQs=;
        b=H8e3UtfSgxrPWmxV+N8ilFhfgPcsCgkWnpq+IbvUVSHJYsq80/xSt3bKOGNN3sM8rU
         k7pgBN/rMwOcVeLCF+0Ycu0J2Hg+8TwkESZ+oYhAjnRCglnZJ6CkX5bClvoOi8oiEPOz
         V9bKstecuIC0f8qzKVWAo69iTpKhWt84zSpy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=N6S7hK/kR9pYw57fSeRP3V3iZx/X8BpUGM7j11zp7f8j2KV3PojmZLCEBcuOIBBu4L
         yS42z1/CFEv7ZilzA1bn5NZ5i/Lx5oL6+VHmDzWGY8cvRt+Du/xwS/JIieGR/Hnt/WBz
         KhQEJu+oMOMzjfNGP24BVi8FEPlclx/zsKUnY=
Received: by 10.223.109.130 with SMTP id j2mr5794997fap.54.1283358913498; Wed,
 01 Sep 2010 09:35:13 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Wed, 1 Sep 2010 09:35:13 -0700 (PDT)
In-Reply-To: <8DusojDb7VpklNHC3-7Gf5asKbh2H3Cql9FiAGL1ccyieG0lQClVow@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155060>

On Wed, Sep 1, 2010 at 16:32, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:

> Since 83c0e5ad 'Add string comparison functions that respect the
> ignore_case variable.' was merged to next, it can't be compiled on
> platforms without the GNU FNM_CASEFOLD extension to fnmatch.
>
> If we're going this route, then non-gnu platforms will need to
> build with the fnmatch in compat/ and Makefile will need a
> NO_FNMATCH define.

This is already known, and a fix is in the works, see the "[PATCH 1/6]
Add string comparison functions that respect the ignore_case
variable." thread.
