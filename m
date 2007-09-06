From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Wed, 5 Sep 2007 21:48:47 -0700
Message-ID: <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
References: <46DDC500.5000606@etek.chalmers.se><1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 06 06:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT9IW-00050b-FD
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 06:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbXIFEsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 00:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbXIFEsv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 00:48:51 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:5437 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbXIFEsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 00:48:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so43565rvb
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 21:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        bh=NT0X9Vi8bEdtcYXCrkhBgtub2zlNMfFz5F9E9YYo1Y8=;
        b=AyAJCDMbldDhzTLyGNFEm/bKwnANfuhIK8fY7XIUMgbocCEsqItK4mGxZ8r0ynBQFgtUI4fuqo/DYutUxiQoVatw9058QE6eL9CZP7cgOf3fsJ6h5zVZ38M3LuDxFI1fzcT0Ay8kZeqAYSgS3UieTbwuzFnsapP8mSkbE3Dyp9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=r2bqVWe5TcbOtGmuVWyweTOyUpTIQi6VOvi3gCKbAUWV9MpMvIqwo7po2Aikap/weSsMuKpavoHgN+eY60MOdZ/TwQx8zdmq8A8WG94ONFW9MxqQ5sVEBX/ZuUcU/a/IyZ7BeTcQsANbKXJER/3a7avB0DUE/pESIdFDOG2+kV0=
Received: by 10.141.53.15 with SMTP id f15mr76873rvk.1189054130647;
        Wed, 05 Sep 2007 21:48:50 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id k14sm11230515rvb.2007.09.05.21.48.49
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2007 21:48:49 -0700 (PDT)
In-Reply-To: <vpq642pkoln.fsf@bauges.imag.fr>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57815>

[ snip ]

When I first looked at Git source code two things struck me as odd:
1. Pure C as opposed to C++. No idea why. Please don't talk about 
portability, it's BS.
2. Brute-force, direct string manipulation. It's both verbose and 
error-prone. This makes it hard to follow high-level code logic.

- Dmitry
