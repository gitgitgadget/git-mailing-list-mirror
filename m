From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: OSLC connectivity to GIT in Java
Date: Mon, 13 Aug 2012 15:44:41 -0400
Message-ID: <CACPiFCK_diX36uS6SCigO4VQZ4ghBVd2Dk3a_FWajBgoqQR8rg@mail.gmail.com>
References: <1344859929250-7564860.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "rahul.chandrashekar" <rahul.chandrashekar@in.bosch.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 21:45:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T10Zb-00065m-MG
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 21:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab2HMTpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 15:45:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60832 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab2HMTpC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 15:45:02 -0400
Received: by yhmm54 with SMTP id m54so3626545yhm.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LT2hRwALMdYbMEghgM1kCT3+uC3udcUOYRyTklYgl88=;
        b=O0ozjm4VQwK86JA7ELlW5bGNPxAE+DsyVDNKZFpsNMxpPcqsrxXlBaDKj1am/u2ZjK
         CyU0Kl/hZNt1GzIg38F0KGF+7dO5d+JTn32p9pcRH69lDP373uY0q/Us+S+YARcu6mEA
         0NiTKaUMs+eWUrALNbX9ZaQSSNjcIOqky+rtlC76h9I+ziNJYjariA7PFu5C6/3efP0A
         ZF62PT/Q4ZpbZpEwVFN6OHtGzhAzCtppJZPr+LGkDTZJy3wP3fafiPibcZrLBon8C1Tu
         Eo0B1vftd8nhP0xTyoVyz7xoYfxEGnIzdY8GnyYLp2uMFSfn5nIR2h0PL+XpoXK3H49h
         ZhGQ==
Received: by 10.68.212.98 with SMTP id nj2mr34290626pbc.138.1344887101614;
 Mon, 13 Aug 2012 12:45:01 -0700 (PDT)
Received: by 10.66.253.2 with HTTP; Mon, 13 Aug 2012 12:44:41 -0700 (PDT)
In-Reply-To: <1344859929250-7564860.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203356>

On Mon, Aug 13, 2012 at 8:12 AM, rahul.chandrashekar
<rahul.chandrashekar@in.bosch.com> wrote:
> I am interested to connect to a GIT SCM through OSLC.

It seems to me a very strange request. There is a very well
implemented, fit-for-purpose "git protocol". OSLC, after some
googling, is a REST-style definition over HTTP.

We already have a git-over-http protocol, not very efficient but opens
a window of opportunity to those behind unreasonable firewalls.
Perhaps it is a starting point for you.

hth,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
