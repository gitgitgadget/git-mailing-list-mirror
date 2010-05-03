From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/3] git over TLS (gits://) support
Date: Mon, 3 May 2010 20:57:03 +0800
Message-ID: <j2tbe6fef0d1005030557l1f746349zfce18213add19efe@mail.gmail.com>
References: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon May 03 14:57:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8vD0-0002JD-5k
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 14:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861Ab0ECM5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 08:57:08 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:61649 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758771Ab0ECM5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 08:57:05 -0400
Received: by iwn40 with SMTP id 40so3166429iwn.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=CPR4n0XWNGZUSgftM1AtG/E7+QuMt3Jeg3JaCffN7rM=;
        b=Ostc+adna9o5VY9qDdlBMCATLlWBD7Z/q6t3/iMYfOUo5mNVLJ7PniKa8K/V1Dmotr
         KmQALCVccQ01+9XUHpjtNkqsYOKQw3d4PxEXDlI/+Ra9UftsscE8OrF6G8nXE3JV2XHA
         taamyLugKJmvrturduYn7taQa+x04HOtKMcyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fqVAuRWn/7hugvs0v7+NlvcUkStiTqxazGr3QOI/NqOQfRZpCyG/KTzPKnw1xzUmS8
         W7f3Vuk+H1e7NSveLTWhfimdeSJ8+wOA+LDeuXTrE79mDj43SRKfMCKWLDW28lArioOS
         wA4dCxhfKK0VsEUtWzpwH7DB0Qwp/SBKlHA0I=
Received: by 10.231.147.199 with SMTP id m7mr5265194ibv.87.1272891423447; Mon, 
	03 May 2010 05:57:03 -0700 (PDT)
Received: by 10.231.36.201 with HTTP; Mon, 3 May 2010 05:57:03 -0700 (PDT)
In-Reply-To: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146234>

Hi,

On Sun, May 2, 2010 at 1:09 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> This is newer version of gits:// client side support.

in case anyone is wondering where the older version is, Ilari posted
it early this year:

  http://thread.gmane.org/gmane.comp.version-control.git/136816

>From the discussion, Avery (Cc'ed) had some strong objections; the
point that I remembered the most clearly was "why not just use SSH".
There didn't seem to be any headway.

I hope that we can continue where we left off and resolve the various
objections without too much duplication of shot-down arguments.

-- 
Cheers,
Ray Chuan
