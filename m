From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] don't append 'opaquelocktoken:' in PUT and MOVE
Date: Sun, 8 Feb 2009 03:00:58 +0800
Message-ID: <be6fef0d0902071100o68cf0f81m2e666bb1dac9977a@mail.gmail.com>
References: <498DA4F9.20104@gmail.com>
	 <alpine.DEB.1.00.0902071801570.10279@pacific.mpi-cbg.de>
	 <be6fef0d0902070952l5818e4b7x3048c667661ce31@mail.gmail.com>
	 <alpine.DEB.1.00.0902071903020.10279@pacific.mpi-cbg.de>
	 <be6fef0d0902071038y3e6de33es33a73ab6a068f9ac@mail.gmail.com>
	 <alpine.DEB.1.00.0902071956480.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 20:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVsRk-0002uV-BA
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 20:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbZBGTA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 14:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbZBGTA7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 14:00:59 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:15729 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZBGTA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 14:00:58 -0500
Received: by wa-out-1112.google.com with SMTP id v33so628149wah.21
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hl9xIjLU+pLLZQdyOIfk5oKJX3OhtrLtiPVbe9sLYOo=;
        b=OcdnIb8E1whcLF+xwahfEcuVW++K1vvY3zGN+II3Ct9rIIRPbJH1kIhvf9Z4eNrl9P
         goNkM3uQB2Q+D3EL8h8Y1d2/iTt91cfl85Y+dOSOrkT9HC/jWJEWL5fgUii/MMx1sVVi
         9ue8uztDjDtuvhsALBF3t7rkpt6dxjX9uO8ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U8T0jHdb5qsS8JbcOoPbA4ZnUaadwmf3kHjJNf8/dKqCdUpNaEOUfaDmWQ6HwpPGnE
         Z9FTzTup4jiAvI0uUrwK+doZMO7s5hVndGDM31QT6mVEe+b20eCL+8SeXbdrA0OmViH2
         +elm5iYMwrxDAuBMJttk7m2B2uWMwATBtvLzU=
Received: by 10.114.169.20 with SMTP id r20mr2219314wae.110.1234033258067; 
	Sat, 07 Feb 2009 11:00:58 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902071956480.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108875>

Hi,

On Sun, Feb 8, 2009 at 2:57 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Huh?  What does that mean?  Does lock->token have that prefix (including
> the colon) or not?

Yes, it does have the prefix with colon, but it is not true that it is
always "opaquelocktoken:" -- it could be some other URI scheme.

I submitting a new patch that accounts for this (other URI schemes).

-- 
Cheers,
Ray Chuan
