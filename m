From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH v2 42/44] ruby: remove GIT_PAGER from environment
Date: Sun, 29 Sep 2013 01:27:26 +0200
Message-ID: <524765DE.9030009@googlemail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-43-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 01:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ3vN-0007gJ-A9
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 01:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222Ab3I1X1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 19:27:31 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:39485 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184Ab3I1X13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 19:27:29 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so1886938eek.22
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JL+5o+Ot3Azz426/Bgs0f+bUkpY01mBQBEF66Aiz5bU=;
        b=jn+jnnqj5imyGiiAJeIqzcF9ySi06RpLC3awo2yIefPZwI6vvX9OtkcwVKXTFJhFRw
         DgRAjEWPHFWFppv6DIl8HSK9JRwP3iXDaEb53ZxhaXCUaKxfMIcoEyuMCnrwRT+gHGC8
         kc3oOKMsrOM6JlUx8+Ze8ypWQUNC9k5QHlGTEl9OEYe94qS8EbOkUBHokrw0IWDztxcr
         sN25UpaW+Ik5y7w3dHkAdklOu29teNOy1OFlKxZwuadaXAyIogfwGJ13KZvvExBrHlmB
         JF7F7gZeO4nc3MMOTuigh2Y7doVYQZBLYpS+pJuJCaUT3B/kdihOTwJFAZWtSDeNDTEU
         pf9g==
X-Received: by 10.14.241.74 with SMTP id f50mr23488430eer.29.1380410848183;
        Sat, 28 Sep 2013 16:27:28 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i1sm32945428eeg.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 16:27:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1380405849-13000-43-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235570>

On 09/29/2013 12:04 AM, Felipe Contreras wrote:
> We are not calling any git commands any more.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-request-pull.rb | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/git-request-pull.rb b/git-request-pull.rb
> index fde8d1a..941ff72 100755
> --- a/git-request-pull.rb
> +++ b/git-request-pull.rb
> @@ -2,8 +2,6 @@
>  
>  require 'date'
>  
> -ENV['GIT_PAGER'] =
> -
>  patch = nil
>  
>  def usage
> 

Could this be squashed into the patch introducing the ENV?
(I assume that patch is among the 44 patches?)

Thanks,
Stefan
