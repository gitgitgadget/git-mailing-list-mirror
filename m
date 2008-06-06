From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: How to compare different files in different branches
Date: Fri, 6 Jun 2008 13:30:44 +0100
Message-ID: <57518fd10806060530k7a15f79fh1823afef2a747233@mail.gmail.com>
References: <20080606122421.GA1521@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nico -telmich- Schottelius" <nico-git-20080606@schottelius.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4b6Z-0002A8-R0
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYFFMar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYFFMar
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:30:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:40213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYFFMaq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:30:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so664486fgg.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=75b5BPpXlddowX5cTG2OybfYdPZ2yyE0QS2LlcWk8YM=;
        b=geqsWD1lGGcr3mMSH+IMJZM/xc+aaSUUxqBAC4p8JkrgEltmYZfILI6EtxbmYZNiCR
         /b3a6zhVx/ukhUk5iRT3yayd3X0G/cBEFJMJmQFrW0oPgfSnwduBxITmp4CfpuV4RQiF
         pvGIwMuBhKz/ElLEpyBie+EFU0w54iVwqtmtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=aCjswO19CnyBshdslTipdkdZQkcMC86cWektKnUV6kiDhsbCML4i+jm1ap3Fo7dUV9
         /zjCo/d8pjJyuT8JubWQXYWfMmUIslLfpTvZrcit3L0tLgiHnJrhyrODUCcJSUzfxESY
         lzYO9azilKcKcyo1uC1EBm2+1hmh7Bm5QRp30=
Received: by 10.86.68.20 with SMTP id q20mr224341fga.2.1212755444998;
        Fri, 06 Jun 2008 05:30:44 -0700 (PDT)
Received: by 10.86.76.17 with HTTP; Fri, 6 Jun 2008 05:30:44 -0700 (PDT)
In-Reply-To: <20080606122421.GA1521@denkbrett.schottelius.org>
Content-Disposition: inline
X-Google-Sender-Auth: 025970b1f84486b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84056>

On Fri, Jun 6, 2008 at 1:24 PM, Nico -telmich- Schottelius
<nico-git-20080606@schottelius.org> wrote:
> Hello!
>
> I want to compare 'configure.in' from the master branch with
> 'configure.ac' from the gpm-2-dev branch.
>
> What I tried:
>
> % git-diff master..gpm-2-dev configure.ac
> fatal: ambiguous argument 'configure.ac': unknown revision or path not
> in the working tree.
> Use '--' to separate paths from revisions
>
> # ok, correct, there is no configure.ac in master
> # But not what I want.
>
> % git-diff master..gpm-2-dev configure.in
>
> # shows that the file does not exist in gpm-2-dev. Correct.
> # But not what I want.
>



How about git diff master:configure.in gm-2-dev:configure.ac ?
