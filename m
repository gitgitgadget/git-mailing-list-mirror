From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 04 Feb 2016 15:25:35 -0500
Organization: Twitter
Message-ID: <1454617535.5545.10.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1454443734.5545.1.camel@twopensource.com>
	 <CACsJy8Cau0mpz8zVjvz7RPt-s=xmaCCmz0p8OCup9-Q1MnwWCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 21:25:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRQTG-0002dI-HE
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 21:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbcBDUZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 15:25:38 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34564 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbcBDUZh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 15:25:37 -0500
Received: by mail-qg0-f50.google.com with SMTP id u30so51738510qge.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 12:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=LbAHeqhry3kvFMvUu1Pt0JPC4K1A+nolBQ48M1r8zgI=;
        b=p+FsWhWMoiZXKksiPfrYS3UeDX+iLegozZWc8qCJ7XZeHNzoP5LSK5/KrAw2ClZf1m
         DyQIkW3pUCSspyvDviXPfOW/ZzWQbrnaq6dnITLByk+l0IebHFzmusU8TY8rLWer4tLf
         2IMDOcmH03BNShpNlXf+FJjCrJlQUWCUe2phHi+ccHhkFZ1XHzlGgDarkNYd1bL6eisq
         OYo+7oDODbQR8XV+txd84V/fX7EPZl8qLBEohZ4OI81Jy/NCw2iTgMHyqlUXv5fFz2en
         F1uoQ74umZ7Hm+iLS33OmcjOzppiM0bB+4mghLgi1Ntz2Ylmd6xcNjEcMOXyTzuDuWko
         eclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=LbAHeqhry3kvFMvUu1Pt0JPC4K1A+nolBQ48M1r8zgI=;
        b=IRXK3YnD/+KQ/zER/2LOgkIulAcWXlORG23hGsXmKsDHMv+/XIR59KnGMbnjC6V9L+
         3ABnLm3RcMyEQSBkfYQFN2D33/Wx+2T+B8IKTWmVykXYRWsiXHAR/KFcs9x46xQPuxS9
         i+lH0iGqFM2WV5hqvKH0U8wcglo7YBZRJPB+XwtYqeO/CrOiFEqPs3RfZop5IS1joZi2
         Ng5FqKtq4yqCef3tf5UwKUgho9VmP1/47Q9XMlEhMg+qPt0jkZCuEs2gYXwM9CnMZknL
         lsTJSiXPZs/XQgdcDEbzrHzN/PF7TrYTpjjpppxpvHLCNPnwpaaYceqGOuuvRE9IEph8
         FI5g==
X-Gm-Message-State: AG10YOTh+MJKKolmHsOR3mMNvc4jllXXCIZGjxdkqLlUffTTEmiiPbTVOgf8Ty8QUWiw/w==
X-Received: by 10.140.227.9 with SMTP id x9mr12476022qhb.46.1454617536993;
        Thu, 04 Feb 2016 12:25:36 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z10sm6005002qhz.5.2016.02.04.12.25.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 12:25:36 -0800 (PST)
In-Reply-To: <CACsJy8Cau0mpz8zVjvz7RPt-s=xmaCCmz0p8OCup9-Q1MnwWCQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285491>

On Thu, 2016-02-04 at 18:42 +0700, Duy Nguyen wrote:
> On Wed, Feb 3, 2016 at 3:08 AM, David Turner <
> dturner@twopensource.com> wrote:
> > Are there any more reviews on this?  I do have some changes from
> > this
> > set, but they're pretty minor so I don't want to post a new one
> > (unless
> > folks would rather see those changes before reviewing).  Let me
> > know.
> 
> Last note. Since this is new code, maybe you can wrap translatable
> strings with _(), basically any visible string that machines do not
> need to recognize.

Fixed, thanks. 
