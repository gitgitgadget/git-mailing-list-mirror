From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Tue, 8 Nov 2011 18:43:25 +0200
Message-ID: <CAMP44s0vsQ5sfx8arrRDo+-g9Zff_MmCz5t+yghwCMx_pL4Xzg@mail.gmail.com>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
	<20111107172218.GB3621@sigill.intra.peff.net>
	<CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
	<20111107183938.GA5155@sigill.intra.peff.net>
	<CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
	<20111107210134.GA7380@sigill.intra.peff.net>
	<7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 17:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNoln-0000S4-IZ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 17:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab1KHQn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 11:43:27 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62477 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab1KHQn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 11:43:26 -0500
Received: by ggnb2 with SMTP id b2so735083ggn.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KXohtP3qWmoTDtNCpn3tlvAuXTsrPBtbNPyoWHTn+7o=;
        b=tYrRvYQSc3ZOBmeZicW4l+K5R9Z7BNck6xlE2/z5ZEMl46LQMaHekw44ZLplldJfUa
         jvTOJMMN8S727pyNJr7PqTtP+6Tj4qNgOUqKIN7jfST9gsz5qxUIbUl7VqzZs7EpbRmv
         CiQUz/dM2nhRqhvKK1ow2lyVnjLtJCs19CCyY=
Received: by 10.68.199.163 with SMTP id jl3mr2086622pbc.25.1320770605299; Tue,
 08 Nov 2011 08:43:25 -0800 (PST)
Received: by 10.68.40.69 with HTTP; Tue, 8 Nov 2011 08:43:25 -0800 (PST)
In-Reply-To: <7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185096>

On Mon, Nov 7, 2011 at 11:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> That makes sense. But I think it fits in with git's current UI to do
>> this via a combination of push options and refspecs. Even if we want to
>> wrap it in some "git remote" command for convenience, I think what
>> you're asking should be implemented as part of "git push".
>
> Yeah, I think it makes sense to give --prune to "push" just like "fetch"
> already has. These two are the primary (and in the ideal world, only)
> operations that talk to the outside world. "remote add -f" might have been
> a tempting "convenience" feature, but I personally think it probably was a
> mistake for the exact reason that letting anything but "push" and "fetch"
> talk to the outside world just invites more confusion. There does not have
> to be 47 different ways to do the same thing.

What about 'git remote update'?

-- 
Felipe Contreras
