From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Thu, 5 Nov 2009 10:41:51 +0100
Message-ID: <40aa078e0911050141t3c85e14k91692ac5c542eb77@mail.gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
	 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
	 <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
	 <4AF20534.2030004@gmail.com>
	 <alpine.LFD.2.00.0911042111270.10340@xanadu.home>
	 <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 10:42:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5yqx-00088x-I9
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 10:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbZKEJlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 04:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbZKEJlt
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 04:41:49 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:38586 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZKEJls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 04:41:48 -0500
Received: by ewy3 with SMTP id 3so4045876ewy.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 01:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=E/86WJjhbz2ZgozLqe1kYcsmq+oQkr72kDZY1ORykDE=;
        b=CL4ixYjnX90SAhbHTDR7LCJ7uMnkgZe2+3Yzxt+fy17vjqzBq2+DPWHw8zfzg83Y75
         H19WcgbMh0H8sobwqb0oH4cE40aNmyNjNq2ptujWhg5pukwNOM3OWZ4FIFKUKHMZcwQO
         bU69qAj3CjzpQfEVstW0Pdo+L29CexXSecHaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=AQWoOHnZdSE8LIpkvoiCVwOAryPiVh58ELqvWBdgGZZCIfztlFUtAuub+0EZx8C5F5
         5sC4Svnt8E2A1L3eqwOhODkiZM0eOau/sNee+Tp1t0hHo964yjWQQ61d75BwwvX/U/wi
         nOi0yaWtiT7geVPBpakBKMWqTmorJC3Evfxe8=
Received: by 10.216.88.18 with SMTP id z18mr905298wee.78.1257414111770; Thu, 
	05 Nov 2009 01:41:51 -0800 (PST)
In-Reply-To: <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132218>

On Thu, Nov 5, 2009 at 10:00 AM, Andrzej K. Haczewski
<ahaczewski@gmail.com> wrote:
>
> That way we don't need allocations to simulate pthread init/join API

Yay! By the way, I love the work you're doing here. Getting threaded
delta-searching on Windows is something I'm looking forward to :)

-- 
Erik "kusma" Faye-Lund
