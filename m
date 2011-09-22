From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/2] fast-import: don't allow to tag empty branch
Date: Fri, 23 Sep 2011 00:28:59 +0200
Message-ID: <CAGdFq_jxDD3_MLWAsv5WtCoSFXDm-EBB0=28aH-MqBdbGhpC3Q@mail.gmail.com>
References: <1316720825-32552-1-git-send-email-divanorama@gmail.com> <1316720825-32552-2-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 00:29:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rm6-0000Ea-LL
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab1IVW3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:29:40 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40906 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab1IVW3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:29:39 -0400
Received: by pzk1 with SMTP id 1so5717222pzk.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 15:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lW28VeETsF51uC6fX2RClwHW7rxkXkQFA4q+OYGoH4c=;
        b=snZNliDXge0u7CcYmMXXq4aVQ2qfaK5s31BEI5OyBgQf9Wf8kiZPlhAZO04tOgcKK8
         cLSmG/9pRudYvan4FlpC6jo2ItzxPqXmxKmpTYn8J1qh45PVw/6eP5eUbqjmc1a7Pzw0
         B70S8+eU8H3D4fbB2najDfzDx166qU8FEpHeg=
Received: by 10.68.14.102 with SMTP id o6mr6493648pbc.51.1316730579183; Thu,
 22 Sep 2011 15:29:39 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Thu, 22 Sep 2011 15:28:59 -0700 (PDT)
In-Reply-To: <1316720825-32552-2-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181929>

Heya,

On Thu, Sep 22, 2011 at 21:47, Dmitry Ivankov <divanorama@gmail.com> wrote:
> 'reset' command makes fast-import start a branch from scratch. It's name
> is kept in lookup table but it's sha1 is null_sha1 (special value).
> 'tag' command can be used to tag a branch by it's name. lookup_branch()
> is used it that case and it doesn't check for null_sha1. So fast-import
> writes a tag for null_sha1 object instead of giving a error.
>
> Add a check to deny tagging an empty branch and add a corresponding test.

Makes sense to me.

-- 
Cheers,

Sverre Rabbelier
