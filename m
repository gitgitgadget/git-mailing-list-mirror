From: "Blake Ramsdell" <blaker@gmail.com>
Subject: Re: [PATCH] Removed OLD_ICONV in favor of checking _LIBICONV_VERSION directly
Date: Fri, 2 Nov 2007 17:21:48 -0700
Message-ID: <985966520711021721i6345e4bfv8a016a1528ee4e23@mail.gmail.com>
References: <985966520711021303g905f638y2056219c22e5edeb@mail.gmail.com>
	 <1194048010-65955-1-git-send-email-blaker@gmail.com>
	 <7vbqacyyx1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 01:23:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io6nN-00077L-EC
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 01:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762449AbXKCAVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 20:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762392AbXKCAVu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 20:21:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:39313 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762066AbXKCAVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 20:21:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1117347wah
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=U/QpXhbzSDdrNCtoRDsxLOT/oIhrBw8VNqKFhHS9Eeo=;
        b=F83anAk/4hdVVGcowSZuB9XadmTMFkRW/9gRVAKvMI1Zv9KqvcUDjOFlCHXF19mKPvmSOe5Gt+TWPhOdQHsf3QY3MwXIXzEGTkhjHBaQoj6ldqTYxa2/PWVPxlKwOVjLGihCrxbzaLCxrO4jkMiLWvdNQ6RZuCEXBLpKtokKzJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QUAhj02V0wkOQMfNERbhx14PIGTt1UudgQOwG3eiL3Rj/cwrSupeKb/Ub/HcU/W4gwVA9+1a9bYSaeAzmVKJrYLvX6v/+FskUtBP7iWZP1a/zPXpyCV7OBFyqxjU7bOxAdUkvMnf/O8MMJzYH/vcXdRfAhgmaMuGoU1aRcYyRlA=
Received: by 10.114.89.1 with SMTP id m1mr2461195wab.1194049308071;
        Fri, 02 Nov 2007 17:21:48 -0700 (PDT)
Received: by 10.114.176.14 with HTTP; Fri, 2 Nov 2007 17:21:48 -0700 (PDT)
In-Reply-To: <7vbqacyyx1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63197>

On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> Does everybody's iconv use the same _LIBICONV_VERSION scheme?

Apparently not. And furthermore, my assumption about the version
number being tied to the function prototype was not valid -- I have a
DarwinPorts iconv.h that is version 0x010B but uses const for the
second parameter.

Sorry for the mess. Let me try and come up with another plan. That
Darwin version check doesn't seem so bad now ;).

Blake
-- 
Blake Ramsdell | http://www.blakeramsdell.com
