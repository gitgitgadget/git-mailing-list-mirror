From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 23/45] check-ignore: convert to use parse_pathspec
Date: Mon, 15 Apr 2013 09:48:22 +1000
Message-ID: <CACsJy8CTZPZV6BKhLey-EZgu2gFhpNdkNVVoRALT0PyO0RS+_Q@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-24-git-send-email-pclouds@gmail.com> <20130412150304.GH26949@pacific.linksys.moosehall>
 <CACsJy8Au4KL7msPr62bvSgGdseWFF=cUJSuB2JzGUXehDD6hng@mail.gmail.com> <20130414232542.GB21564@indian.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Apr 15 01:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URWfJ-0003VM-QX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 01:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab3DNXsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 19:48:53 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:41260 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab3DNXsx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 19:48:53 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so3853507oag.7
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WR6Q5gweynPXFpLzQvR2DwHw3OXJud3BBJ8y7+cLAyw=;
        b=cgFqSnyQAP1hMtMmaw4TiTlztsb12XqGJWELrkjxQNxl5Aad0lirVHNS4Lj/PZmqns
         Cr22veLzj+NrwAylssTsKyAZGP4xUR+/Pw7/ve2wX+lXYMVAJRF0p+xKCsH9E2N/Cwlc
         dzl2tix9poHE4f1Yl8Bydh/xav1ckmu3UhiwKanwS0yPong4kqm4RgdAKNlJOrMZFHU+
         MIFWX6HVu+X9ubbIM6GVabNhYfBaO3CoCXOgH6YV76aAd7NenXZ26uyPcKyr8UbTnPWA
         xUXbwaiBnFzARcEegIIcOipiJsYMkmlq6N648blieb5HYsJALBs3lOzP9CJjzc4PGEkb
         6o/g==
X-Received: by 10.60.117.35 with SMTP id kb3mr6992066oeb.16.1365983332702;
 Sun, 14 Apr 2013 16:48:52 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Sun, 14 Apr 2013 16:48:22 -0700 (PDT)
In-Reply-To: <20130414232542.GB21564@indian.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221168>

On Mon, Apr 15, 2013 at 9:25 AM, Adam Spiers <git@adamspiers.org> wrote:
>> > The introduction of argc also makes it possible to invoke
>> > check_ignore() with arguments which are not self-consistent.
>>
>> This is the same problem with main()
>
> How could main() be invoked with argc inconsistent with argv?

The point is main's caller has to maintain the consistency. So do
check_ignore's callers.
-- 
Duy
