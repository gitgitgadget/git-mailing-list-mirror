From: Pierre Poissinger <pierre.poissinger@gmail.com>
Subject: Re: [PATCH] AIX 5.2 - bug with 1.6.2.1
Date: Tue, 31 Mar 2009 14:48:18 +0200
Message-ID: <3930158b0903310548o5718be5dla2f3e91fbf718ded@mail.gmail.com>
References: <3930158b0903301647o790f7381l37ba61089713ce80@mail.gmail.com> 
	<20090331103703.GA1589@coredump.intra.peff.net> <3930158b0903310520h1f421518ka67de5f7aad0690b@mail.gmail.com> 
	<20090331122923.GA7173@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 14:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LodPt-0002Aj-NF
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 14:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349AbZCaMsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 08:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757275AbZCaMsh
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 08:48:37 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:62435 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334AbZCaMsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 08:48:36 -0400
Received: by ewy9 with SMTP id 9so2529008ewy.37
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G74AH7NmToS/UmJ67LhjZFHxXUhBB0rct+POWLNgpTQ=;
        b=MCPqZgwdk0aUTJsDEkh5eZtE7IX+myoMR/qaCkbrfYRWKlj0iP5smCiIhqo8xY2qbh
         5tyIaDe0pjYjUhCE3i97CjFVhO0gY8kTnvHRUpnig+NceiIoZdnuegwvrdhNYyCiZHVy
         KfqaMwkFyMoDhUaOe5+9BDqo2L5HLEww7n7As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f7fPPRQWNBp/0bxMATdd4isC3IEbjTdM0qLWimFEFCivVvoind2Q3tt1gSh7AHeCrb
         mtt5JakOqNGbJ7s0cKYwCyjw6uPLCJGqA5W4zk1gaLIDDWM/iStmWNoUOSueutD8QNJ4
         Yzj0c9cI5fYxbihzvwcUHN6fkq1wapeQVXdPE=
In-Reply-To: <20090331122923.GA7173@coredump.intra.peff.net>
Received: by 10.216.0.83 with SMTP id 61mr2056460wea.170.1238503713207; Tue, 
	31 Mar 2009 05:48:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115257>

> Junio, I think this patch should take care of it.
Thanks !

Pierre,
-- 
>>> horsemen = ['war', 'pestilence', 'famine']
>>> horsemen.append('Powerbuilder')
