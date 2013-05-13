From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Mon, 13 May 2013 19:22:45 +0530
Message-ID: <CALkWK0nKZNdzT=42Kdq7T0epM=0=5xQGm2ivhAxDXLSbZSC3Rw@mail.gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
 <1368359801-28121-8-git-send-email-artagnon@gmail.com> <7vd2svqtqd.fsf@alter.siamese.dyndns.org>
 <CALkWK0nP=RmJHjcFUG2u4pz1ORtPhR7bzi3VvTE=7ggnKbjaQA@mail.gmail.com> <7v4ne7q9b0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 15:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtC3-0004mt-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674Ab3EMNx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:53:28 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:39902 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab3EMNx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:53:26 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so11668619iec.8
        for <git@vger.kernel.org>; Mon, 13 May 2013 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HMNJnk5e4oA72/PlBL11ODzYGKN+DUEG2PBKA+tOvNU=;
        b=YkyOTe8UZSlMae9K2xj8O03u728rkjknPTy6cgR8H5lw9TukK863YCAQjPONDNbzPL
         8QMQlOnyFYwlQvBmt+K1BzTfnXplLhiG6WH54pYqNoRFp5OIvlwpF2heXTLNmIYTW8si
         QBKiYYKLfpB+IKXPw0aPBxF+t9dOLVeXjRrWgKQw+vcX5j360rpNd2Bf13bleFeN/Yd2
         4Q/29a6g5jwxyipkMsfyF+DQDtcQ5T1bYQNeOvnhcPKfiirt5Zr63cExFDv6cXWV5Vch
         X16Uf9sm+hhPXqPDERyJoJnXw01zlOkPJWXHZ8nZgL9U6n60aX0SNYPmTTUV2rbg/uGK
         cRkg==
X-Received: by 10.50.66.197 with SMTP id h5mr9815451igt.63.1368453205674; Mon,
 13 May 2013 06:53:25 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 06:52:45 -0700 (PDT)
In-Reply-To: <7v4ne7q9b0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224141>

Junio C Hamano wrote:
> No, thanks.  I won't be even taking the patch right now, so you have
> plenty of time ;-).

There were some additional comments from Matthieu, so I will re-roll
(just this part).  I've even posted a stash series based on this one.
Do you have any additional comments?
