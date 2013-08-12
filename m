From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 20:23:04 +0700
Message-ID: <CACsJy8A-aSjNdSkiBUBSH43G_FBMnShfpkcwQqM9-6d41rfCUA@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
 <CA+CP9O7--HXQdZXH9MJEh0VqdwpYqb052KYrvZqYhbfajpPG0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Jeske <davidj@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 15:23:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8s5z-00075e-TM
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 15:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab3HLNXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 09:23:35 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:53071 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455Ab3HLNXe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 09:23:34 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so9565442oag.41
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0moAEOutHLv5eYnnsZVu0WNgZUA+DdUHui6127WN7Q4=;
        b=LiEonubuYquX+Ba14JpVNpjZI1jxOjLF97+HIPhKf9JWufBy4+ALMDlP0NIIO3Zn0X
         6966TcEyeia+UnXQ71ZnT8UwOBQiWBhD3Bvr5FFNPbqM9rFHW3983ltABqPeCStNETlE
         +y0UmNcsWpOdOZNuDP0yjGdcCr139x8/I9Ej+kOWuE2oi7mNdqSRBhz7oDH5PUG8m+GN
         rg0Dl0e7p/OidC41gzAyY/POUhXcofGCqfx4j2GO2pCEWEd5HxBTudfojPjteHdhYeft
         yiiGUJDnk+r/rq4gkUCkd9nYAvQfdzuec2tbyaiB/wA8271ydJFH1li5GPEnv3OuMUUG
         D+Fw==
X-Received: by 10.60.132.113 with SMTP id ot17mr454248oeb.104.1376313814168;
 Mon, 12 Aug 2013 06:23:34 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 12 Aug 2013 06:23:04 -0700 (PDT)
In-Reply-To: <CA+CP9O7--HXQdZXH9MJEh0VqdwpYqb052KYrvZqYhbfajpPG0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232191>

On Mon, Aug 12, 2013 at 7:14 PM, David Jeske <davidj@gmail.com> wrote:
> IMO, the current warning during checkout of a detached-head is
> misplaced. It should be removed, and instead there should only be a
> warning after detached-head commit, since this is the only time there
> is a danger of losing something.

That would annoy me as I often work on top of detached HEAD on purpose
and only create a branch when I want to save something. If the warning
is to be moved, it should warn at the next checkout.
-- 
Duy
