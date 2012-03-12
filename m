From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] notes-merge: use opendir/readdir instead of using read_directory()
Date: Mon, 12 Mar 2012 21:53:28 +0700
Message-ID: <CACsJy8A=u_U8qdVcWCBeksC-TvF_JC-=D5Zu6qco5XR7-vef2A@mail.gmail.com>
References: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
 <1331563647-1909-1-git-send-email-johan@herland.net> <1331563647-1909-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, david@tethera.net
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 15:54:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76dS-0000lY-G0
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 15:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab2CLOyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 10:54:02 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52397 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab2CLOyA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 10:54:00 -0400
Received: by wibhq7 with SMTP id hq7so3876156wib.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G21mx7vIm1DkPS8IMGAWDRIvcmeSiksTqaBHSYhvUoQ=;
        b=IuJbMzOvR066CDqqvbPkhYvsxo89GuRPwGNqBlHuYnzJznLQ5oK8cs8HAaK8FEE65G
         E4EH2Dg9yrUz2Y0ffOEXp65cjhRXIfSZP5JNTMY7Q6/1eooXiaO35S/8kZQlTmU7pgJd
         OTz4cgIy8epaaGRfa5/v+gxLDNb7YVtUPL3AyQ0WNqOJKGdNzv+l77pRAr5+qxA27cAf
         h/fC8pNoIaBZVFMYR7gsAWG4jvUT50x+n9/1r7JtLpS3LRffcP+/z0Mzw54lvkpmdDN/
         1hMYDqTLDBHZJaWVsDbQXPB3EG3wIn/7EPFF8LD9Q5Ww1KgCmw0wfDXKUHgdHXWR39+9
         NTfw==
Received: by 10.180.91.10 with SMTP id ca10mr27391162wib.17.1331564039440;
 Mon, 12 Mar 2012 07:53:59 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Mon, 12 Mar 2012 07:53:28 -0700 (PDT)
In-Reply-To: <1331563647-1909-2-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192870>

On Mon, Mar 12, 2012 at 9:47 PM, Johan Herland <johan@herland.net> wrote:
> This is a resurrection of pclouds' patch 2/11 in a patch series sent
> last October for rewriting read_directory(). This patch doesn't
> actually touch read_directory(), but instead rewrites
> notes_merge_commit() to use opendir()/readdir() instead of
> read_directory(). Since the usage of read_directory() is what caused
> the bug that David found (in the previous patch), this rewrite happens
> to fix that bug as well.

Happy to help. And that reminds me I've got to revive the
read_directory() rewrite soon. Got stuck at git-add because I aimed
too high. Gaah...
-- 
Duy
