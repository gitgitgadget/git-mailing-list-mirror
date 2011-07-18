From: gaoyong pan <pan.gaoyong@gmail.com>
Subject: Re: git sparse checkout repo size
Date: Mon, 18 Jul 2011 19:29:59 +0800
Message-ID: <CALf5Ac2A4XTfkZraVra2sSGJZJ31bTyfmgHZWjptJNgQtXyH7Q@mail.gmail.com>
References: <CALf5Ac223mASO+KGYa3nqB+3eajvRS4QueGT5on6G5kYqhODQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 13:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qim1e-0002d7-Dd
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 13:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378Ab1GRLaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 07:30:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38417 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab1GRLaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 07:30:01 -0400
Received: by wyg8 with SMTP id 8so2001125wyg.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 04:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=W8FAkMoP2uO5hDg6vDDTxylF7g+cFUv5kHgf+zFWDLE=;
        b=yG6C7a1+9s85H89ZWqlpXBolEM5Co8Fk0Lwf4fUFaTmtmCpnZwG9d5jr9QRZOle1ie
         YvDWkIsQ+lulDZ0hhVbxQNUKpWXG0TqfhoX7eZ7VjyGbIfQfur1M3lXhIv3cn4t4jqfr
         GNcoo4QO7DpebWLH10ZervkXgM8aTlPzvMqNg=
Received: by 10.216.88.132 with SMTP id a4mr5347595wef.31.1310988599093; Mon,
 18 Jul 2011 04:29:59 -0700 (PDT)
Received: by 10.216.175.130 with HTTP; Mon, 18 Jul 2011 04:29:59 -0700 (PDT)
In-Reply-To: <CALf5Ac223mASO+KGYa3nqB+3eajvRS4QueGT5on6G5kYqhODQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177368>

Hi there,

I use sparse checkout to checkout out two small files(8M total) from a
large repo (~2G), and then check the whole repo size is about 1.2G, it
reduces about 0.8G repo size, can you tell me how to reduce it much
more? I don't want to use submodule or subtree merge because I'd keep
all the changing history of them in the original repo for the current
or further logs.

-- 
Best Regards
Linux user #384184
@ http://counter.li.org/
