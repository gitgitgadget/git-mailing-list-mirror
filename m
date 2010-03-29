From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2 0/2] git-gui: git-gui: change to display the diff with 
	the HEAD in the case of conflicts.
Date: Tue, 30 Mar 2010 10:02:44 +1100
Message-ID: <2cfc40321003291602x4cf9fdddsf294e2af6f84d632@mail.gmail.com>
References: <2cfc40321003291600q70f0839bt8720dd025a3891f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Mar 30 01:02:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwNys-0006gJ-NK
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 01:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab0C2XCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 19:02:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52771 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab0C2XCp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 19:02:45 -0400
Received: by pwi5 with SMTP id 5so7151808pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=tddxmfB8WTavG2MTwM9coI0zRjgYdVg6w/kEVBRGY9I=;
        b=SfZhIXFBqSf94ysVUjrzXdTA2dE+bCrERczp2/1hkh7hvXQdtcI0CzLxjaaV8xMM64
         +2vzCgBZTE2TXSBZaV0xo7v/6vIoqAOPhcvADDSWDAcXFRVka7tIyyLk8m8Gsf92NBNu
         8DLfV0xMHRLVidaxtbAkIEtBG3EQeDrdHO/vE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=LHby4MYe9kT1NqDSBrM+DBgHyQersK07nTd4oZbvhPGOOF+V405ZZUdub6ha8PehYo
         VeITW/YYxUEvfGQfhkgFg7GxqRNYTLhqyIiE+DBLbw0H2gEefAkvCWyVnxt3HozUZcTu
         Tr6BSRuzX/QskhPunstEUphIZpS9kU5VByrEM=
Received: by 10.114.13.5 with HTTP; Mon, 29 Mar 2010 16:02:44 -0700 (PDT)
In-Reply-To: <2cfc40321003291600q70f0839bt8720dd025a3891f6@mail.gmail.com>
Received: by 10.114.23.2 with SMTP id 2mr4503459waw.132.1269903764721; Mon, 29 
	Mar 2010 16:02:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143529>

|  __not__ -> __now__

On Tue, Mar 30, 2010 at 10:00 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Resending because my original patch series wasn't whitespace clean and
> I have now removed the configuration to make the safe behaviour
> optional - it is __now__ safe by default.
>
> If there is any other reason why this patch should not be considered,
> please let me know.
>
> [PATCH v2 1/2] git-gui: Introduce is_unmerged global variable to
> encapsulate its derivation.
> [PATCH v2 2/2] git-gui: change to display the diff with the HEAD in
> the case of conflicts.
>
> jon.
>
