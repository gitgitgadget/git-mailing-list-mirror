From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 3 Jun 2009 12:21:07 +0200
Message-ID: <40aa078e0906030321u11ec3bbag47e66ca23ec94e09@mail.gmail.com>
References: <20090602174229.GA14455@infidigm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sparse@infidigm.net
X-From: git-owner@vger.kernel.org Wed Jun 03 12:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBniQ-0003pL-Vk
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 12:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbZFCK2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 06:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbZFCK2x
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 06:28:53 -0400
Received: from mail-bw0-f165.google.com ([209.85.218.165]:38357 "EHLO
	mail-bw0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbZFCK2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 06:28:53 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2009 06:28:52 EDT
Received: by bwz9 with SMTP id 9so22682bwz.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 03:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ilj47x+jdzakT0tANuCsvjtlUQChwtgMw9xwhspPaE0=;
        b=bsFGhRhScPpbrpaZ6MWI3Pl1M+TzRGmm/lZsmHv1X+5BtK2Vcy0tfZZ+fkRGx4Wm9y
         VjhOplosqWSaISpWxJ1WX2SiSL9AC46i6ZTdfFUTIjbX8t9Yq73p9yqwE6ZMuHe+xDbV
         JK/dep1wK3SEgcn0o7lTinCloOetBhzNhaG64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H3ZeAFGdoot5QeY4zcnKYNYVckNAhwjGbgzUgftaq5Z1OKfNlduUjTP0PwlImEkGox
         5LvQL11aBChaUjbx9HNbG7YEP94yXQsMRI5GgdMhabrslk979yyxmMlKWOvdr7iZkC0e
         qCFu5uQXQZ9tPkPXJFQvxD5/fqVsPeUvScjic=
Received: by 10.239.175.146 with SMTP id n18mr63641hbf.16.1244024467537; Wed, 
	03 Jun 2009 03:21:07 -0700 (PDT)
In-Reply-To: <20090602174229.GA14455@infidigm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120596>

On Tue, Jun 2, 2009 at 7:42 PM,  <sparse@infidigm.net> wrote:
> When cloning over http git spews a bunch of hashs that don't really convey much.
> The attached patch disables them unless --verbose is specified.
>

We prefer patches inline on this mailing-list. See
Documentation/SubmittingPatches, "(3) Sending your patches." for more
details.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
