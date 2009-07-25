From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git format-patch from date never set
Date: Sun, 26 Jul 2009 00:31:31 +0200
Message-ID: <81b0412b0907251531u7566813fr10bdd70187e9aca6@mail.gmail.com>
References: <325c62f60907251439n6f3f661dhf0e76a74ce1eaec8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan Savilonis <djs@n-cube.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUpmG-00056T-Gh
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 00:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbZGYWbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 18:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbZGYWbc
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 18:31:32 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:60149 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZGYWbc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 18:31:32 -0400
Received: by bwz28 with SMTP id 28so1990707bwz.37
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yHcDcguwqVqbXXfQt/BfxHrVr0yMIVPZEjttSMN8kSo=;
        b=d53GzveOchDtoDaKZQao0mQKxud89nBgzxKHQlp+cgTmegg7ntDBvWcBPhsDc/gE/P
         EbZ9ChKL1hfzkZ1TXyA4E9KOfRvCRZLgQ8PUD3PV0pWLYZtMykLVWiNeQJc+4uWnlX62
         wtjkV9qYmVeTEsR8iaF0Qp0SW1w56X7VZ5jOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eki1eeZ5rolGEZ4ZeigY+lYL5jISdUPOzpLblNtMcWQCFWcIXe300hipRvPYrY4JDg
         Fld3TORhz9g1gJmCqBN2kv1GFyhFY4VnnIXH90Eg1+SGyKbfeSiQp+Wawf/wl/Q7t2Ae
         DzrakJxUydzgbPC5m3/bIt8MipQuFUUC0IHXI=
Received: by 10.204.100.10 with SMTP id w10mr1305594bkn.211.1248561091674; 
	Sat, 25 Jul 2009 15:31:31 -0700 (PDT)
In-Reply-To: <325c62f60907251439n6f3f661dhf0e76a74ce1eaec8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124083>

On Sat, Jul 25, 2009 at 23:39, Dan Savilonis<djs@n-cube.org> wrote:
> git format-patch always sets the date in the From: line to the git
> default date, e.g.
>
> =C2=A0 =C2=A0From b9ff0ba6f3e228e1a8b67a25bc7be6b1da5ed1f3 Mon Sep 17=
 00:00:00 2001
>
> The command uses GIT_COMMITTER_DATE as the date, but this env variabl=
e
> is never set in cmd_format_patch(). Is this a bug or 'feature'?

Neither. This is not a date, but a part of "loosely defined" mbox forma=
t.
