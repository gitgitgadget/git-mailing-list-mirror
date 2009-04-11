From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH RFC 10/10] send-email: --compose takes optional argument 
	to existing file
Date: Sat, 11 Apr 2009 21:25:20 +0200
Message-ID: <fabb9a1e0904111225x7a8915a4q78202f397f9dc971@mail.gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com> 
	<1239476908-25944-2-git-send-email-mfwitten@gmail.com> <1239476908-25944-3-git-send-email-mfwitten@gmail.com> 
	<1239476908-25944-4-git-send-email-mfwitten@gmail.com> <1239476908-25944-5-git-send-email-mfwitten@gmail.com> 
	<1239476908-25944-6-git-send-email-mfwitten@gmail.com> <1239476908-25944-7-git-send-email-mfwitten@gmail.com> 
	<1239476908-25944-8-git-send-email-mfwitten@gmail.com> <1239476908-25944-9-git-send-email-mfwitten@gmail.com> 
	<1239476908-25944-10-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsirY-0005XD-0Q
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758507AbZDKTZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbZDKTZi
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:25:38 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:55529 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbZDKTZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:25:37 -0400
Received: by bwz17 with SMTP id 17so1551812bwz.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=z1QJjmHkEuk7rgyq/fKRyXDYUsziiF78g4FXFKb6+7Y=;
        b=eCkU5S/bnuufhkCFOo0w88R8EWMmMoDikijxs8KJ6g5mdG4yHTwpIpeNKlNF1OuV/q
         yYPCKSygO9QoCPeZRNqgcZ4vs8lH4p9A2GSyAOfbFeAeFamYdXD4bQB9GS7ljbBwQt/V
         iz0aPcTurTi7+8+Pkr3FFQoRjwINn1CIU8zJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uqtdNhcrGGNkspytkGaOE9x3EsR7gqusDmi2wryBtU2anc/W/F9EoaUWXqxf9opxFU
         2PvFMkqsJ0PT+XUjDp6lxGJ8KY1p+7xoG2Gmt/EjnKVIj2GihKfyuv5Ati1EeNWX1iWL
         bYirwWxalcLijf0IN+zIRw4Q9X6SgXj6kc4Uk=
Received: by 10.102.247.4 with SMTP id u4mr2478054muh.128.1239477935221; Sat, 
	11 Apr 2009 12:25:35 -0700 (PDT)
In-Reply-To: <1239476908-25944-10-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116332>

Heya,

On Sat, Apr 11, 2009 at 21:08, Michael Witten <mfwitten@gmail.com> wrote:
> Now, a user may specify an existing (in-progress) file to use as
> +with "`GIT:`". If the `<body>` of the final version is empty, then the
> +email is not sent, and send-email proceeds as if '--compose' had never been
> +used.

Ouch! Wouldn't it be better to abort instead? Allover git we abort on
empty commit messages and the like, why not here?

-- 
Cheers,

Sverre Rabbelier
