From: John Feuerstein <john@feurix.com>
Subject: Re: gitosis configuration question
Date: Tue, 08 Mar 2011 22:07:23 +0100
Message-ID: <4D769A8B.7000606@feurix.com>
References: <AANLkTik1WFacXcxrWP3RQ26rXCaQphT1H-CAwKEz6Gx8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:14:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4F3-00032I-H8
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab1CHVOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:14:47 -0500
Received: from mx1.pyrox.eu ([188.40.139.189]:36846 "EHLO mx1.pyrox.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857Ab1CHVOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:14:47 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Mar 2011 16:14:47 EST
Received: from mx1.pyrox.eu (mx1.c10.pyrox.eu [10.10.1.5])
	by mx1.pyrox.eu (pxmail) with ESMTP id D0F9840BB4;
	Tue,  8 Mar 2011 22:07:24 +0100 (CET)
Received: from [192.168.10.110] (ip-81-210-160-120.unitymediagroup.de [81.210.160.120])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.pyrox.eu (pxmail) with ESMTPSA id AC614408E3;
	Tue,  8 Mar 2011 22:07:24 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <AANLkTik1WFacXcxrWP3RQ26rXCaQphT1H-CAwKEz6Gx8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168696>

> [group mygroup]
> members = Bob Carol Ted Alice
> writable = base cover pot lid
>
> Is the following allowable?
>
> [group new group]
> members = Bob Carol Ted
> members = Alice
> writable = base
> cover
> pot
> lid

Gitosis is written in Python and uses the ConfigParser[1] module.
It allows line continuations in the style of RFC 822, see [2]:

foo = bar
       baz
       qux


Hope this helps,
John

[1] http://docs.python.org/library/configparser.html
[2] http://tools.ietf.org/html/rfc822.html#section-3.1.1
