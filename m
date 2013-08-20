From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Document smart http
Date: Tue, 20 Aug 2013 21:20:45 +0700
Message-ID: <CACsJy8Ax3zJOBYaASnNfu6CTFoTw5=XRdSmK9KTMjSUEEvsE7w@mail.gmail.com>
References: <1376975288-17079-1-git-send-email-pclouds@gmail.com> <20130820141630.GB32370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:21:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmoC-0003IE-8a
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136Ab3HTOVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:21:16 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:55896 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3HTOVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:21:16 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so836358oag.11
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m3/csWB8xa5VUmqeBRR8+aep1bOCD+YLIDhAndxGuHs=;
        b=ICPsAE6BaDriwBJb3ohPDWLbVEXVSF7/nqAYHPeLNXOEq/dyv7nJ5tJG0XxPkIXgf7
         6aZOfilpcNfku91aEtzCqSyGMomuJPAyXvASkw3dBYm02cTlWlkVd9Ge8gyrVEO258uE
         ld7hgjtGI20HW3HBkQnl9HSzXbQwWHA5SCQ/5/uhplPQualvYOr2yN0cGxS5SGmKr7j5
         K9hhz7PiRHERxBYwLsLYkDmKKGqMfYLAEYoTfvJ4QAlf/dBCGm/F47+raP4MUJ2yx4sm
         HPdOMlVxn4D0SLEx5YhZno/Zc0TsgIA4qorGqyXZiqnlsrU53gYhnT4LKhC6hhB6WumY
         jJOg==
X-Received: by 10.60.145.241 with SMTP id sx17mr1818692oeb.57.1377008475598;
 Tue, 20 Aug 2013 07:21:15 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 20 Aug 2013 07:20:45 -0700 (PDT)
In-Reply-To: <20130820141630.GB32370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232602>

On Tue, Aug 20, 2013 at 9:16 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 20, 2013 at 12:08:08PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> This may provide some clues for those who want to modify smart http
>> code as smart http is pretty much undocumented. Smart http "document"
>> so far is a few commit messages and the source code.
>
> There was also this:
>
>   http://article.gmane.org/gmane.comp.version-control.git/129734
>
> which seems to have never gotten updated enough to be applied along with
> the code. But with some updates to make sure it matches the current
> behavior, it is probably a more comprehensive description.

If I knew about this patch, it could have saved me a lot of time
reading remote-curl.c. Will check it with current code and resubmit an
update of this version instead.
-- 
Duy
