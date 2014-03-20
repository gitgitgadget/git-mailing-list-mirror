From: Kevin <ikke@ikke.info>
Subject: Re: Configuring a third-party git hook
Date: Thu, 20 Mar 2014 13:53:44 +0100
Message-ID: <CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Chris Angelico <rosuav@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 13:54:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQcU8-00087W-1s
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 13:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308AbaCTMyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 08:54:07 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:38746 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651AbaCTMyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 08:54:05 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so2119326ykq.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Y6j/tQvnDM7CrIYj9qRqf3DE/M9i/z/8h+d2cK8/6gA=;
        b=uX7XSdOI0/xnCL5BLO/lctT2yAiIwAwt+oJ0/N79kb78ETyHshJ/+PVggu7cBw2yHt
         KGG/PwtGnybVMzbCsZJkEg98VFbSc0h1I0hDjNVUABFugKXfWasvE40jLbCd3U0tPC/S
         t6AHVZZgMw5riWDyHCrwNtM17Kb9vJH0XIoo9ILkbe3ybEKhPV6CmfvoZ+v3KXcXtO2s
         nA11xKyXWJWdbRqReXpxWvvLQitR6uAtgAkohh+dH+319zVzzUkYYUZsFDw3eB7uHchu
         Q2AogjjgXrgbHQzd/5WMo5EHNk2hJewFhjqVgeeN8nH7K01TsbmTgBAqa5zNiWrxqUtw
         AW5A==
X-Received: by 10.236.89.3 with SMTP id b3mr34384822yhf.54.1395320044522; Thu,
 20 Mar 2014 05:54:04 -0700 (PDT)
Received: by 10.170.170.133 with HTTP; Thu, 20 Mar 2014 05:53:44 -0700 (PDT)
In-Reply-To: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
X-Google-Sender-Auth: _mK2Oi2X9cuDP2SnbnyGouIKt1M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244547>

On Wed, Mar 19, 2014 at 12:16 PM, Chris Angelico <rosuav@gmail.com> wrote:
> Two parts to the question, then. Firstly, is it acceptable to use 'git
> config' for a hook like this? And secondly, either: Is there a naming
> convention to follow? or, what alternative would you recommend?

1. I would say yes. git config is made to be extended and doesn't
require a config item to be known.
2. Namespacing the config items like you did is a good thing to do so
it won't interfere with other options.
