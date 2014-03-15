From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH] add: Use struct argv_array in run_add_interactive()
Date: Sat, 15 Mar 2014 13:41:57 +0100
Message-ID: <53244A95.8050308@gmail.com>
References: <53243620.8080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 13:42:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOnuk-0001Zv-AP
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 13:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbaCOMmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 08:42:04 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:62123 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495AbaCOMmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 08:42:03 -0400
Received: by mail-lb0-f181.google.com with SMTP id c11so2456594lbj.26
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=RdEMi2UodcCGdaHHD/vfwkuyw6HUVRaW5aUp+Tv2axI=;
        b=eIbSGZNTMLO9OYOxJJXEVQxEEMN1NG56ZY8sv8cGnsRCCHo6kC9EVPr/XFnOUdiWPf
         br3ZdhQ4eT1qrB8ELApK5lJtpNaHlZXFKlyCrpEMhM3pw1+IAVlesXfZuUJdZpTFiIZK
         HKNkutisyfGxgp4F1dZDTier2lDZVyIBY5v/O6z5pj/29xbLp0H5kwW8GHwmeUQC9HDa
         RB9fldUjhODbVMiNwe9ePVj+55Z6roRE21pJLiPYyBEJqU9qkM2kcyTuB8iqZoxCpdKI
         7KW6Y8UgD62HQ17YMjvWxUvbnHcLgEYHjy8ViIcCcyq09pePOvGKbpzWNK98Kp8cv3dR
         wrUw==
X-Received: by 10.152.87.71 with SMTP id v7mr9578578laz.10.1394887321500;
        Sat, 15 Mar 2014 05:42:01 -0700 (PDT)
Received: from chra.localdomain (c80-217-227-248.bredband.comhem.se. [80.217.227.248])
        by mx.google.com with ESMTPSA id lm5sm6079523lac.13.2014.03.15.05.41.59
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Mar 2014 05:42:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <53243620.8080401@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244154>

On 03/15/2014 12:14 PM, Fabian Ruch wrote:
> run_add_interactive() in builtin/add.c manually computes array bounds
> and allocates a static args array to build the add--interactive command
> line, which is error-prone. Use the argv-array helper functions instead.
> 
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  builtin/add.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

I should mention that I am applying to this year's edition of Google's
Summer of Code.
