From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v3 2/5] t4041, t4205, t6006, t7102: Don't hardcode tested
 encoding value
Date: Tue, 20 May 2014 10:41:03 +0400
Message-ID: <20140520064103.GA18358@ashu.dyn1.rarus.ru>
References: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com>
 <cover.1400513063.git.Alex.Crezoff@gmail.com>
 <b7914b89c94560d61e2cd3369d6e1402710457ee.1400513063.git.Alex.Crezoff@gmail.com>
 <20140520014931.GF180798@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 10:13:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmdji-0001yv-Vj
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 08:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbaETGlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 02:41:14 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:52659 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbaETGlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 02:41:12 -0400
Received: by mail-la0-f54.google.com with SMTP id pv20so21105lab.13
        for <git@vger.kernel.org>; Mon, 19 May 2014 23:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ec/+0LsiZMX1bowSpTUjvQQlfYZ8IpKgQBpSmGBa3mI=;
        b=KSuQ5bNOT07Kb4JtRa2AOy8vXXfhm8DhtRSmh1oeC6xBE5Vs1Uj2VZqRPK0ByUv0yx
         nOoZqWx+RwzFHWTfwBNPaI5vI4ykwyp1NJrXtEplhLo1jOEiREdfcWewkPex8illiuk+
         j9u/HFIfC59havYYRLgLmNnuBW+d+YcZtO8tbD0TZSvmidV4B3I48PbvtgXsSrifJrmV
         Xh36652TedIl7VKMa8N8w1dQpaixJR2L4rr0KhPOKIzWHxau8Z15swkQiPgDnl/LLbiv
         EdnnTHZfbBWrWXuxhB02UFGdHD/Lb9xrJcfM2IBwiSw/hJRxihPOFIYiBQaKo8YCFGNa
         YJbw==
X-Received: by 10.152.10.2 with SMTP id e2mr116863lab.76.1400568070570;
        Mon, 19 May 2014 23:41:10 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id o1sm19874650lbw.27.2014.05.19.23.41.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 23:41:09 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20140520014931.GF180798@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249647>

On Tue, May 20, 2014 at 01:49:31AM +0000, brian m. carlson wrote:
> On Mon, May 19, 2014 at 07:28:17PM +0400, Alexey Shumkin wrote:
> > The tested encoding is always available in a variable. Use it instead of
> > hardcoding. Also, to be in line with other tests use ISO8859-1
> > (uppercase) rather then iso8895-1.
> 
> You wrote "iso8895" when I think you meant "iso8859".
Oops!
Yes, you're right, I've meant iso8859.
> 
> -- 
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187



-- 
Alexey Shumkin
E-mail: Alex.Crezoff@gmail.com
ICQ: 118001447
Jabber (GoogleTalk): Alex.Crezoff@gmail.com
Skype: crezoff
