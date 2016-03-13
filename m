From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] git-p4: fix AsciiDoc formatting
Date: Sun, 13 Mar 2016 18:46:36 +0100
Message-ID: <F0F4FA8A-EB42-4990-A90E-6C9245E0A9DE@gmail.com>
References: <1456830320-40411-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 13 18:46:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afA6J-00050F-98
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 18:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbcCMRqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 13:46:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34732 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbcCMRql convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Mar 2016 13:46:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id p65so11250706wmp.1
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/kVx+eK5OdYiBZUAouhVcj8Kj5+zpb355VJzhQAlpUg=;
        b=QJ4O8BXFBREmgVF6YWUeq9Kkx2bDBESKl1XEvfYBrBbznxgtMzoQDT8UecoO3rUbi0
         2dABnYyyEGKmhiRWeLh7VE33n58nC/jBPT54ANTLlkHTAb9QJzhY6mG7jX3DVSqeEbbG
         qUm6fFpsc/G2TUzZv5KwsbeJOCjEM5pPzw450x3wBmSijEeXTm0K6jOiPUrlJraAEuWJ
         La/9C70JFocKaAV7OcHxBZrTIbJUcn9QIANgTBU6BiuznQjEDbda94no0C3G3/q3moim
         fI48k7QjI2lF/7T/q6C2Hf7mu+O7Ts2khDFlxtFPsOaNoConkAg2OqBXZLtPIYOIU46k
         l1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/kVx+eK5OdYiBZUAouhVcj8Kj5+zpb355VJzhQAlpUg=;
        b=jWYcH4NrlP2ZMme5x0kqYzl/Byvg0zqfE7HDs4G/eiYES7kYoDd1D8igHx+XTyH0N/
         KCEfGL2zn8Dmj0EPI9jjXZ5Z8ex8Ejdkc+RVb3umzvpsZWZsbn5rQo8sBMAxMeu2/uPO
         ZKJLmhD1p5/dHt69gTv5HbVfbrn+eHVq+X2PtVuYR7f7lg2eguRwlekoVVVSeKHMVFW7
         r3MLekamyRwXE82iTki2Co4q7gLbIymkpDPsD+TfqBTdDT125I33yGK6s5k7VGHk0MtC
         F+2LFyHBOOaBCHelYHmpokoxK+lydM9w+fBQBFRf0IhDlaTw+r8bORz3SVzPr3rvKmV1
         uY6A==
X-Gm-Message-State: AD7BkJLClTH0FHZIV2cGJhDjloarvOPezqG9RuHgJDXdFSVeXn4XHxHGMNw2NitdgHqu/g==
X-Received: by 10.28.173.71 with SMTP id w68mr14267102wme.88.1457891200036;
        Sun, 13 Mar 2016 10:46:40 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA6B3.dip0.t-ipconnect.de. [80.139.166.179])
        by smtp.gmail.com with ESMTPSA id w133sm12431418wmd.3.2016.03.13.10.46.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Mar 2016 10:46:39 -0700 (PDT)
In-Reply-To: <1456830320-40411-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288757>


On 01 Mar 2016, at 12:05, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Noticed-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> Documentation/git-p4.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 738cfde..140fc12 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -528,7 +528,7 @@ git-p4.largeFileSystem::
> git config       git-p4.largeFileSystem GitLFS
> -------------
> +
> -	[1] https://git-lfs.github.com/
> +[1] https://git-lfs.github.com/
> 
> git-p4.largeFileExtensions::
> 	All files matching a file extension in the list will be processed
> --
> 2.5.1
> 

Is there any chance to get this in? The formatting error is quite obvious here:
https://git-scm.com/docs/git-p4

(while looking at this website I also noticed wrong double quotes around cp1252
which I will fix with a subsequent patch)

Thanks,
Lars