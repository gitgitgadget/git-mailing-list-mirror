From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: Improved autocrlf description in RelNotes-1.7.2.txt
Date: Fri, 2 Jul 2010 10:23:29 +0200
Message-ID: <536994E0-658A-4F25-A868-C14DB22383B3@gmail.com>
References: <20100702075844.GA14583@pvv.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri Jul 02 10:23:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUbXB-0001pv-71
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 10:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab0GBIXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 04:23:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46812 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab0GBIXd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 04:23:33 -0400
Received: by wyf23 with SMTP id 23so1072553wyf.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=osuDCgIDYOQjZB2AsUZVfWAAJcc7s5OaNTIIwb+csBc=;
        b=aBr2JwGgMRvdO/tjSNHCZwMQzr1fqCr4UvhOVelIItxKAt6QAauaKfeQK1HkeO/TuL
         i4FNGlw8C1aDbNF/AOdKZkkLzbw0f+7f3vjulCOCVUtRVlHiG4eZEkgFoqho1xNZZbq5
         mOaXJHSQpYlLW50z5LniGYRScUQbI+HYhPsMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=llz4jfR2knElox7CBJKqdEu0yR8YR2Q4UfJVXu2U+v2MAEN2TuGLCMGNVT23cvtKIH
         KSi+Uu0hlXVvUuqBKIiB8r7juAjTVvEQopQlGSZPUzFw3+jT4O4SLxyjpvdGfhFrXxHO
         mg+5F0P25jqeagNewtUZUnwr/mpU5qATJjNHQ=
Received: by 10.213.33.199 with SMTP id i7mr3676416ebd.5.1278059011779;
        Fri, 02 Jul 2010 01:23:31 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id a48sm3374908eei.12.2010.07.02.01.23.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 01:23:31 -0700 (PDT)
In-Reply-To: <20100702075844.GA14583@pvv.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150116>

On 2. juli 2010, at 09.58, Finn Arne Gangstad wrote:

> I think RelNotes should be rewritten along these lines..

[...]

> + * core.eol configuration and text/eol attributes are the new way to control
> +   the end of line conventions for files in the working tree.

Add something like "The old crlf attribute is now an alias of the new text attribute", perhaps?  Other than that, this looks good to me.
-- 
Eyvind
