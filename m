From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: 'Use of uninitialized value in string' line 651 git-send-email (from the 'next' branch)
Date: Sat, 22 Mar 2008 11:07:43 +0200
Message-ID: <f36b08ee0803220207j60eacbbet279c62f642cdaed0@mail.gmail.com>
References: <f36b08ee0803180644r23c21a21y9d753492be2189ec@mail.gmail.com>
	 <7vprtr44hj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 10:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jczin-0000ZA-V9
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 10:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbYCVJHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 05:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbYCVJHq
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 05:07:46 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:32244 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbYCVJHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 05:07:45 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2376674fkr.5
        for <git@vger.kernel.org>; Sat, 22 Mar 2008 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tp/kgjLKj+aq8CNS5i2V2xp0Agh1Ah5z0xFX8qtCzOQ=;
        b=DhL0mSa2FZSVKMhDaLQbxiwMttksRfbwWNE8oaFpJfDebv6Bhm2TRRiUwZdzZ6A19CFnNJz1Uc3SSH9o6UCGHhqZIViSaqO1tFlcvxkh5v3butLErJZ/g7GWRkn/5FxsL6+D85SzxO7BfJ4oChg4EOsNG7NR6n1ucG4iP5z+KfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cHJkW9cH4GQxE926oHymKlqZC+jKoq101Q+4k4ZSTMl0U5sR4Etp/yNkuz1zh8GTN9YsRNeHg8NAmRd0vH+TCSkCXDOEwKfVp4PwTbuVyoiecGlo3tFRAY00owABO5P0pDEzlDk1lnc5c3HQR4lBgvs1BtSLDfboLmwEcr/2rNY=
Received: by 10.78.135.20 with SMTP id i20mr12361128hud.18.1206176863350;
        Sat, 22 Mar 2008 02:07:43 -0700 (PDT)
Received: by 10.78.199.17 with HTTP; Sat, 22 Mar 2008 02:07:43 -0700 (PDT)
In-Reply-To: <7vprtr44hj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77792>

On Wed, Mar 19, 2008 at 8:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Does it happen with "master" as well?

Yes. Happens both in master and in next, when patchfile begins
either with empty line, or with paragraph indented by 1 space.

Yakov
