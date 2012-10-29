From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 29 Oct 2012 15:56:39 +0100
Message-ID: <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 15:56:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSqlq-00054a-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 15:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab2J2O4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 10:56:41 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53510 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab2J2O4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 10:56:40 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so4732012oag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Pna1RPvhDWkcgrefpBougKaLbx31MEOqDn+b7kZYE/0=;
        b=VUDLshiC8RuhNWHrwaS9j6KhUNguR8Od78SmFdbWimFdOROCe6sEQIfgUUviYrAUF4
         B/Pj9kddYIaHQ8ZdNXWn04TcNqbTRvQWtr1gqVCspNPUKsCZoNP/Ho9WjqVqXynBPEVv
         uNU79uZXknmuMkEyboLEJpVy7oeS0pRtILKvsc8X6m7sI/ljJVi6Ho26m6nf3q/YL430
         nA59sJAZDHWIxaE0H/+UnbrRgwW/S/Wc7uyCL6Af/XVBlVTyBaq4e8W1Rwo5eR/by+78
         9asz/agZKu6VeB1i+1GVkcE4VembN+kbrm9E/9tibBtsrfT6iQ3Y/+ilUqX7IDLyCPZX
         Ed8Q==
Received: by 10.182.235.46 with SMTP id uj14mr19336753obc.40.1351522599942;
 Mon, 29 Oct 2012 07:56:39 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 29 Oct 2012 07:56:39 -0700 (PDT)
In-Reply-To: <20121029085045.GA5023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208625>

On Mon, Oct 29, 2012 at 9:50 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 28, 2012 at 04:54:00AM +0100, Felipe Contreras wrote:
>
>> I've ported the tests from hg-git and made sure that the output from remote-hg
>> matches the output of hg-git. With these extensive tests I would consider this
>> one ready for wide use. Not only do the tests pass, I've compared the generated
>> repos of a few projects, and the SHA-1's are exactly the same :)
>
> Sounds cool. Unfortunately, the test script hangs for me, after starting
> up xxdiff (!).
>
> pstree reveals that it is "hg" that starts it, but I didn't investigate
> beyond that.

Yeah, the test script is not ready for merging, it needs to check for
python, hg, and hg-git.

Do you have hg-git installed?

These tests compare the output of hg-git with remote-hg. It would be
nice to have tests that don't require hg-git, but I think what is
there is more than worthy of getting merged to contrib. In fact, I'm
thinking it's ready to be out of contrib and installed by default
(once the hg-git tests have proper checks), but I haven't heard much
feedback.

Cheers.

-- 
Felipe Contreras
