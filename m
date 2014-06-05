From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git autocorrect bug
Date: Thu, 5 Jun 2014 13:29:01 +0700
Message-ID: <CACsJy8BSHAUiF_BR_Vi4_LOW0CSP-N09UpAg-UJvZJ1fvipejg@mail.gmail.com>
References: <1401940145.18134.170.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:29:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsRBA-0005qx-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 08:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbaFEG3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 02:29:33 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:58784 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbaFEG3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 02:29:32 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so766586qab.18
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 23:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=65au1F1DQvU3UEGsbbanuUB6qHgrM3RSPQbMrXyNViU=;
        b=Cd6Z5AIgckUoirQFPrTC3IKnNmuUvuAcd7NiEkBAUFbhxgPjiQPosPuBIuAduGTjVp
         SZw3MgJ0bE/70hAbtxCxdDdGwyd8IOFDTrv6Ba9IBl+SF2iU7jTWhGUwJy+vfud8tk2W
         kPCCPITyMbYbp+bhPtfEPLZZZLSh9pcfPUdOo3HV7l4ppj6/ytAvkwrneWsTphkip6Ql
         0r1T6PeHrKZWvB6UwIGJ2w8SkbnsjTyHZBL94VEmfkZNJ25cBa35R6FpjRnjWV3AKYRd
         Lk2XjPUqOOusjGyrXozycRe8pKYGV5Ix2eGfj97BZ7PfULBAjTCuSw6FP0TAEtCXruPv
         2/+Q==
X-Received: by 10.224.3.202 with SMTP id 10mr52830070qao.24.1401949771630;
 Wed, 04 Jun 2014 23:29:31 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 4 Jun 2014 23:29:01 -0700 (PDT)
In-Reply-To: <1401940145.18134.170.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250819>

On Thu, Jun 5, 2014 at 10:49 AM, David Turner <dturner@twopensource.com> wrote:
> fatal: internal error: work tree has already been set
> Current worktree: /home/dturner/git
> New worktree: /home/dturner/git/foo

This is the part you complain about, right? I think I might know
what's going on here. But do you expect "git git foo" to turn to "git
init foo" in the first place?
-- 
Duy
