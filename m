From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Fri, 26 Feb 2016 10:30:15 +0100
Message-ID: <17AFC0E6-FC83-4BD4-9C19-43A6B9103866@gmail.com>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com> <CACsJy8CjOkNuEg=QRTATQLkYzMxpf5zryMXERZu6Zn59VDUB_Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:30:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZEjI-0004Az-Co
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 10:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbcBZJaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 04:30:20 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33880 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbcBZJaT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 04:30:19 -0500
Received: by mail-wm0-f43.google.com with SMTP id b205so64421500wmb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vlkxXD/9HGTGZJSVSAkd0esoVzqpV9UzRErom+90J5Q=;
        b=PDgYN11dWXV3VnFrVUkMcaKVqnKcTNvMNxl2iOcPQ6x56M6bSZjP3EQYF6sIydbqi5
         pZcXO+be0/+aoReX8hJKI3dQmb9YzdasCI0Vz6pPqueCJOEg5p3Flvr89dLSuKLIdEIW
         rV9HhRtY1a5ypbXybIYRkFrT0GM/J+4+26DUfLJUInaXFywmxgpkjmk8Deo+y5s8iZop
         42auyH9nriJwFTadiXGA4edXuEMLEtmdSwYJirezHftmewDBrcH82tfmYAKQvFR4EcQX
         HFLOrn0WUm3Qh2ZQ2oVVj53u+jJ/xlc80dOd1HDRogiMir93l4kj6QpC3vdqfhel9357
         gS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vlkxXD/9HGTGZJSVSAkd0esoVzqpV9UzRErom+90J5Q=;
        b=CgT3Nps+pepItWiefhCyUORqbwvBr80iYMuQqZv99HnZezEilT6VR1F+lYO/oC7JAA
         tJkELiIral4L3hZqFWMl1rW9+zYXxHV9Z7GHFWrqsPVhT0mYqj1GZkdVH7kgXnlxFAmi
         uLUMNAPiPWC+TQ7O1qUm1BKuEhHdoKGPYqVW3VWovwaZpK5DPcpw+ctKWDeE5SXzyogE
         nJkJw8L69BOVsTrNS+YrdL9YAcFCPTZUBR1jDXToFOTNjYOkev/L9nyOszmVuEy+MOXV
         T3KsvBGE9obCPi4Iu+KhcvInxC4JAACowV0fwP1pnOaYFs+VZ7ucHIV96vLK+fC+oUCM
         bM6w==
X-Gm-Message-State: AD7BkJIg5lkio8FEEYXdUa4C+GxFc98e0mldSsEjq3EbTjJCgvARyRNEbbRPLcFCDdBz5A==
X-Received: by 10.28.102.69 with SMTP id a66mr1965980wmc.8.1456479017763;
        Fri, 26 Feb 2016 01:30:17 -0800 (PST)
Received: from [10.32.249.46] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id i5sm11580825wjx.15.2016.02.26.01.30.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 01:30:17 -0800 (PST)
In-Reply-To: <CACsJy8CjOkNuEg=QRTATQLkYzMxpf5zryMXERZu6Zn59VDUB_Q@mail.gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287559>


> On 26 Feb 2016, at 10:26, Duy Nguyen <pclouds@gmail.com> wrote:
> 
> On Thu, Feb 25, 2016 at 3:42 PM,  <larsxschneider@gmail.com> wrote:
>> +ifdef DEVELOPER
>> +       CFLAGS +=       -Werror \
>> +                               -Wdeclaration-after-statement \
>> +                               -Wno-format-zero-length \
>> +                               -Wold-style-definition \
>> +                               -Woverflow \
>> +                               -Wpointer-arith \
>> +                               -Wstrict-prototypes \
>> +                               -Wunused \
>> +                               -Wvla
> 
> With the exception of $(SCRIPTS) in Makefile, I think we prefer to
> avoid \ and have one addition per statement
> 
I guessed that because I actually looked through the makefile to find how you deal with line 
brakes. The problem here was that this line gets really long and then it is hard to see what 
warnings are enabled.
Would you be OK with using \ for readability here?

Thanks,
Lars