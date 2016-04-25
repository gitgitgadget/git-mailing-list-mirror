From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 10:17:25 +0200
Message-ID: <E752A0BF-92D9-4BCF-ADD2-94F8E7BD66F2@gmail.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com> <vpq37qeovu4.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 25 10:17:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aubi3-0004At-Rx
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 10:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbcDYIRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 04:17:30 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36044 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbcDYIR3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 04:17:29 -0400
Received: by mail-wm0-f45.google.com with SMTP id v188so87960887wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TPjWx+8mg8X4K5NdZIRcT4n4XqTciAocn+ZPjIhXZrc=;
        b=wPiDc1Zp1rBEHG2sHROPUOS47RCjaDXhbmQxjsqp+09c6rB4wimkuNd2C6wKeg1ZSt
         WP7OqySA5GvOJF7qkmzKsznXP2FwYs5xosffug9eQ/KMeWa1NbA4/0Da4diLMjWchGyr
         dgmtenGgj2fj+FLqyQkH8CmaPn152Od0Nlf7Z5Nny4fIBmSCl4kWlbakZBCNOI401vgd
         mE6/3WIel7CI/jr8b9hCGFw1u8ihNFqoi8wHsh1e3ElEMHxGd9y0hDmJOtS4qoqx2n2+
         epmgWC7Bg1UHWQDxO2XvpOcZ10zz4t5buV6i6nJ/1q2CK5QBAhL9EoKVaRI/WMfxkZQN
         k/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TPjWx+8mg8X4K5NdZIRcT4n4XqTciAocn+ZPjIhXZrc=;
        b=j1zcHUkE2Tjc+TtA8FCT90+t0Al5CTN1kAeGbOTeCiIAhhoQC27Wi33MTcr6I9tbS+
         E4gxhWU6ZD/ENRbUPE6H5mT+hShRIgkGohgtN/PyzYZiLU0WuZFH+vKEnWZGFulNatnU
         pLRkgXukuvbMujt7PLxVfCp/uJL4y8sbk2BMDBpKgJA6UdZbo4rYsRfCgzsAxxO04Uox
         uvgYKD83hw6dQS0NcyzxAtaLNJPgoXtY7m+0qe17p9rZz7xvZbUqohHvw54G7zDOC+/C
         CgJ42S3PFg4ZOGbKt9zqf1GWmcoAAenYt+wQe0qdWUDbqi8I8U6w6nXtDHY+qVbQOkfF
         I5Vw==
X-Gm-Message-State: AOPr4FUDhV/BJcThKnwYavCSgV1qWEe/CqkZm4q8Y20jsJD0I51TJlXknj4i1pG4FQtYow==
X-Received: by 10.195.12.162 with SMTP id er2mr32885935wjd.39.1461572247811;
        Mon, 25 Apr 2016 01:17:27 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB4886.dip0.t-ipconnect.de. [93.219.72.134])
        by smtp.gmail.com with ESMTPSA id u3sm17422740wmg.15.2016.04.25.01.17.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 01:17:27 -0700 (PDT)
In-Reply-To: <vpq37qeovu4.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292456>


On 22 Apr 2016, at 11:07, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> larsxschneider@gmail.com writes:
> 
>> +      if [[ "$TRAVIS_OS_NAME" = linux ]] && [[ "$CC" = gcc ]];
> 
> [[ is a bashism, and doesn't bring anything here compared to the POSIX
> [ ... ], or "test" which is prefered in Git's source code.
OK! Thanks for the hint.


> The ; or the newline is not needed either.
Unfortunately it seems to be required. Travis CI generates a shell script
out of the yml file and I think they don't respect newlines or something...


> 
> I'd write
> 
> if test "$TRAVIS_OS_NAME" = linux && test "$CC" = gcc; then
> 
>> +          then
>> +          echo ""
>> +          echo "------------------------------------------------------------------------" &&
> 
> I usualy avoid "echo <something-starting-with-dash>" as I'm not sure how
> portable it is across variants of "echo". Maybe this one is portable
> enough, I don't know. Perhaps printf, or cat << EOF ...?
I am curious. Do you have an example on what platform echo "-something" 
could go wrong? I wasn't aware of such an issue.


> 
>> +          echo "$(tput setaf 2)Building documentation...$(tput sgr0)" &&
>> +          make --quiet doc
>> +      fi;
> 
> Nit: useless ;
Again, seems to be required by the Travis yml converter.


> I think it makes sense to do some lightweight checks after "make doc",
> rather than just check the return code. For example, check that a few
> generated files exist and are non-empty, like
> 
> test -s Documentation/git.html &&
> test -s Documentation/git.1
Great idea. Added to v2! The && is not necessary as Travis runs this script with "set -e".

Thanks,
Lars