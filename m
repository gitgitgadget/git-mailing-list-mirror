From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add list-all-objects command
Date: Mon, 22 Jun 2015 16:57:28 +0700
Message-ID: <CACsJy8DGD6PLVJMFQGKyk9YGUn16G8+dLx2bMBn8fyjuXvfbBw@mail.gmail.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org> <1434914431-7745-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 11:58:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6yUN-0002L3-F4
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 11:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbbFVJ6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 05:58:00 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33004 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbbFVJ56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 05:57:58 -0400
Received: by ieqy10 with SMTP id y10so22845334ieq.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a1iCiN0D/KmJZx5jkIKKUfSFheKJBbl6wGiK3sKn9Jo=;
        b=I7m6miURS/jhb/Gw/gk4yqBvqGFG44CwMBoEn4rfE3ViW5i7SDtyqiAx4+vJTQPsvS
         bhGgU4+kS9Ont9+PRtMxJ/wSMr6zB83lPesbWvNnRdbCZLgnxIfokD8mk2unZbAiFubU
         ZaRGCCEtkpHKY0ysM5RxOwyzYxulPKoHu9XszqL4U6mMicShYHQ8HWJYG2lD/IFZo+cm
         pm+tcLmZy06rxU5Lejyf528UOmozrTwa+YDP4ZO/P2H3vmDDPVj6LplRESce1jl9scKx
         xpbv38gbU6hrPOaQ+jAapYC8TfkGws80Q54kyNiV1fpZT9+u6dyu5Pn8KQPTu4bZSN/l
         NrMQ==
X-Received: by 10.43.172.68 with SMTP id nx4mr24525299icc.48.1434967077973;
 Mon, 22 Jun 2015 02:57:57 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Mon, 22 Jun 2015 02:57:28 -0700 (PDT)
In-Reply-To: <1434914431-7745-2-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272321>

On Mon, Jun 22, 2015 at 2:20 AM, Charles Bailey <charles@hashpling.org> wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
>
> list-all-objects is a command to print the ids of all objects in the
> object database of a repository. It is designed as a low overhead
> interface for scripts that want to analyse all objects but don't require
> the ordering implied by a revision walk.
>
> It will list all objects, loose and packed, and will include unreachable
> objects.

Nit picking, but perhaps we should allow to select object source:
loose, packed, alternates.. These info are available now and cheap to
get. It's ok not to do it now though.

Personally I would name this command "find-objects" (after unix
command "find") where we could still filter objects _not_ based on
object content.
-- 
Duy
