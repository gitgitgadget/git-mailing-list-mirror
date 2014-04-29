From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 10/12] MINGW: config.mak.uname: drop USE_NED_ALLOCATOR
Date: Tue, 29 Apr 2014 02:59:19 -0500
Message-ID: <535f5bd771034_45e485b30863@nysa.notmuch>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-11-git-send-email-marat@slonopotamus.org>
 <CABPQNSZD5jz1A8=zQvU4dYvNb-5M+TV50Uj+oVbWJs3YWBytHw@mail.gmail.com>
 <20140429074814.GA23421@seldon>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 10:10:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf372-0004uC-Dv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 10:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170AbaD2IJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 04:09:56 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:54205 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010AbaD2IJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 04:09:54 -0400
Received: by mail-oa0-f50.google.com with SMTP id i11so8463061oag.37
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 01:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GosRUr3DsAYBWsSKwcRMos1eznw7AyFIZ1vdqbUVoJw=;
        b=E8FnTwU1iDn56yuNwB5iwfxvn4eS0pXvCS7AHQYBvwYXEKzT5swfSfeyKYEcgR9hGZ
         gd7bW3chwA6fDain8mYfx0wr5+9dK+XJwCG04RxDmiQBqU05/UPe8l8AZzMEh5/Q/FUg
         s68OQStCURQRd9TeXZcuAaSMVg3AaZmtFoqET0Pcs0aO7Eo0a6KPlvZ7cYTek20YjD4o
         xpaMCcPqYDRALjp4s3YZEFeT1HoYTB1+yJ9CpdhOpeuz15bht/YwymgD9nk0SGu7yBUg
         yv79RjL+4lLnNK+sCwV7z4p0ebuf+/K7gfrTZkFcSm7X1ELxfz/c932adjeoBSRxcxKE
         pm/Q==
X-Received: by 10.60.134.137 with SMTP id pk9mr26236066oeb.40.1398758993866;
        Tue, 29 Apr 2014 01:09:53 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm42477259obc.22.2014.04.29.01.09.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 01:09:52 -0700 (PDT)
In-Reply-To: <20140429074814.GA23421@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247529>

Marat Radchenko wrote:

> We need to make a decision: drop nedalloc, update nedalloc to later release,
> patch nedalloc to make it work under MinGW-W64 or disable nedalloc under
> MinGW-W64 (still leaving it enabled under MinGW).

I say go for the latter (disable for mingw-264). It can be fixed later, and in
the meantime nobody gets affected negatively.

-- 
Felipe Contreras
