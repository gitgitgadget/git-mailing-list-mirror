From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 00:15:55 -0500
Message-ID: <CAMP44s3qn2vTQ1oDnAe6m5AzZ_tAK0fe1=-nN=_=fv7TXGnMbw@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	<20130609174049.GA1039@sigill.intra.peff.net>
	<CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
	<20130609181002.GC810@sigill.intra.peff.net>
	<CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com>
	<CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com>
	<51B4F6CA.8020807@alum.mit.edu>
	<51B51256.5060602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 07:16:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UluSX-00064J-Pj
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab3FJFP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:15:58 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:54956 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3FJFP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:15:57 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so4843717lbv.13
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 22:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oNOA1ssMvutIbIdt1dwUO+hhvx3a2pDC7j0vJUj8tQI=;
        b=B2rVt6dxGcojw9tfSJcw6YYP5LV3Gs4mHe8NrB+yL5Vw4iNwODRWmTUzKVzhmKoa6G
         g7+vZU7LjRY3BBnL9bmFhnprYIG6SP46RSDF+9VzJ2L4WM+HONlJ7tuqyUeqAqVxEJlB
         TaNylOxuhesjFCplhmiuKZHMoOUhQWetAc4MNnl+85ph4dcTCH2Gx1PEPamGEyN+wnCy
         VYMr/BoOOnX5b2krpo0rY5fW8ZpwKbO/aoPLp2pagNAzBb5nPvz//2Qoe4oer1RmS36L
         GlL9YfuC+rYAL1/F/GuKU1aRtU1CxlYbSd+HsHPa63mlBSC+i7BhXStuYbZfSLtx1YIe
         RjKg==
X-Received: by 10.112.16.163 with SMTP id h3mr5684599lbd.85.1370841355847;
 Sun, 09 Jun 2013 22:15:55 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 22:15:55 -0700 (PDT)
In-Reply-To: <51B51256.5060602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227236>

On Sun, Jun 9, 2013 at 6:40 PM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:

>   I do accuse Felipe's *attitude* to bring on and nourish such
>   unpleasantness toxicity.  His technical merits and the possible
>   qualities of his patches do *nothing* to remove or quell such
>   issues.

How convenient to accuse me and not the others who have as much fault
if not more. You need two sides to have an argument.

The difference is; I did actually send code. Code that is good, code
that works, and code that users need.

-- 
Felipe Contreras
