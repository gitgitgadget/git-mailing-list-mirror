From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Wed, 24 Apr 2013 12:25:49 -0700
Message-ID: <20130424192549.GI29963@google.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com>
 <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
 <20130424190638.GE29963@google.com>
 <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
 <20130424191453.GG29963@google.com>
 <CALkWK0mK=myPEsFrhVd2Xi3U10L+jZ+_WV=1JvxyvpnO3yUJGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:26:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5KP-0003ci-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425Ab3DXTZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:25:55 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:41669 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092Ab3DXTZy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:25:54 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so1320573pdj.24
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vMfTci/Wg8TRN80LnLFPCyTxQbZ4Q51/rW8w4FnnfKo=;
        b=tStV5u8F0fqcvN4xysqgRbRxy1UC5Fcl1QcFmnrpQTbZPc7M5uyaRseBRVcYLq0JkC
         T/FlyXdcn95vf/gSS1iH0Z7FzxQUkAILicLnZS6RgEnK1yrpeo4Ov79c3gm6cmV11xCF
         /adcoTVGhL5QTwdMFnK0w7Lq64SJ9D3b9+0w7Cnu1B8e2bCX1bYU+Hrj+Fgt7sZ0hqIK
         PgaoPapPgdpWKo8O9nVx3IdXPlypGjeVvxmtBGzIXcNMZUIcZKHYsQAmMApWtoaHY8+L
         ktHGH+c5djW+ZHS2DZwxv1Cm00muFjXvR6DASE4S+TtFEYeiHeswRssa4K0JhGUrKg1J
         pMRw==
X-Received: by 10.69.3.65 with SMTP id bu1mr48974984pbd.107.1366831553791;
        Wed, 24 Apr 2013 12:25:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vv6sm4787174pab.6.2013.04.24.12.25.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 12:25:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mK=myPEsFrhVd2Xi3U10L+jZ+_WV=1JvxyvpnO3yUJGg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222307>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> Oh please no.
>
> If I understand this correctly, you are horrified by this?
> https://github.com/artagnon/dotfiles/blob/master/.gitconfig#L30

Nope, that looks like a useful way to save typing, and "git help"
helpfully expands any of your custom commands when you want to
translate in order to help other people.
