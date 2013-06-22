From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/16] t/t5505-remote: remove dependency on $origin_url
Date: Sat, 22 Jun 2013 11:57:52 +0530
Message-ID: <CALkWK0mKQnyDXe6AfVzNbh7qOdYbyrVrgt9GMgT2c9u+1jykJg@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <1371813160-4200-5-git-send-email-artagnon@gmail.com> <7v61x7ktcw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 08:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqHJN-0006Wr-3L
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 08:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784Ab3FVG2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 02:28:33 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:58496 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab3FVG2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 02:28:33 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so20848949iea.39
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 23:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AAjLQMhHLAhSTkgVKalpiO+h+I+fqbOJxYSn7qQ0/aw=;
        b=sqJXzlBYygkrcmkarbBwtfOBr0LVqywqhdtJHcjI30icGcF9tir+HHpUTHvyFY3FWv
         c7UMdsMDFLYtboMsgjfVKWd0YsDCehm946OlS0JAduZwExMdm8d9HX7vrGMNQ+6QfEam
         m88zLi6j6bO8Ot+sujFwYMQcmw38NKKgwrlO4lv2m1JmVbqRjGFQeFRX6Zi06LeTssol
         4HTvG+O2fWGqQwMotFgFPxcaiVNOqecct9wIo8KhZK6wZEZ8FEkaTmk5+1wq3M1WONgy
         5O4JSKOOQV3TxJ7OtXmOF7Bq2SRPMOc4PrkXJOOgW+EwABs6G/JEQHX1MTQZ/GtO3dDW
         kzNw==
X-Received: by 10.43.88.3 with SMTP id ay3mr4050242icc.61.1371882512654; Fri,
 21 Jun 2013 23:28:32 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 23:27:52 -0700 (PDT)
In-Reply-To: <7v61x7ktcw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228672>

Junio C Hamano wrote:
> Is there a reason why "quux" is better than another randomly chosen
> string "$(pwd)/one"?

"$(pwd)/one" is not randomly chosen: that configuration will work with
push/pull, and is therefore misleading.  I put in a deliberately bogus
value because I wanted to make it clear that we're only testing
anything config-parsing.
