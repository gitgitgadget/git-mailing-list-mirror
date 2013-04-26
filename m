From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v2 6/9] remote-bzr: store converted URL
Date: Thu, 25 Apr 2013 20:58:16 -0400
Message-ID: <CAEBDL5XmrxV3SdtdyjJq=HxUqVcLCMz_Fcq9=POm=oaWtrO4LQ@mail.gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
	<1366934902-18704-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 02:58:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWzW-0001Kz-NL
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284Ab3DZA6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:58:18 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:51430 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011Ab3DZA6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:58:18 -0400
Received: by mail-we0-f180.google.com with SMTP id x43so3069386wey.25
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=LTZOtLja8y1PBdhfClPC0/f+2nm9BQY7roukh1dWOHY=;
        b=tzN3tkER9NqnnoAQe1RGG1kCNdZRfIZlRL1cpEjfRHNdDfDS56tIP55pLRl7mJyzgL
         RGT5cPz0otBQzIwixRfWG/6zUCEtsAxbTp4fiyegVM+OksGq2BDotV7QXlqR+WZk/YAl
         hA9Yf4z1PamA7NpJn/KrIH74mhB+uFtSJZqNdsUHnoiL2U7EzYsSKY/E7RONcRvtXpw+
         5ekucQi1O0NaBJOLDivzEH8vDHysayBulANLxjjQigc6OIDsrpgfwz2h8QoG/un6K8HP
         pfle3ptB1OH8iIYdDBpeKXsVqm5pFpxVUzXvNCzuhytRwJadWU5ZRotJlK4n4ZV1ml3z
         9QLg==
X-Received: by 10.180.24.65 with SMTP id s1mr956135wif.0.1366937896995; Thu,
 25 Apr 2013 17:58:16 -0700 (PDT)
Received: by 10.180.187.240 with HTTP; Thu, 25 Apr 2013 17:58:16 -0700 (PDT)
In-Reply-To: <1366934902-18704-7-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: uHgkFSpcQ-QBNQd_q-XI5-1UqWU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222480>

On Thu, Apr 25, 2013 at 8:08 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Mercurial might convert the URL to something more appropriate, like an
> absolute path. Lets store that instead of the original URL, which won't
> work from a different working directory if it's relative.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-bzr | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)


FWIW, it feels weird to be talking about Mercurial when you're
patching git-remote-bzr. :-)

-John
