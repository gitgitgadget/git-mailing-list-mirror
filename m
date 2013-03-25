From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 23:32:25 +0530
Message-ID: <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <7v38vjz7sx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:03:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKBjn-0004Du-2y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396Ab3CYSCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:02:47 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61192 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab3CYSCq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:02:46 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so7659461ieb.20
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/fxioZ+qNyUatdRKLjNviCtadc9LBysBfpeM/vuPVfA=;
        b=0umgRJfgwgzGdRIshxcVSVw5iRV1UxIxqZ9GtNv0y0rH+lM5K2dHd5JY0k7meAA+3P
         Obiv5ZU96qlDj3gmyWfvGgrbg7+5Kn2a03OidK0SISNhRy3s7VeQFbzmwqlIp70DFDsk
         vvqIIbkw2YYQ2R550Tjp8+ViRjBzsqiiKkb0Qgi+CniGAMYiGhjQRXubJi1WXvuGiXL8
         E9Unw+CfZoOOvZQtI6hJWThaAM0aksfQbStGm1bWgc5gp1SI9ZH/UrjLgLdqQRbcP+Ur
         IJjmIbCgs8ZYOmaSPuMWcuFZlRVYf2IMLyYt2ImRLuixaHVOchMs6eB2K12UOHG0bbA/
         PmzQ==
X-Received: by 10.50.108.235 with SMTP id hn11mr8245302igb.107.1364234565947;
 Mon, 25 Mar 2013 11:02:45 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 11:02:25 -0700 (PDT)
In-Reply-To: <7v38vjz7sx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219053>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Git 2.0 is coming soon, so I'm excited about breaking a lot of
>> backward compatibility ;)
>
> Don't.

push.default is the necessary exception?
