From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [BUG] git config does not reuse section name
Date: Mon, 7 Dec 2009 21:23:20 +0100
Message-ID: <fabb9a1e0912071223l21c70e2ax9b0e3c9976ae9d7@mail.gmail.com>
References: <4B1D360B.4070203@ubicom.com> <7vy6le35zv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yakup Akbay <yakbay@ubicom.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:24:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHk7b-0006sh-EP
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934907AbZLGUXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934620AbZLGUXe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:23:34 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:45069 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934440AbZLGUXe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:23:34 -0500
Received: by vws35 with SMTP id 35so2174476vws.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Ht21T8eZBIB5BJFEx8OA8xeL1k5wm3Fm2FZazb7z72M=;
        b=NBX0hlSTj+15p3qOiWqkigRGR8YYDHTM4VxurUvnBM4+b25b2Zd56xZc63R+8PtDeW
         H2Dk5a9quYMxgGSGMD+1gOtY07glwoI+j+3Wu7m3we6v22VlqQUY1wXg2YmWZ86D18qj
         8RuSslRj5vHYLa1Bi7yuDRmMrlmUNNle+x2k8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ezixzBs5bf7a3x8QWkjvjSrVJyhHWs5qTn54Ow1s1YD5QDmaZ1z4QYE4Vb4fhbIRg9
         rgphbECOtLqQ190sO/nruBAPojZuaDVzenzB6hyvuE4HaLDY+zYJdXztMWdL8ZM4cXSj
         n4BN6R4l6zAYRqVtVGINQnIZYo2glzfqQU3lY=
Received: by 10.220.122.144 with SMTP id l16mr821vcr.78.1260217420108; Mon, 07 
	Dec 2009 12:23:40 -0800 (PST)
In-Reply-To: <7vy6le35zv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134778>

Heya,

On Mon, Dec 7, 2009 at 21:04, Junio C Hamano <gitster@pobox.com> wrote:
> If I recall correctly, this hasn't been even noticed/reported/recognized
> as an issue, ever since the "git repo-config" was introduced (which later
> was renamed to "git config").

I poked Dscho about it at some point.

> Dscho, do you remember details?

He told me that the 'git config' code is so horrible that it's
nigh-impossible to change the behavior, hence why he didn't do it :P.

-- 
Cheers,

Sverre Rabbelier
