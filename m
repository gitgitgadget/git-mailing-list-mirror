From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Use Python's "print" as a function, not as a keyword
Date: Wed, 21 Dec 2011 03:48:05 +0100
Message-ID: <CACBZZX7PVyCFfHTJN_QZfyt5wAcr4UAiJSmo54PSi=8pgv3sYA@mail.gmail.com>
References: <20111221021930.GA31364@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Sebastian Morr <sebastian@morr.cc>
X-From: git-owner@vger.kernel.org Wed Dec 21 03:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdCEK-0001EW-OZ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 03:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab1LUCs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 21:48:28 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36381 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1LUCs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 21:48:27 -0500
Received: by wgbdr13 with SMTP id dr13so13491047wgb.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 18:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VoFKa1lA50tAqm5KG0278cKj8Bl1XR4Mgzblqo7GLX4=;
        b=H63Yz/dNADf1P1TyaHLyeAxGQNC4KQaiF9wN/q/iKbf6q7ghKTcKL+8ZlC1ZwM4NpF
         LKuqMkyeATbsedyCfwYNR3T4enMukzdUCGrqWoU/s1V7FPISioWPPxZxL7U3nzWhMbMi
         k61O4GZGx/d9uBnvfSEsovNH+4jJ6WwCYLK/I=
Received: by 10.216.132.141 with SMTP id o13mr2412338wei.58.1324435706199;
 Tue, 20 Dec 2011 18:48:26 -0800 (PST)
Received: by 10.223.77.91 with HTTP; Tue, 20 Dec 2011 18:48:05 -0800 (PST)
In-Reply-To: <20111221021930.GA31364@thinkpad>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187547>

On Wed, Dec 21, 2011 at 03:19, Sebastian Morr <sebastian@morr.cc> wrote:

> But, as nobody seems to have cared before: Is Git designed to be
> compatible only with versions prior 3.0?

I'm running Debian unstable and it has Python 2.7. Most people are
still using Python 2.x as their default system Python since 3.x breaks
backwards compatibility for common constructs like print.

Does this only break Python 2.6, or all 2.x versions of Python?

What's our currently supported Python version for the Python code in
Git? It's 5.8.0 for Perl, do we have any particular aim for a
supported Python version?
