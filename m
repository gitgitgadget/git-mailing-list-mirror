From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: don't allow to note on empty branch
Date: Fri, 23 Sep 2011 00:29:24 +0200
Message-ID: <CAGdFq_jDvWveWm5cOXA9QQC+PmaEvwmEs7PmjoACmQXxkdT62g@mail.gmail.com>
References: <1316720825-32552-1-git-send-email-divanorama@gmail.com> <1316720825-32552-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 00:30:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rmV-0000Qm-5R
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab1IVWaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:30:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60116 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab1IVWaF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:30:05 -0400
Received: by ywb5 with SMTP id 5so2322318ywb.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q1HwhVdQDHDQ95y7GxqwEluGaMp2SK2TFdcgvlG/tuY=;
        b=SFDMXtK0ejZAn3a5VmyZ7rI0inxdkZ9daIif25SZ39VbINSvp8pKW6pckwre6QUatB
         fSnu5+365Sjwv1N2UTIETKu/bs3i7D5pdtW2mdkCX4cu41Uhn4xVjMGe5N5iLasQcKlM
         UYOPwgqw22AKzRJVcLzUHmpVmIVECDGHV40vM=
Received: by 10.68.44.225 with SMTP id h1mr6505308pbm.85.1316730604103; Thu,
 22 Sep 2011 15:30:04 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Thu, 22 Sep 2011 15:29:24 -0700 (PDT)
In-Reply-To: <1316720825-32552-3-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181930>

Heya,

On Thu, Sep 22, 2011 at 21:47, Dmitry Ivankov <divanorama@gmail.com> wrote:
> 'reset' command makes fast-import start a branch from scratch. It's name
> is kept in lookup table but it's sha1 is null_sha1 (special value).
> 'notemodify' command can be used to add a note on branch head given it's
> name. lookup_branch() is used it that case and it doesn't check for
> null_sha1. So fast-import writes a note for null_sha1 object instead of
> giving a error.
>
> Add a check to deny adding a note on empty branch and add a corresponding
> test.

Makes sense as well.

-- 
Cheers,

Sverre Rabbelier
