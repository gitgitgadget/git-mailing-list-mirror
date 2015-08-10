From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Error pushing new branch: value too great for base (error token is...
Date: Mon, 10 Aug 2015 15:29:02 -0700
Message-ID: <CA+P7+xpKHw8xkpMSjCftmAnMh=J_R9HxhYD48O2-P2WKUH1diw@mail.gmail.com>
References: <CAGDgvc3Gxn=pKBfYC+yrUhCmL9X6bqjPVwVokF0qPsXmhx_EaQ@mail.gmail.com>
 <CAPig+cTXO3699MdqSFVDBcnKcHAT=Mkp=c=r3C8F5nT8tfr6gw@mail.gmail.com>
 <CAGDgvc2hc+f5CuPXc2pr5uYd9kniVpuffrb6z416CicxBgVxJQ@mail.gmail.com> <CAGDgvc1FJ0K+OLQBj8iXPCnqMFyBD3mp32k0aTztQkKKuxNxtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gaurav Chhabra <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOvZP-0001mS-8I
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389AbbHJW3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:29:23 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37083 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbbHJW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:29:22 -0400
Received: by igbpg9 with SMTP id pg9so79498576igb.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cdBRPqdIA4RQW613cLYDYki58ly6r5qjlfklxfuKG3M=;
        b=kZUL2A4uqEPq/DyFw+kpVF2qPvpjmohX3ARabAF/E17Ti1WuUYI680DW5thW63dfN1
         HR2swfY386y3IhOzn9l53iWMr6sWj0WZ/yRvSBclrD0ve2bo+49Xg2tSltoBl0HhCSQd
         pB2UBsgUTadwy5eKdpHAFsAPPLsH27JsYBOY5m11RAp2Q2fL//AQ/hGQGv+50fe2A0XM
         LBv13BPDSgCMZs61NPhPEKIqGt02u/W+fzkiZEA+YUWab3JBdYblonMf+FVJqPjrsS0s
         swFn8nFm9oSt5w0sKL+fwORQP94BvBt/KF5KnJZgtxBJr+0AHwcr7I28qpAB+AbkvBUT
         5VAg==
X-Received: by 10.50.78.161 with SMTP id c1mr14725625igx.35.1439245761959;
 Mon, 10 Aug 2015 15:29:21 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Mon, 10 Aug 2015 15:29:02 -0700 (PDT)
In-Reply-To: <CAGDgvc1FJ0K+OLQBj8iXPCnqMFyBD3mp32k0aTztQkKKuxNxtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275656>

On Mon, Aug 10, 2015 at 2:54 AM, Gaurav Chhabra
<varuag.chhabra@gmail.com> wrote:
> Apologies for the delay in reply! I tried your suggestion and it
> works. Thanks! :)
>
> I'm curious why integer comparison is throwing error. Shouldn't i be
> comparing numbers with numeric operator?
>

Yes, but shell doesn't treat hex numbers as numbers. So it will work
only if the string is a decimal number.

Regards,
Jake
