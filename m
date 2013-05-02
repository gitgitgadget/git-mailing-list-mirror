From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/9] A natural solution to the @ -> HEAD problem
Date: Thu, 2 May 2013 23:04:51 +0530
Message-ID: <CALkWK0=Ok7=Ef0tPTWJi1uMPGqJS1ao44w6ArxE5d3sVOP_PXw@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=osd8jQYfHcwO8=C_sMNgPj59Th=+tpfZfp7FeopMDyg@mail.gmail.com> <CAMP44s2M0A_ecfFfD_9hYQUvHSXMup6Whpn80rs741Lu1-ytcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:35:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxPz-0005j3-5d
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084Ab3EBRff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:35:35 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56735 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049Ab3EBRfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:35:34 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so962364iee.27
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uy7OwP40foKikUwz5WZlJesHe36bk2XOen0pGMoUaxM=;
        b=UngmvIOPtEyyb0rdLJXZKsXjYGch+aG4zmr78W/mr1XBiessVqVtjLLKdTp9/mRx8P
         f51BQkJPEGzkPpDZ15lF/ucWO23xbBfUpvpxI8txlPE14q/kMe9643nIaLVLU/vo3wdZ
         /eAYbdTNqd/czJFwX3baSCShDTE4SsrDo7aUhVZAGWz21gnliaInD5O+DcyVVTAkD8Vb
         NfYGsuednjJKFOjWONZVJW6VDS9H8EGsALDxnFXUz+GJQ7c2b5Pw+Sdzwls+1Fg60zHq
         wVDYV2Biqpnl73GyduJGOoz8kdw6cUO1SeOvGzEtKjyQEAmusEev+4zC2xIOlZ1Kyb2l
         70XQ==
X-Received: by 10.50.73.65 with SMTP id j1mr4304396igv.49.1367516133202; Thu,
 02 May 2013 10:35:33 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 10:34:51 -0700 (PDT)
In-Reply-To: <CAMP44s2M0A_ecfFfD_9hYQUvHSXMup6Whpn80rs741Lu1-ytcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223238>

Felipe Contreras wrote:
> I'm generally OK with them, but the one for 'symbolic refs' is relying
> on a symbolic ref named '@', so it would immediately conflict with my
> patch series.

Right.  I'll re-roll when we've finished with the rest.
