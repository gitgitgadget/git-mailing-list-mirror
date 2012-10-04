From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Thu, 4 Oct 2012 09:01:18 +0700
Message-ID: <CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com> <7vvcer4chm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:05:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtNN-0001DP-CG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661Ab2JDCBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 22:01:50 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55625 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab2JDCBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 22:01:49 -0400
Received: by ieak13 with SMTP id k13so18782776iea.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 19:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=T4qf+TFjBpGIa8VcdvvSaBhcEGkh5/cugXemSzzf4hA=;
        b=E2UmEHx33/ruVuSHFgC/XL1uMBk9E1Wf/btsjwH/xGpZ2n622Hfy6biZO/xNalUMgg
         zovz6zJAEerEj/1kjRROx6abo0XAca8Y3+RJ89yRe7kjOmcFN//+UNz7AyLktQrpBmkF
         jfmNm2u8IPbd7qzUUyOpM6Tiv8zugF650TuU+nImfazTbrfoTz6mpopESzkRRh18xDrX
         6bdZ+Ytw/v7JvFaUKM2HTqTn+8TOG6CEOlnLpCPYWMVMoUOMO8uMnO6VfMMkONggxrze
         Mb/ZGeGezoMKX+/SuQg+6Apnvni26epv6p7BeGD0pyWDLXPZ81a6njAvl8O+WoNwostX
         twOA==
Received: by 10.42.109.194 with SMTP id m2mr3047650icp.48.1349316109106; Wed,
 03 Oct 2012 19:01:49 -0700 (PDT)
Received: by 10.64.23.197 with HTTP; Wed, 3 Oct 2012 19:01:18 -0700 (PDT)
In-Reply-To: <7vvcer4chm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206960>

On Thu, Oct 4, 2012 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I would recommend against listing any advice.* in the command manual
> pages.  They are meant to give an advice in cases that are often
> confusing to new people and are supposed to advise how to turn it
> off in the message.

OK. I think I was surprised that some messages were controlled by
advice.* but gave no hints about that and I found that out by other
means. I'll check all the advice messages.
-- 
Duy
