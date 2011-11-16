From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] revert: prettify fatal messages
Date: Wed, 16 Nov 2011 00:42:12 -0600
Message-ID: <20111116064013.GA13706@elie.hsd1.il.comcast.net>
References: <1321349492-5653-1-git-send-email-artagnon@gmail.com>
 <7vvcqkswpu.fsf@alter.siamese.dyndns.org>
 <CALkWK0m+us0rCx61+SwSsKuO7qK5mbCs0MpoAzB4ja=wBA+Xjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 07:42:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQZCX-0000If-UM
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 07:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab1KPGmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 01:42:25 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50808 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1KPGmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 01:42:25 -0500
Received: by ggnb2 with SMTP id b2so8388832ggn.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 22:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=axcFP3TpInoqfGMqFuk+mFgtYkpZrmnHtPf6lKPRdgI=;
        b=heB/l42xcaUj8Vpm9vPJVp3zshNoJTxawuJGLGC71k+tXhjoqYSDZIwA4rLE5yAWoQ
         Yi2V35dxZuJ8dpCgP7oXGuxZ0d/PZYqyfbYYPunYWXJ5N875scWvT8luRwg/PkuftvPa
         eP2mDdQTKmlG9MMF9YTmV2WWyRk9R/JsT8x8A=
Received: by 10.101.95.3 with SMTP id x3mr4158853anl.92.1321425744524;
        Tue, 15 Nov 2011 22:42:24 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f32sm82709465ani.20.2011.11.15.22.42.21
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 22:42:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0m+us0rCx61+SwSsKuO7qK5mbCs0MpoAzB4ja=wBA+Xjw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185512>

Ramkumar Ramachandra wrote:

> To avoid confusion, reverts should always look
> like the following:
>
>   Revert [commit message]
>
>   This reverts commit [unabbreviated sha1 hex].

Don't forget the description of why it is being reverted. :)

Actually, I think Matthieu's confusion makes a lot of sense.  I don't
think it matters very much, but it can sometimes be clearer to say
"cherry-pick/revert: remove spurious period in error message".

Another benefit to moving the juicy part to sequencer.c, I guess.
