From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Re: Pull is Evil
Date: Thu, 01 May 2014 18:28:36 -0500
Message-ID: <5362d8a4de7f_12fe14dd3104f@nysa.notmuch>
References: <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362664C.8040907@xiplink.com>
 <20140501175623.GY6227@odin.tremily.us>
 <53628CB1.8010302@xiplink.com>
 <20140501183008.GZ6227@odin.tremily.us>
 <5362ACD6.50505@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri May 02 01:39:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg0ZT-0006J7-E6
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbaEAXjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 19:39:15 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:37225 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaEAXjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 19:39:15 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so4366473oac.30
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=i+HJDkRRw3x2BgFwX4D28/XD0LtYzbe3XSmSSpjzr90=;
        b=q4By2Ro+Or30iOuWShP91qPxsJuB6jG0HYIxQ36rG0jE+b1/gsA+nWMZc3l6Osg8Z7
         PKL6fHPL0opySEfzpn5Cc1GlMem5FS/KI8gBfqMGycfmYmyFKGw2p2MCyqeEjq8wsKxO
         NWuFdF7ZcfBMtYOqwRvDlfJh6oQSxNJH9cwI2UCr5WBQ7AKVA3o3KefpGe6PRXIMe5A5
         NxKz6VZHWHYzlBddcMQFuVibMlwCHITK62w58TKEzRgcrecRBshktAE29POkhtKge0sH
         mvO0ItjRZVzNzCLfSLu8aZK7o0zbu7m8u7xJfzMICOixF1vbIED6HvIZ/YW9rpAn89GJ
         2Paw==
X-Received: by 10.182.22.18 with SMTP id z18mr12164362obe.42.1398987554658;
        Thu, 01 May 2014 16:39:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id su13sm122615953oeb.9.2014.05.01.16.39.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 16:39:13 -0700 (PDT)
In-Reply-To: <5362ACD6.50505@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247895>

Marc Branchaud wrote:
> So what benefit does "git pull" provide?

The same that 'hg update' provies: a way for the user fetch/pull the
latest changes and check them out into the working directory.

-- 
Felipe Contreras
