From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Fri, 14 May 2010 23:21:53 +0200
Message-ID: <A9FDBDB6-61D0-4FD2-BF1E-D5B802D2880E@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org> <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com> <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org> <AANLkTil1i_vFAvT1CotYdK47LnufVKc17-1168rOVcMX@mail.gmail.com> <20100514045646.GA2433@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Robert Buck <buck.robert.j@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 23:22:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2Ka-0007WH-S1
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab0ENVV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 17:21:58 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:40669 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab0ENVV5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 17:21:57 -0400
Received: by ey-out-2122.google.com with SMTP id d26so302425eyd.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=uTbTJtlSaZriB5e25TQm/E//ht2qvol9wUzFFcy1oD0=;
        b=geZmWcY9HswZ+0ySmwpMYAnrV55HciDRKDeltPAeZ3oSkMY7p4ABzyvTAI99LH7/bE
         3+fQ5WxjvBTqtjW5HOWqjG11bYnVcPltSYgaZLXdhCYX2BfwBM2KIIebtaKtWZ8nak5I
         UhemGYo5vw9aE4yn3nhtXICooL7jU+1Uqo6Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=ZXBlyPl5a/etRTxV4LLTQq+u7DcyD0GbkMjJxH4dAyehUE5oj07EOP4JTy0Du2ZbMl
         LV++5xmn8Og5FwvmoksfXB62cmc/vFHEA+7teZ6oZ+iC6ryJGep8EXmgfCWcfWvZ3+RY
         mFwFuzVxrjJ10BtWlVeEA6sNftJK8/Ls5kS2s=
Received: by 10.213.44.14 with SMTP id y14mr934717ebe.96.1273872115597;
        Fri, 14 May 2010 14:21:55 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm1486656ewy.12.2010.05.14.14.21.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 14:21:55 -0700 (PDT)
In-Reply-To: <20100514045646.GA2433@progeny.tock>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147117>

On 14. mai 2010, at 06.56, Jonathan Nieder wrote:

[Lots of good answers cut]

> - The crlf attribute gets a new synonym "text" to avoid confusion.

I would prefer to phrase that as "the text attribute has the synonym 'crlf' for backwards compatilibity".  If I wanted to avoid confusion I wouldn't have renamed it ;)
-- 
Eyvind
