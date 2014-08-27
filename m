From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: mktree: multiple same-named objects
Date: Wed, 27 Aug 2014 12:01:43 +0700
Message-ID: <CACsJy8C+Vg98XjvfSodWLG33mmQOhUrmVKO25EO2MSBTzgttFQ@mail.gmail.com>
References: <1409114517.13351.6.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 07:02:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMVNC-0000Zv-8I
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 07:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaH0FCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 01:02:14 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:50987 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaH0FCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 01:02:14 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so5664825igd.17
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 22:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i3owsjLehPBvZTg1SeBV2ZN0JpxNnCep0Gmze7fJ6b0=;
        b=kqcUXvjU/GqVxeliMYDrNEyOF1MPVA83U/xLkiSoGKZ/MMi/dI3DlowLXaf8i4+c3Z
         Mu6ogdzfOys9ZKyTpahJu9i0rWTswWCJRI+VxCt3f3jmyPz1snGXWKrVKpv8OJjeJoxI
         pIIcgrDzGuN+uox7fg29LJ7QEutBcgCYsOO4E7ecqMa9ZuGpYcWkeJG8JEKC1PIBtbBQ
         VK+Q95zAD/csMEUXij7uGnp0C84zJ9eG1PUDqDnlw/38V8qK1Oen/Cm8OMq5/qkugmCt
         /kszcMmwhjpbNetseM3gqW3BR6T9eC7YHiyIBkbJWkc4kr7mHe73PoaEBiRQ5HI8XR3C
         qexg==
X-Received: by 10.50.61.145 with SMTP id p17mr27028218igr.41.1409115733323;
 Tue, 26 Aug 2014 22:02:13 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Tue, 26 Aug 2014 22:01:43 -0700 (PDT)
In-Reply-To: <1409114517.13351.6.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255979>

On Wed, Aug 27, 2014 at 11:41 AM, David Turner <dturner@twopensource.com> wrote:
> Summary: git mktree ought to forbid this, and possibly there ought to be
> other checks (for instance, when unpacking) to prevent this.

Does fsck detect this (because we ought to fix fsck first if it does not)?
-- 
Duy
