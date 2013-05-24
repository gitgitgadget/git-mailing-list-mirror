From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Fri, 24 May 2013 23:20:50 +0530
Message-ID: <CALkWK0=YiOoZPBYY4M5PwHGD2r-cTHZi4BLQwbizXkHtpG80ww@mail.gmail.com>
References: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
 <1369381324-10206-3-git-send-email-artagnon@gmail.com> <7vd2sgb9r8.fsf@alter.siamese.dyndns.org>
 <CALkWK0moMOBUZqqSe521qfa7q8xe0Z5sN10ZRQpPaTu8EuxuDw@mail.gmail.com> <7vsj1c9spm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 19:51:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufw9T-0002Ab-V1
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 19:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393Ab3EXRvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 13:51:32 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52402 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3EXRvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 13:51:31 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so13371297iec.29
        for <git@vger.kernel.org>; Fri, 24 May 2013 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iid6iUWMfh5EKqZm6yt6D3f0WhGcWscWusN7Azizq4o=;
        b=eSxpKKFRL7HFvByHUaoMX/z5V7GyNFpOmxGP42d/A385vy+RQK51FEy5Ts1/AavRc0
         /+OmhlK7XgHChvadXdC6zvxQ+1+uf3OLEEvYf32pN5ZT4jXov6HS6IDFb+EyNQxLRQCk
         9psRstAdq2DZxNRGUkmc+JQuNHZAkXYPVcoy3Af4FvFubYLhO/23qx6l0C7Nw2fmlxlK
         hwx364xgJpehqM84GwdXxMyRWDpVsatddvVtry8sh2uh/sNtWdR3wmqMTnrOjbIirJLR
         cCMBA18Arp2BUb6TnMWHwV7yViA33ZrbLakb8EW4kOcSWk3ov7rKG3HUqg60MSXrJErx
         I5dA==
X-Received: by 10.42.47.77 with SMTP id n13mr13119369icf.12.1369417891226;
 Fri, 24 May 2013 10:51:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 10:50:50 -0700 (PDT)
In-Reply-To: <7vsj1c9spm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225387>

Junio C Hamano wrote:
> That is why I rewrote it like so:
>
>     The empty string '' is confusing and does not convey information
>     about whose logs we are inspecting.  Change this so that...

Ah, I didn't notice the rewrite in pu.  Thanks.
