From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Fri, 30 Sep 2011 13:23:48 +0000
Message-ID: <CAMOZ1BsTKBPArRF-LxoNOJcQarMWx-2a2UBoVjWN-96xJ3Ad8A@mail.gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Shenkin <shenkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 15:24:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9d4i-0006J8-VR
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 15:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050Ab1I3NYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 09:24:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51282 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab1I3NYT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 09:24:19 -0400
Received: by iaqq3 with SMTP id q3so1819873iaq.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kxQpQe8M5ehTCN0j2mdfCx4O57HpdzkJdFhMxAWM52A=;
        b=sgllRUwJGMuOqTJNvLuvrKs3nr/jNu0niSK4iNIwnFIUxcbplWI0iF1Sm11VJUSwnc
         DefsYpQ+zT1/HceJdzw5gSabdc81K/EZHxJwx1WfYaEnjH7do9xysPTqUiYCfWL0Zso6
         PZ1m/hxFnnqwOst3q5m6BkOU9UUpH62ELznLQ=
Received: by 10.42.154.132 with SMTP id q4mr2743954icw.106.1317389058166; Fri,
 30 Sep 2011 06:24:18 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Fri, 30 Sep 2011 06:23:48 -0700 (PDT)
In-Reply-To: <loom.20110930T041939-332@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182481>

On Fri, Sep 30, 2011 at 02:51, Peter Shenkin <shenkin@gmail.com> wrote:
> Perhaps it will be useful to say what would have been most
> helpful for me. In the current documentation for "fetch
> --tags", one sentence reads, "This flag lets all tags and
> their associated =C2=A0objects be downloaded." The following small
> modification would, IMO, be sufficient: "This flag causes all
> tags and their associated objects (only) to be downloaded."

Well, you're missing the fact that it not only causes those to
be downloaded, but it also causes the defaults to be ignored,
which is why you don't get the other stuff. You can still tell
git to fetch anything else you want in addition.

See here:

  [PATCH v3] Docs: Clarify the --tags option of `git fetch'
  Message-ID: <686c38876d5a4ad6bfac67ca77fe9bb3-mfwitten@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/181887
