From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [BUG] merge-recursive triggered "BUG"
Date: Thu, 19 May 2011 21:17:34 -0400
Message-ID: <BANLkTinG329ZBdf0TgnwA1m8Uo+6OZv-ow@mail.gmail.com>
References: <7v4o7260no.fsf@alter.siamese.dyndns.org>
	<BANLkTimNnRrJ_2UJUSWWd1QS=e0YH2p=_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 03:17:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNELU-000828-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 03:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934632Ab1ETBRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 21:17:36 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:58427 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934259Ab1ETBRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 21:17:35 -0400
Received: by pxi16 with SMTP id 16so2162749pxi.4
        for <git@vger.kernel.org>; Thu, 19 May 2011 18:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1HimKGdliIwtJBrqSKVCp7HeQD1dvHzlbNI2Umw2M7E=;
        b=vqTptTjJZ8zu8XgIicbKPiCuAOA+PsUJ6IkUdGYBnmVu+7kPZev3OklkWeIdZYw/II
         UYS0DeizVVUeViyz7AdA/KnFnR9cdtFne1qWS/vCCiN9NiLGNQRe6+ZfPlpO2iGeTGIO
         SjYFfZT7+y+PzMWFTwYIIXYj6FAI9mDyPaEKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=exg2O/8C+dGt0igA6NgRzT0jcGW0FCmP0lwCFSqWZU/p/DpJBof2KZPx46MiUWYI57
         Ujl7AK6WZtkeN0fuh6PSO2karW8mUbr0EzgmSX82mR9sUS2VDSQRirQwyAtQ8xED7eVU
         ZW8OfkAyHD15dZx46bAhYdW4tL32VFFnEmrT8=
Received: by 10.142.107.12 with SMTP id f12mr2227260wfc.226.1305854254789;
 Thu, 19 May 2011 18:17:34 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Thu, 19 May 2011 18:17:34 -0700 (PDT)
In-Reply-To: <BANLkTimNnRrJ_2UJUSWWd1QS=e0YH2p=_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174031>

On Thu, May 19, 2011 at 9:14 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I just ran into this. It's not in a repo I can share however. But, why
> did b2c8c0a make it into master with this known issue?

Sorry, let me clarify. I got the:

  error: addinfo_cache failed for path '...'

line, but not the BUG. I can try to bisect git if this is a different issue.

j.
