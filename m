From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: gitosis configuration question
Date: Tue, 08 Mar 2011 21:53:17 +0100
Message-ID: <4D76973D.2030408@web.de>
References: <AANLkTik1WFacXcxrWP3RQ26rXCaQphT1H-CAwKEz6Gx8@mail.gmail.com> <1299616032.20004.2.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>,
	git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Mar 08 21:53:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px3ui-0002Kt-I7
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 21:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab1CHUxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 15:53:49 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:36090 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab1CHUxs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 15:53:48 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id AAE5A18AADDAB;
	Tue,  8 Mar 2011 21:53:17 +0100 (CET)
Received: from [93.240.111.18] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Px3u9-0004WE-00; Tue, 08 Mar 2011 21:53:17 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <1299616032.20004.2.camel@drew-northup.unet.maine.edu>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+jVXYEINQ5clMkLtZ6HNkg8A6+m5y6igSqDZzM
	+6F5uUDVFA5o0JkBcC34Mdx/P4g/lopsOhacqQyVuqaRVQEvpH
	+rBarGMwXlO0VzR251YA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168690>

Am 08.03.2011 21:27, schrieb Drew Northup:
> 
> On Tue, 2011-03-08 at 13:46 -0500, Hillel (Sabba) Markowitz wrote:
>> When setting up gitosis, I want to have multiple repos available for a
>> particular group. However, the list of repos is too big for a single
>> line. The example.conf does not indicate if this is allowed.  That is,
>> the example that it gives is
> 
> Hillel,
> Gitosis is basically no longer supported...

Having said that: If you want to use it nonetheless, try using
backslashes:

[group new group]
members = Bob Carol Ted \
	Alice
writable = base \
	cover \
	pot \
	lid

Works fine at my dayjob.
