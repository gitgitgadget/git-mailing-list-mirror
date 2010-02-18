From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Using trees for metatagging
Date: Thu, 18 Feb 2010 18:06:42 -0500
Message-ID: <32541b131002181506v1d28526cpf8491994868272af@mail.gmail.com>
References: <20100218041240.GA4127@lapse.rw.madduck.net> <201002182200.09100.johan@herland.net> 
	<20100218225758.GL9756@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:07:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiFSp-0006eI-Tt
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 00:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab0BRXHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 18:07:13 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:37435 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0BRXHM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 18:07:12 -0500
Received: by ywh35 with SMTP id 35so1545126ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=d3VszAOKVP01ZJY1FeG05SrYS3WwK+MTkWKv5vcm1DE=;
        b=bVKWJKmwrURZtJo7OkZ6rBfPeWEq32fonTugXDzix8gs5YnA308AzbPhWL37wjqh/p
         d9LwsxZYvkTwpXDX99m/tWm9tz/BaylOGqFpWZviHjOXokTuLtV+icolg2MPbK7hyHJd
         NXnMl7/H4koVmFXLjWE58b7KluH9qwEKPwG00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=u8chPRVlVnx4isqVZr5EVxM9JOLkWCDeDq7XeKUBB8eN+Z2MCxivapkEIJK4yMT3i8
         WbJjmS7D0m5awfOLhatPizuyWm/h3gwo/XuuPsRGZNaeocFT2hRYt8Ecus7EEcXtsfhw
         bfq9BF0OWJwos4aLOstGpTw+BmuRpvWPw4YSI=
Received: by 10.151.29.8 with SMTP id g8mr2281321ybj.74.1266534422585; Thu, 18 
	Feb 2010 15:07:02 -0800 (PST)
In-Reply-To: <20100218225758.GL9756@lapse.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140391>

On Thu, Feb 18, 2010 at 5:57 PM, martin f krafft <madduck@madduck.net> wrote:
> I am aware of notes, but so far I stayed away from them, simply
> because it seems hackish to represent tag trees as text when dealing
> with a tool that is essentially all about trees and refs.

I think you're using the wrong definition of hacky vs. elegant.  A
"tree" is really just a file containing a list of objects.  A "ref" is
just a file that contains an object id.

So checking in a file that contains a list of object ids (or
filenames) is perfectly appropriate.

Have fun,

Avery
