From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Thu, 1 Nov 2007 08:25:25 +0700
Message-ID: <fcaeb9bf0710311825k715900a0sa32a95b87cb146c7@mail.gmail.com>
References: <1193861145-20357-1-git-send-email-mh@glandium.org>
	 <fcaeb9bf0710311809o41703bc5hda36a9d44a538eeb@mail.gmail.com>
	 <7vejfag40g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 02:25:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InOoX-00063a-9N
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 02:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbXKABZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 21:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbXKABZ1
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 21:25:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:52952 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbXKABZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 21:25:27 -0400
Received: by nf-out-0910.google.com with SMTP id g13so339275nfb
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ClTAE8NajR0iZ6MqdBQKW9v00ex+t40c9snBcL0RtFc=;
        b=l0DFqOUz0R66NNLdJU//a+UGEFMIxVKmakKyGoxvYKyP7xaVFBMSimfT9mHSWgxTtLK6V+5YfIvHamJ5laZCkDquGS+YZ3gXdcOoKU/ObH+uK27+OIIvPESIQiG1epTsMi3WUyDiNgXM4WM+sedcz1gvRGKx9v9f1JehUbl5iGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mmpqnnRPgMnkqYU52GbLbqpl0dYT1V5haPMCZ+TRbl9GQXZmvWVs+sr91n7BeR5MT+dPOCKqAjSv0FOSlkNh2MrggVM6FlwbuXZG5nMVI3z2YXgYMQpXDCd2T2SmfiqzJzzMbiCNTpLiGAbp3quIWMGY0+2yCNnZz5BSM6WLv/M=
Received: by 10.86.79.19 with SMTP id c19mr11266fgb.1193880325809;
        Wed, 31 Oct 2007 18:25:25 -0700 (PDT)
Received: by 10.86.73.5 with HTTP; Wed, 31 Oct 2007 18:25:25 -0700 (PDT)
In-Reply-To: <7vejfag40g.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62906>

On 11/1/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > BTW, you have workaround for git-merge also? It uses cpio to save/restore state.
>
> Why do people want "workaround"?  Is installing cpio such a
> hassle?

It is on Windows because busybox cpio is not really good and busybox
tar is even worse (for cpio emulation). Maybe I should just improve
busybox cpio :-)
-- 
Duy
