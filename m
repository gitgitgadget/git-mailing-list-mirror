From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] send-email: Ask for in-reply message ID even if from and 
	to is already known
Date: Thu, 10 Jun 2010 17:18:16 +0000
Message-ID: <AANLkTikHhYcNRPOIWuMYjCnWahS2ydQZ2-vpswSYYohx@mail.gmail.com>
References: <vpqtypmn4bm.fsf@bauges.imag.fr>
	<1275415730-15360-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
	<201006101908.19578.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
X-From: git-owner@vger.kernel.org Thu Jun 10 19:18:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMlOb-0008GN-Ll
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 19:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759247Ab0FJRSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 13:18:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60623 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759185Ab0FJRSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 13:18:17 -0400
Received: by iwn37 with SMTP id 37so151985iwn.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=M+OqFkpNqZqz8bIZ8smltnUm3zFQ8LoKT6aHKrnD8w4=;
        b=kSm0KJO+Ftdx2VWwQMhyrxNsCj3fuZ8KMEffFNm26dwonbyXGzeWTynA+oRS8xPLsp
         9IcjtJoHjZoZHNe61PsUh4dpa9lNeNyiwo2JuPlR8F7rXcgdUfw/LASIjOX9EmlwfcMZ
         12MfrBeNkdYsHCElG8/spJbfJH5X5dEOwOxcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=M9k47Rn/frGcBb/F8hX09RrkH6UXFtOWW2h3pk5fLQIFzeM6QElvXkcK82HvurRerv
         jrNCExrlmyAWT/YXygHQafRszHzi5L/irhoQ3F/JNmVwpy6TNGtMadTykX7vYy4U+X2Y
         ySSKURDRGLKqCzvk3WrHQoDI9M3FDnDyqkYUU=
Received: by 10.231.210.19 with SMTP id gi19mr387686ibb.140.1276190296449; 
	Thu, 10 Jun 2010 10:18:16 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 10 Jun 2010 10:18:16 -0700 (PDT)
In-Reply-To: <201006101908.19578.alexander.stein@informatik.tu-chemnitz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148895>

On Thu, Jun 10, 2010 at 17:08, Alexander Stein
<alexander.stein@informatik.tu-chemnitz.de> wrote:
> Did get this patch overlooked?

Perhaps it would be better accompanied with a test addition in
t9001-send-email.sh.
