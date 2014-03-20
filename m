From: Chris Angelico <rosuav@gmail.com>
Subject: Re: Configuring a third-party git hook
Date: Fri, 21 Mar 2014 03:51:16 +1100
Message-ID: <CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	<CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:51:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgBe-0005yU-2W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 17:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbaCTQvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 12:51:18 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40848 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbaCTQvR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 12:51:17 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so1193977pab.40
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LsAP9pkPydGv5edzU8Fn+GgiUeBfd3zFmQ9MKZnHK4o=;
        b=KsC4kn0skjeha4ugbERq+AQgh6kuUXuoO8pX3Vw3DGHdonHxULTTF/k+fhqljc2Kr6
         y0+y0NmntlIvk5OoJy0M7ozF1J5L8oFOM8K4NfYNQZkQX4n0oK4vC2GBBx4VQNazKrfB
         p8kB4kIJBzqeF+0lhC67hABTNM49drr5C9ueF7yX0kxOU35p2pg24blUqW3DaDPSauVu
         hZ5++1EY0go6abIisyCS+J9AJGle7Ud10EzhTOxZFGW6SThmHsRNEv8e0Lgeg8qM26EC
         HW8TNN70EvFasWpjHf6RTuJwvHok28xtOj6thlLinSKhsw2PX+qdL1pN2bBHtuSB7biw
         n9Jg==
X-Received: by 10.68.197.36 with SMTP id ir4mr47158514pbc.46.1395334276906;
 Thu, 20 Mar 2014 09:51:16 -0700 (PDT)
Received: by 10.68.33.7 with HTTP; Thu, 20 Mar 2014 09:51:16 -0700 (PDT)
In-Reply-To: <CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244556>

On Thu, Mar 20, 2014 at 11:53 PM, Kevin <ikke@ikke.info> wrote:
> On Wed, Mar 19, 2014 at 12:16 PM, Chris Angelico <rosuav@gmail.com> wrote:
>> Two parts to the question, then. Firstly, is it acceptable to use 'git
>> config' for a hook like this? And secondly, either: Is there a naming
>> convention to follow? or, what alternative would you recommend?
>
> 1. I would say yes. git config is made to be extended and doesn't
> require a config item to be known.
> 2. Namespacing the config items like you did is a good thing to do so
> it won't interfere with other options.

Excellent! Thank you.

Is this documented anywhere? The git config man page says to look to
other git man pages:

https://www.kernel.org/pub/software/scm/git/docs/git-config.html#_variables

A comment there to the effect that "Third party tools may also define
their own variables" or something would make it clear that this is the
intention.

ChrisA
