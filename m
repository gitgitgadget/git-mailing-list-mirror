From: Martin Gregory <marting@adelaideinterim.com.au>
Subject: re[2]: Issue with sparse checkout
Date: Wed, 18 Sep 2013 07:46:22 +0930
Organization: AI
Message-ID: <SDZTMVc5MiUjTUpfPVQvNzQwODk1NjI@IBMLT4>
References: <CACsJy8A5hxr-oSiLTmY2iA-LrmnCk3PW9SxLcvYdJgfDV7Qppg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 00:18:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM3bC-0007LK-3d
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 00:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab3IQWSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 18:18:18 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54375 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab3IQWSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 18:18:17 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so6158800pdj.25
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 15:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :mime-version:organization:content-type:content-transfer-encoding;
        bh=cYyScZY63vxxC5AZhIGvHlvcwm9KoT4eBX36jxHDIH8=;
        b=m/UVrUaGy0iR78AdlTpx69u6nAirO8qupQO0sRHTO1Bjw+MG1qGOviPgy2fCCvwEut
         ElSorrh/CxbobNWCT0mPDoRr/7n7knoZ51UUFZHHhXvOVKB5S2JA6t4lpb2v9ULryb4U
         ai35L2Dv97otJecHUA6RckYKqCC/uxfLOBYGmzR15bQO/cBalqvsamX5eIKxPFENV9CG
         9Wlmgxfha+SmZ9uGuW/VHi9CMHwpVKuqTYtLhQdmXbUdPfyHEE93GAPo/QEgx1mMPtXG
         R49Co3exqkRabYQNfBoG2wAq3wp3Ixm5YFPsDqBdAwQbRxl2l1rppnf3dmadr2wzekDN
         c89Q==
X-Gm-Message-State: ALoCoQnT1Is+ypvN89xsLI7heCLi1GpacfnETMQAvCwJf9or737qJR7NhSSzBkxjB4yN1vxIx79b
X-Received: by 10.67.3.103 with SMTP id bv7mr38789542pad.15.1379456297030;
        Tue, 17 Sep 2013 15:18:17 -0700 (PDT)
Received: from IBMLT4 (ppp14-2-54-108.lns21.adl2.internode.on.net. [14.2.54.108])
        by mx.google.com with ESMTPSA id fk4sm20086pab.23.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 15:18:16 -0700 (PDT)
In-Reply-To: <CACsJy8A5hxr-oSiLTmY2iA-LrmnCk3PW9SxLcvYdJgfDV7Qppg@mail.gmail.com>
X-Mailer: GoldMine [9.2.1.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234938>

Hi Duy,

Thanks for taking a look.

>>  > So it does feel like a bug to me: why are files with ^S set remaining in
>>  the
>>  > working version after
>>  >
>>  > git read-tree -mu HEAD
>>  >
>>  > ?
>>
>>  I don't know. Maybe the bits are set, but then the remove operation
>>  fails (silently). I tried to reproduce on Linux without success.

I also tried to make a small repo to reproduce and failed.

I will try to strip and send ... might take a little while to get to the
point where it still happens but there's no work related stuff in there

Thanks again,

Martin
