From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 20:09:45 +0200
Message-ID: <212160AC-4B30-4CFC-9F76-A1C23A102A5C@gmail.com>
References: <1282135226.24584.92.camel@wpalmer.simply-domain> <2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com> <1282140854.24584.112.camel@wpalmer.simply-domain> <AANLkTik8RGR4OTeZYsttyBtiywGU7Wtz3gQsTjoqAQPD@mail.gmail.com> <1282149456.24584.114.camel@wpalmer.simply-domain>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Berg <merlin66b@gmail.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 20:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oln5I-0006mx-Oo
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 20:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab0HRSJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 14:09:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64985 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0HRSJv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 14:09:51 -0400
Received: by ewy23 with SMTP id 23so599768ewy.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=nOh/6IThtwUZ4DZDLX0geVX0+Mn5kD+ZmvKdyQe8FPQ=;
        b=GWXkSoUptoRLQxOMquw3ZZfLnxr19auNfRch4LRf5QAE0J/GBguM0yq0jzr44ZTybR
         sOzEZ0boq/HelcoiUbMJS4PO1vh1mHzOFVSkILST+72NqZWJkvjfxDoJYqOZhJl2CqPZ
         ETih0sfLuBiaawwMvVo8vjwXyYCXtijnakPtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=c0iIWn8Mj1WPtfZJ/eeEYLJS5LrYKYHAMjrJUq5VlhWw+pn8hz1ympjlryvsR1jziw
         t7WXYEBVHWAxx/48Gt1miaRiVF2VcW7Iip25e1hQud+zLktQIS2IJLmVwdBVSvZrsqRd
         stmzQmW8HWJN7oxRKs43DF1ylpzugL094VGkI=
Received: by 10.213.56.17 with SMTP id w17mr531799ebg.76.1282154989287;
        Wed, 18 Aug 2010 11:09:49 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v59sm948455eeh.10.2010.08.18.11.09.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 11:09:48 -0700 (PDT)
In-Reply-To: <1282149456.24584.114.camel@wpalmer.simply-domain>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153870>

On 18. aug. 2010, at 18.37, Will Palmer wrote:

[...]

> .git/info/attributes
> * -crlf
> 
> seems to be what I was looking for! Thank you.

Excellent!  Thanks for testing, and thanks to Thomas for the suggestion.

> Though I very much think the way git currently acts in this situation is
> quite inexcusably broken.

It's certainly not ideal, but the old behaviour was broken in an arguably more insidious way in that only people with autocrlf enabled saw the problem.  At least this way repository owners will see it themselves as they upgrade to newer versions of git, and (hopefully) fix it at the source.

In the meantime, I'm glad that .git/info/attributes let you work around the problem.

- Eyvind
