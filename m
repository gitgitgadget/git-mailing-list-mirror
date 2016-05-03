From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] Documentation: add setup instructions for Travis CI
Date: Tue, 3 May 2016 10:09:26 +0200
Message-ID: <277F4546-5552-455A-B3F5-C536618643E9@gmail.com>
References: <E3568F7F-1C20-4B9F-BDF1-94A9DA08D5F7@gmail.com> <1462176732-5163-1-git-send-email-larsxschneider@gmail.com> <vpqwpncq1zx.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 03 10:09:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axVOj-0006H3-2X
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbcECIJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:09:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36532 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbcECIJa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:09:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so2321932wmw.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sc2Pgz4EHWKXOfkjTdgENIef5AubCMBggcZ8TPsWYZk=;
        b=hQ6HQoSMY5b+xmizlRC2xWXhOInhnufoSKnrazHsBQHvpKddlCOY/CXfiaBj16qg0R
         RCfU/ao80BOuHX4dAy0DtZGvpNe9IbHmUkCzFbXn4UyH2WMdVKy/90L+XBf4B9EZnmJz
         bq0zNYyAPNPgW5M9a/rHUD+NqKoMdfZn9c3Ffkk4k9yJUk9pJoSn1aoesUzX5uHqmPCO
         qxbR/edM6mDWplQrLwC8jGubc47pXGpAkx+Vq3MXgV3zd6weQRbxUf9vAsal1l6i9q5Z
         SgPeN0z/ycv4oWUp5AGlN/YIBjOYMWGbF4TzQKf/avjx7+JjfnM2JYGTV+Hl21sgnkGm
         uFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Sc2Pgz4EHWKXOfkjTdgENIef5AubCMBggcZ8TPsWYZk=;
        b=eMK5S65yR9zFCAJVh72eJSvo9h/vuXKPJLV74lCeD/Z4T7/jPkMLvYq3nmQqy3sXgZ
         eBb9e5VLEqW4sAgXJxpkTD60H1lFsMp9VM/IpzUatKmnxZlw+KRP5PZVwxer3YkJGM2T
         03rRqjnuwonXSayWVpbv1e56xVFDrxTucciFaH788TCLFqxCRbND+4Dpkk+avme52VCX
         mcfXaWIAJLKx3yrYGYVep0GQ4kBf3/IEsFSAZkksqyyefRDaIpTDafyMGd9hGE/MU/hL
         vgralgCVyGOuF4mWvGvj4o+4CuWGb/0ZMYNBHTGJ+itF1YTRe/JdI/thwbL0tS794uf7
         ivYA==
X-Gm-Message-State: AOPr4FX3H4hZ9koT/ERjpGQngVD/PqyrXpBcMvgoSlYALY2VoGWWm3ZnIev+egH/m5fmGA==
X-Received: by 10.28.168.133 with SMTP id r127mr1830011wme.9.1462262968437;
        Tue, 03 May 2016 01:09:28 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB77BE.dip0.t-ipconnect.de. [93.219.119.190])
        by smtp.gmail.com with ESMTPSA id v143sm23077243wmv.4.2016.05.03.01.09.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 May 2016 01:09:27 -0700 (PDT)
In-Reply-To: <vpqwpncq1zx.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293331>


On 02 May 2016, at 10:48, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> larsxschneider@gmail.com writes:
> 
>> +on open source projects), you can use their Travis CI integration to
>> +test your changes on Linux, Mac, and (hopefully soon) Windows.  See
> 
> Nit: I'd write Linux, Mac (and hopefully soon Windows). Doesn't deserve
> a reroll IHMO.
> 
> Other than that, the patch looks good to me.
This is fine with me. Thanks for the review!

- Lars
