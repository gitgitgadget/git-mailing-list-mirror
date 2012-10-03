From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 3 Oct 2012 15:23:35 +0700
Message-ID: <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com> <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJKFi-0007UO-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab2JCIYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:24:09 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53442 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab2JCIYG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:24:06 -0400
Received: by ieak13 with SMTP id k13so16716022iea.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vDqyBSggUwOYskaCwLxlKhQx4c1h2ndWq3dmlpVaDtM=;
        b=sBjO++IS15P+plABz+N5rmI+ErcmyGz06ZhSpidXFTS06t4PdggOQH3Z/QGnKC3d2H
         52jWDFg7q+bgaJ1e4E/cT0Pub/Iz8FFvr/QHhmGbLBm3UKTc1Q5PnzHQzKr3Z22+ITTz
         sAmrY1CYP9147Ky2GB6ii2fZRDtpbpYw1In+E42DPDh/C+xwqlJctVDTl2/5wv+ztoM6
         Lb5wvavcSy9kpv/MCpJxF4XOdvtEcKqAE7Q7SIjCUEIVFLX2eEfWMe4oReJ8ul2mRbbQ
         0kBJt/tG+J0zPaaUvkp3ufDwKI+scTMW4+LlJNdgjO/Se5KWcv6lKbDFIEgDCrXpuhj7
         rHJw==
Received: by 10.50.220.129 with SMTP id pw1mr11394921igc.47.1349252646360;
 Wed, 03 Oct 2012 01:24:06 -0700 (PDT)
Received: by 10.64.23.197 with HTTP; Wed, 3 Oct 2012 01:23:35 -0700 (PDT)
In-Reply-To: <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206872>

On Wed, Oct 3, 2012 at 3:17 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Hi Duy,
>
> Nguyen Thai Ngoc Duy wrote:
>> Your patch is fine. I'm just thinking whether it's a good idea to add
>> a section in the end of each command's man page to list all relevant
>> config keys to that command, somewhat similar to "see also" section.
>> It may help finding useful config keys that otherwise hard to find.
>
> That sounds like a good idea.  Would you like to write the first patch
> (for git-push)?

I won't be able to do it in the next 4 hours. If you want a stab at
it, go ahead.
-- 
Duy
