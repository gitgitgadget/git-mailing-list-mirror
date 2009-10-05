From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when 
	appropriate to do so
Date: Mon, 5 Oct 2009 23:03:13 +0200
Message-ID: <fabb9a1e0910051403o6f26a2abn1c3e5d28b12c8838@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muujj-00022l-Km
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbZJEVEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 17:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbZJEVEl
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:04:41 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:18920 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbZJEVEl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 17:04:41 -0400
Received: by ey-out-2122.google.com with SMTP id 4so667149eyf.19
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=p6enOlOBoJ6G9ftjXZ312iB//ljlJNJ7ytkXtv/gDQs=;
        b=l350P/ZUnpZiCA3ITjIkwzh1B3PENBdlpvN4fofJkllqocxESrdhGbrcG9S4ZrPnmG
         VFnwc2bWwW4J9hBWF2b+40bECvfLnXXuVXsizUoNIWs7TMKS3TmTmKQufJhOqP/pwQ0/
         wpOpT8ZICbUWqBtbPX3IBba8ObtcpWQUwHTNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qPrXfEpkIrG9UtYfIsd+yeUYPHk+S1wDSAowRZOE4RPs5c6NH0ziKLp84/HcmZgPPF
         kMmIowdMywM3YB62bmqIC0vSWs/qBJkyqQPYkhIx7ERWZH5qC1N4CGVSCLU9ocqh32Iq
         atUynCwers8qi6ae7JTHP5eE1nwewMHpYEbSY=
Received: by 10.216.0.5 with SMTP id 5mr117024wea.144.1254776613136; Mon, 05 
	Oct 2009 14:03:33 -0700 (PDT)
In-Reply-To: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129588>

Heya,

On Mon, Oct 5, 2009 at 22:46, Jay Soffian <jaysoffian@gmail.com> wrote:
> To create a local branch from the same named remote branch, use
> =A0git checkout -b next origin/next

Since Dscho added the most useful "-t" option to git checkout, why not
suggest that?

$ git checkout -t origin/next # instant win

--=20
Cheers,

Sverre Rabbelier
