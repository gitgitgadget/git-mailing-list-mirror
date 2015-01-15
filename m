From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] string-list: remove print_string_list from string-list's API
Date: Fri, 16 Jan 2015 00:00:13 +0600
Message-ID: <CANCZXo7hn2wAqtfTNFBiKi_+K6O+vQQAh6pwAcRxjzuetL7+fg@mail.gmail.com>
References: <1421343725-3973-1-git-send-email-kuleshovmail@gmail.com>
	<CAPc5daVSMRXiocYAVuWHMmDPmR661cNevaG3RgJC5zyda_Nnig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:00:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoiT-0001IN-8r
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 19:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbbAOSAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 13:00:14 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:58150 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbbAOSAN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 13:00:13 -0500
Received: by mail-ob0-f171.google.com with SMTP id va2so4861889obc.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=9m+p+akTVq0tFjuUyOXg0h8uXkFcL2K9x/Nkj7KN9uA=;
        b=FirRNPT4ja1Lg1zewPAOv/i3/ZZ7Irj81mQkC0+iahTulPgdF4BA7ysOEDVYBKGQlY
         nuyjWrBXqT0c2FuBqhUEjcmSW/MlWxzOvcVASMnORlYoigQFiK9TMqyFninO894zeU1R
         le3m5eazM4ceH/TIsMzhEuLyErsluNMI0WkQD9R+lrbhQQMB+FnO+01ma/GBjkqi3vYo
         pa7PPS8FzzlxnjKuzND4C7CCJi8XAo3Trr3KpEr340xAIsyve/xbAhxbo3pqeGfhcmrN
         GYRmGLXUayp7bQNZVt7HJb3dAxwTYi7h04bdTJB8wrBK03DiFiiCb/AS8DS+wpHq/xr3
         /wPA==
X-Received: by 10.60.145.199 with SMTP id sw7mr6769958oeb.74.1421344813142;
 Thu, 15 Jan 2015 10:00:13 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Thu, 15 Jan 2015 10:00:13 -0800 (PST)
In-Reply-To: <CAPc5daVSMRXiocYAVuWHMmDPmR661cNevaG3RgJC5zyda_Nnig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262494>

Maybe need to add comments for print_string_list, for preventing
patches like this?

2015-01-15 23:56 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> On Thu, Jan 15, 2015 at 9:42 AM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> print_string_list routine has no callers anywhere.
>>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>
> http://thread.gmane.org/gmane.comp.version-control.git/262439



-- 
_________________________
0xAX
