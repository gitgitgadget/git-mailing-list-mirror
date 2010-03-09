From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Tue, 9 Mar 2010 09:06:30 +0700
Message-ID: <fcaeb9bf1003081806y13da4a1au80a925e9febcd8ca@mail.gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com> 
	<4B9504C9.5000703@lsrfire.ath.cx> <7vmxyijts1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:31:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyTm-0001Do-J9
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483Ab0CICGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 21:06:53 -0500
Received: from mail-pz0-f200.google.com ([209.85.222.200]:52131 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab0CICGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 21:06:50 -0500
Received: by pzk38 with SMTP id 38so1433629pzk.33
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 18:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=dEf7b4XCJYIbe6EPhJjqsiCdagHo3+Nbr/8ON3hYTpM=;
        b=TCxa3P3ZOqLifqxZcRNdQQ7kSiATwjXGMwXchjD1h3cYEEMCbdqOw4TURpq6lCmqdW
         o1SL+aWUr58FXh8EagRh3gZ9toiObQCRjeAFuwN0sAD5jyTZh5yxZsPU1jl5PvK+GCAY
         5ZBKAccgGKm1bvVr9kJ+c0EdCkix4xJEluw80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cXKg1jbihIJ/tFzqNXvmtKhXeDFosZJwx0LRj5Ozj+6lcAJBofXpoPBg/XFLcrgkhK
         NzUdUubyaZnyTrwZYyAjrEfMCpI09aawda0aT8TXeiSGiTlKeULE9vO6ZPWGzPWZGAS2
         6nZG5AJLXw5jg1sZGTk5GPGrjjjilDO4zlsu0=
Received: by 10.114.5.9 with SMTP id 9mr2360490wae.72.1268100410124; Mon, 08 
	Mar 2010 18:06:50 -0800 (PST)
In-Reply-To: <7vmxyijts1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141808>

On Tue, Mar 9, 2010 at 6:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Also I think it should not be able to change
> the behaviour of these commands so much without being explicitly asked
> from the command line, especially for plumbing commands like ls-files.
> IOW, introduction of the configuration variable without thinking things
> through is a bad idea.

Hmm.. ls-files does not take core.columns into account. Command line
parameter --columns is the only way to turn column layout on in
ls-files.
-- 
Duy
