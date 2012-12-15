From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: FW: Git log --graph doesn't output color when redirected
Date: Sat, 15 Dec 2012 10:23:10 +0700
Message-ID: <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk> <20121213131329.GA5042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Srb, Michal" <michal.srb11@imperial.ac.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 04:24:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjiM6-0007dD-K0
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 04:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab2LODXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 22:23:42 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60743 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab2LODXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 22:23:41 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4254193oag.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 19:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KYZoafkzC83XGXpWw8NsAZU1peBxLvcP6G6kILtg5Uk=;
        b=YcU0qjcZgsCmEIwkamB1ABoDmm4BkoRrcR085Hk/ZHIjvmjys6jG8+Cay7twI6Lcxe
         BQnJ2Wtilmq+GFuvQ5YYndk8j1ZOpA3k32c8J+O+5dojDukn328LAKhyi+lH6xOVQ0zK
         lKYjy1Li9Zd2qqqqX2M/KZW1CWDdDkiwpO9C6lh96EnVi5/XyTf9GbJEmh/iKjASlQxN
         5irCmduFD/UAtXmOkdD+HukFyixCevcSCUl+an/8EITKtMJDpL0xpzbU7hmdp6lTfOn4
         XiDEKtt+h+tlWnz2Y86gDsoI3queIZBKCkTmg5YmtzpLNYf3W/9FsUuwwBN0/BFuH96k
         fA7A==
Received: by 10.60.32.234 with SMTP id m10mr5657738oei.7.1355541820866; Fri,
 14 Dec 2012 19:23:40 -0800 (PST)
Received: by 10.182.41.229 with HTTP; Fri, 14 Dec 2012 19:23:10 -0800 (PST)
In-Reply-To: <20121213131329.GA5042@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211518>

On Thu, Dec 13, 2012 at 8:13 PM, Jeff King <peff@peff.net> wrote:
> If you are using --format="%C(red)" or similar placeholders,
> they are the odd duck by not respecting the auto-color mode.

But they should, shouldn't they? Just asking. I may do it to when I
revive nd/pretty-placeholder-with-color-option.
-- 
Duy
