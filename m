From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Wed, 19 Mar 2014 18:03:41 +0700
Message-ID: <CACsJy8BVmc0K5Rdr_putTQM5Hs2agizyW8cxAPFLb0LnXntG7Q@mail.gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com> <20140318045050.GB8240@sigill.intra.peff.net>
 <CACsJy8CU3JyL74OuurjDr5-FHmBOCRahtXukukCqGx1cTdjvMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 12:04:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQEIE-0003p8-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 12:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759086AbaCSLEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 07:04:14 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55556 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759053AbaCSLEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 07:04:12 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so8374477qae.33
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TBpETjR+w/SrrDQq/un+w9j1tMq/6Thgcbwx4edai40=;
        b=rfqXvEa7Q5ZuJqxP2qvSYihPt0OBQ2b6SU7jlSVS3mvSw9JSYYfFogBjnLwZwKbKRR
         kdLHFyHIYe1UR8xRHlAUBmpCBLlwEvUjc/aFRgnjSBDhE1iLyRAK6y1ya1vxyd1I3Sg0
         yO4V4qVKFqyXdrqfL6gnikaRVuiBesy4uFwWEQZbrMhGwF5q6sIMoM2GHV2xb9ibaRUR
         h+HF9LCWRp08dk6Pfwo1Rh5oyOMbkBLtnt0vRquv2oYKvdxLdwXq+LwrIaBbgLPZFxZ9
         5YXVvK85bH3O1gC4Of0Lo9UY5+YBC2Dim0oiy8cQNUo6dV0SIds4DTzD8fcfQ8jl9dsK
         Wtag==
X-Received: by 10.140.84.40 with SMTP id k37mr1634536qgd.98.1395227051774;
 Wed, 19 Mar 2014 04:04:11 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Wed, 19 Mar 2014 04:03:41 -0700 (PDT)
In-Reply-To: <CACsJy8CU3JyL74OuurjDr5-FHmBOCRahtXukukCqGx1cTdjvMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244432>

On Tue, Mar 18, 2014 at 12:00 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>             size  time
>>> old aggr.   36MB  5m51
>>> new aggr.   37MB  6m13
>>> repack -adf 48MB  1m12
>>
>> I am not clear on what these times mean. It looks like the new code is
>> slower _and_ bigger. Can you explain them?
>
> That's right :) The upside is faster operations, which is complely
> missed here. The good thing from those numbers is pack size does not
> increase much (the upper limit would be repack -adf with default
> settings).

Something is not right. The performance numbers are against me. Still looking..
-- 
Duy
