From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 13:09:58 -0500
Message-ID: <535e9976f1835_499f1069310db@nysa.notmuch>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
 <535e91e6c69eb_4565148331047@nysa.notmuch>
 <20140428181506.GA20059@seldon>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Marat Radchenko <marat@slonopotamus.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer1D-0003SK-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbaD1TM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:12:58 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:47514 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169AbaD1TM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:12:56 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so7775682oag.31
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=mr9uL1uaxPhrn251zTJGTcexgSe+fcZmmTxSPaHfltQ=;
        b=xn5gpS+VFQEjZaenLqfYzGoZCyERHhbdhmmjIGgb6JY04Q7qd1UgS6NYtP9RQP8450
         K4qSJGyBI/D/6M9yUlh66cGuKLS6C4omkx+dCMoBnUXZyX0ZVSbdEC7nmlb6qIyjc5On
         JcI2cgrAFWNVTOIgCfwDBsP94+70bs/wKaUJGCHF89GO5eFITM64R+YG3vX17zXEcNEJ
         TWR5dYez2p7IQeSKBiDQ7uc7ixSZHeb5nurbMrA6P6pQGPSpIAZ28kQuAvM742wsaU2f
         8tWx8C8/ZBABdgXRYRgwReh5+uMVLWjF/rSgwoL3m5gwqxTnwknwZHDGxOz5SyapQWdz
         ZDpQ==
X-Received: by 10.182.109.201 with SMTP id hu9mr1938141obb.77.1398709232837;
        Mon, 28 Apr 2014 11:20:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id su13sm76498877oeb.9.2014.04.28.11.20.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 11:20:31 -0700 (PDT)
In-Reply-To: <20140428181506.GA20059@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247392>

Marat Radchenko wrote:
> On Mon, Apr 28, 2014 at 12:37:42PM -0500, Felipe Contreras wrote:
> > > +CC = $(CROSS_COMPILE)cc
> > 
> > Nice.
> 
> Actually, not. You still have to override CC because it is
> $(CROSS_COMPILE)*g*cc. Any thoughts how to handle this?

Tell mingw to fix this? My distribution (Arch Linux) provides a link
x86_64-w64-mingw32-cc -> x86_64-w64-mingw32-gcc.

-- 
Felipe Contreras
