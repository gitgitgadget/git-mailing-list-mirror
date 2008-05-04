From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 3/4] Fix diff regression for submodules not checked out
Date: Sun, 4 May 2008 15:10:05 +0800
Message-ID: <46dff0320805040010s2dce0f7cr82548088e08ff54a@mail.gmail.com>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
	 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
	 <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
	 <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
	 <7vej8ir2ik.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 09:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsYO6-0005i9-J7
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 09:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbYEDHK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 03:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYEDHK2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 03:10:28 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:21355 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbYEDHKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 03:10:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so449148and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 00:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZIcn19mQ7pD7UaSGUfDfjxxCd5PojGfDc6bFn6nhjfU=;
        b=Pd90FUgAzhaF6+A/VCH3mZr7IyRaZ9nURbzsieP3qNRe1GtasGNvgQrqv0xsrvQQSbsNaYwmbDPa+1gM4HMU3PXYWJH+BVX1K0FzCljw4af28ZdW3Ko6cMToqz4Y/vfSIcomQ+kRZyrbf02je1J4yMHOrWukACT6iGfhhEC+4oE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iilTkOeokONKjW9qiH6RVh5N5iNP5C5teyiVfzH3nO16mlNKQKVOFhC3Zz9zzhigv3VsBx3Xg27aAB1+9fKBzLODqX15tHEwrWgEOAL6Z+uhEMa06i7agA0gPPJRi1D2/NGNDw+RyD5zKQRJkUdGY2NIFKV0UjptqO59fNGe+uE=
Received: by 10.100.194.5 with SMTP id r5mr6444271anf.104.1209885005935;
        Sun, 04 May 2008 00:10:05 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 4 May 2008 00:10:05 -0700 (PDT)
In-Reply-To: <7vej8ir2ik.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81151>

On Sun, May 4, 2008 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>  > The second case is "not checked out -- treat me as unmodified", and the
>  > third case is "the user does not want the submodule there", and the latter
>  > is still reported as "removed".  That is exactly what your patch does.
>
>  Having looked at the code a bit more, I do not think we need the
>  three-kind distinction for this part.
>
>  The attached patch would be both sufficient and cleaner.  The real change
>  is a single-liner, and everything else is additional comment ;-)  I'd
>  follow it up with s/check_work_tree_entity/check_removed/ for
>  clarification.
>

Fine, it's cleaner.

-- 
Ping Yin
