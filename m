From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 08/12] MINGW: config.mak.uname allow using CURL for
 non-msysGit builds
Date: Mon, 28 Apr 2014 17:26:38 +0200
Message-ID: <CABPQNSaywg_1pdixaEz0DALCO6pvhjdMhGW09aC+LALMzZAz1w@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-9-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:27:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenSq-0007dd-0t
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbaD1P1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:27:21 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:51609 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932430AbaD1P1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:27:18 -0400
Received: by mail-ie0-f180.google.com with SMTP id at1so3302828iec.39
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zE4K1Q1imInwahmLUFn4E7zoxO/0g2FWSOW1tkflNsY=;
        b=RUruBbsmY0bmEH5oHwuWAYKfd2t21tkMnQlqnf4I0OUbWfhHkdNlPcNl6uc7Yc5OuI
         I+GIUtt1tzb/rv0pm87qO+LJuxrhXgcwWiXvimiCOpyvmPUQWbLm4wocjTCAFvh8OTl8
         gKkMivtqz+f/jtQ+BiVuVv/G3Exe6OpYiY+BO7WSzSQp7xaP57AUGPO5G8HvcjCKXY/U
         d4uh88CJ7SeRfjuWeMN5nYOaP/5cx8LVBgnXuKU8yhgYp6WL71MWNJJlE+P6mF8u+hKe
         vZCTUoT5lcteKpOg4DVSevOCG3RjR1CRzW2vEfVCGWHGGv6AMq5YdNO/w9YPLyhyGVx+
         U9eg==
X-Received: by 10.42.204.197 with SMTP id fn5mr1388681icb.95.1398698838099;
 Mon, 28 Apr 2014 08:27:18 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:26:38 -0700 (PDT)
In-Reply-To: <1398693097-24651-9-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247364>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> Also, fix `warning: passing argument 2 of 'mingw_main' from
> incompatible pointer type` in http-fetch.c and remote-curl.c.

These seems completely unrelated, perhaps it should be split in two?
