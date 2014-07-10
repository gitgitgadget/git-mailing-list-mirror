From: David Turner <dturner@twopensource.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 13:33:58 -0700
Organization: Twitter
Message-ID: <1405024438.3775.3.camel@stross>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:34:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5L2l-00028J-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbaGJUeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:34:06 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:52901 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbaGJUeC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:34:02 -0400
Received: by mail-qa0-f43.google.com with SMTP id w8so112994qac.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 13:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=t16orF1OSVIRafDS+yaQyVhY4Eb2iTIHIK2R9NukMSc=;
        b=BGiwFibyoDvzdIpMrCFVe3pJudrLQ38bNEKkdV29FywCadNf5U5mBgq0TrCuSQzjGe
         cjNiAjWj2PnUXP8SSItbn2GlQIyId7F5s+NZufGqEl9vsAUR6MpeIcc6vyi/0ZnjZ+ru
         0qyoKHenJehyQrVHMj8mdWVYWCNIMTO1m147fZBdBo5ULyBqWZXsW6gQx6SwvexWeTkw
         F0fl1a2XPC6aS5jSXsSs3UNBi9/pnxj1UHgiRHbankG/BYuax7MYhJ0g3R3ABthvujnJ
         w8OFZ2s1I4SGMaTVUBQRGVwRN23wKc2CisoUj996Y7DEfv9O+266GINfMFvgB7qjEOeJ
         g82g==
X-Gm-Message-State: ALoCoQloPTsuEh7Kp92/Coeae9YrC68Y5s8UULPsp+Wmwp+pCe+oR6pfvVBlSTvZlZeUE6XesIOE
X-Received: by 10.224.13.4 with SMTP id z4mr77377150qaz.51.1405024441632;
        Thu, 10 Jul 2014 13:34:01 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id i44sm224725qgd.13.2014.07.10.13.34.00
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 13:34:00 -0700 (PDT)
In-Reply-To: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253208>

On Thu, 2014-07-10 at 21:59 +0200, Tuncer Ayaz wrote:
> The changes in 745224e0 don't seem to build here with gcc-4.9 on
> linux x64_64. Any idea what's wrong?
>
>     CC credential-store.o
> In file included from /usr/lib/.../xmmintrin.h:31:0,

What's in the ...?

Because if you're using headers from a different version of gcc, that
might explain it.
