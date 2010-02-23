From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Explicitly adding ignored files in subdirectories not working
Date: Tue, 23 Feb 2010 22:58:41 +0100
Message-ID: <fabb9a1e1002231358g20ce98fav375e797bd719c793@mail.gmail.com>
References: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com> 
	<alpine.DEB.1.00.1002232248000.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:59:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2md-0001ji-L9
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab0BWV7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:59:05 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:40248 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab0BWV7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:59:04 -0500
Received: by pxi29 with SMTP id 29so2299508pxi.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=wrUDYFillhhk4cO1Nl9DdbnQWDFtQwfcw3pE6lrta0E=;
        b=R3eJa2bj0YuRKJYH7uTUT66EVQ04PPiH8B95m5LBfLCF0bbkYOMtN8ZNYp513MrpjZ
         vs0dPEd039YGwWCNUUHtGgYSalGaFGGf5YPaytD24IvKmZJpn/CATrlfXMqch7OK6yQE
         eGW6k12MDmQkD+IzfKtOzZh947wsWOJ9piN1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JBstGNmaKvkbccBVyN0iPn96xIWNpMPFSIY4jCHkvlcgQvAHIc9LNFyXLW2sGxOVhg
         HFBBBOY39HJ/5nlyirMNHOgzzCykLWEzFv9JZnnmC7CEpNRZO4MW+Mjv8UYxj9o3Wam5
         2ghr/9uqfI0PBoTlZ3iolfahjzbqgc/5Qlm7k=
Received: by 10.142.59.3 with SMTP id h3mr348960wfa.93.1266962341062; Tue, 23 
	Feb 2010 13:59:01 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002232248000.3980@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140852>

Heya,

On Tue, Feb 23, 2010 at 22:50, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> $ cd Documentation
> $ touch doc.dep
> $ git add doc.dep
> The following paths are ignored by one of your .gitignore files:
> Documentation/doc.dep
> Use -f if you really want to add them.
> fatal: no files added

Do you have Documentation ignored? It works fine for ignored files,
files in _ignored directories_ however... :)

-- 
Cheers,

Sverre Rabbelier
