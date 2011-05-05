From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-svn and a new svn remote helper
Date: Thu, 5 May 2011 22:25:06 +0200
Message-ID: <BANLkTikAtgunYTax5d4oEDAot83wOROmhw@mail.gmail.com>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name>
 <vpqhb9vplu4.fsf@bauges.imag.fr> <7v39lfa1h5.fsf@alter.siamese.dyndns.org>
 <20110419093108.GA7440@ted.stsp.name> <4DAD6FC4.6060004@drmicha.warpmail.net>
 <20110419120031.GE4134@ted.stsp.name> <4DAD7EFB.2050507@drmicha.warpmail.net>
 <BANLkTimJa5EDxXerwgZP7viLFPQRc=39uQ@mail.gmail.com> <loom.20110505T211005-593@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthew L Daniel <mdaniel@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:26:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI57Q-0002tN-IY
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab1EEUZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:25:47 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62364 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1EEUZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:25:46 -0400
Received: by qwk3 with SMTP id 3so1760071qwk.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=P0NoSL0jjdGVspaQRN9hvOD03YXqkAlOYVd7CE9cS90=;
        b=q2xir45ac4hz+McFWpQUQtBKm4tSqQEAOeiRhAxeh3GTbz7hiudsBPn38LzGNblcTn
         VPNTodF3h//EDOpJLULXsBh7dCgd7tyUIiuik8YGObMqHhtL7oEis+ikZ7LCcQPFYWp4
         3r8iEkLJ6VOE3DJIcP7i0tUTUN6seAxEjCXUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fmv/jtQLOy9NhfP3LC2pZaztFAk8OtjJPhJE0ByFsBlWB+0GH9OsrbB5wwAtsrb0vS
         7IxGbi1q+ZjRHojSPCeHnDfxsoTS282fBtpC8m7JieWGc4HXf3MYHOia0UoIHy2BouXC
         J9WBbLdRCxcdsvU/0kAflAratciBfc/rkHbLc=
Received: by 10.229.42.142 with SMTP id s14mr1990535qce.174.1304627146191;
 Thu, 05 May 2011 13:25:46 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Thu, 5 May 2011 13:25:06 -0700 (PDT)
In-Reply-To: <loom.20110505T211005-593@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172905>

Heya,

On Thu, May 5, 2011 at 21:13, Matthew L Daniel <mdaniel@gmail.com> wrote:
> Is there, in fact, a new svn remote helper under development?

Yes, Dmitry Ivankov is working on this as part of his GSoC project [0].

[0] http://www.google-melange.com/gsoc/project/google/gsoc2011/divanorama/17001

-- 
Cheers,

Sverre Rabbelier
