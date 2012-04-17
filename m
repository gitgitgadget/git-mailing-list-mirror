From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [RFC/PATCH 1/2] update-index: add --clear option
Date: Tue, 17 Apr 2012 14:36:49 -0400
Message-ID: <CAHiigudcsEqaZwv7MpRVEw-5V60VJ7zemuh4u902vvhrAsRJGQ@mail.gmail.com>
References: <20120416152737.GB14724@sigill.intra.peff.net>
	<20120416160232.GA1350@sigill.intra.peff.net>
	<20120416214855.GM12860@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:37:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKDGp-0001wg-UF
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab2DQSgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:36:51 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64475 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab2DQSgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 14:36:50 -0400
Received: by bkcik5 with SMTP id ik5so4832316bkc.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pSfQUjLxPmRW8oyEhnjFanzaa/iHozJK61yIi397MEY=;
        b=wMtLoGCFIZs4uOHGExEGkNGqHREOkwCnd1ALUSFA/8OJHhm5wL8ocCulaAaU1YH4uk
         GKI1BWIQ/PZ6E5ot1NctbBKWzuLNM7BRT6FtljacE1QXBHX96RgXgIxVCQLqL3A4OKq4
         YIZXyLsAfe3/r/mUJwGMuveUk/ZMVOHruk0LIrEERdjK4p4/ZDKNMPTjmP4GuIijSR7e
         1TTETa7ZrSp4OHiFwngRWRma7IE3gtt/kCESQ4kKtgkyLGGrV5Gk+xfqtKtKkfWw/95r
         XvbVozV6wxG+WCQAv9YPejGIq1ePYEt33ZhnMbwviMbfsF2rj2jP/oSROzl03nG4UZR4
         ueYg==
Received: by 10.205.135.132 with SMTP id ig4mr5207962bkc.20.1334687809490;
 Tue, 17 Apr 2012 11:36:49 -0700 (PDT)
Received: by 10.205.35.81 with HTTP; Tue, 17 Apr 2012 11:36:49 -0700 (PDT)
In-Reply-To: <20120416214855.GM12860@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195788>

On Mon, Apr 16, 2012 at 5:48 PM, Christopher Tiwald
<christiwald@gmail.com> wrote:
> At the very least I can give this patch series a go this evening. I'm in
> the process of combining 40 highly-intertwined, nested repositories into
> one, and should be able to test it under the conditions outlined in the
> updated example.

This worked great for me, at least in the case of adding trees to
subdirectories.
Fwiw, I found the newer, patched example a little easier to parse, but
I also had
spent a while figuring out what the original version did.

--
Christopher Tiwald
