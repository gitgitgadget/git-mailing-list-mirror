From: Andy Lester <andy@petdance.com>
Subject: Re: RFC: C code cleanup
Date: Fri, 3 Jun 2011 16:38:33 -0500
Message-ID: <861C71D1-8F33-4DEE-B809-1E6CA178902D@petdance.com>
References: <3ECEA53B-C82C-4F3D-9E40-1D81EC17682E@petdance.com> <1307116956.4051.20.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:36:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSc2v-0001FD-0t
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 23:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab1FCVgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 17:36:40 -0400
Received: from huggy.petdance.com ([72.14.176.61]:45482 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363Ab1FCVgk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2011 17:36:40 -0400
Received: from [172.28.1.125] (host3130.follett.com [12.47.12.130])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: andy)
	by huggy.petdance.com (Postfix) with ESMTP id 94FDD2C53B6;
	Fri,  3 Jun 2011 17:36:39 -0400 (EDT)
In-Reply-To: <1307116956.4051.20.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175030>

>> -			pprint_tag(sha1, buf, size);
>> +			pprint_tag(buf, size);
> 
> seem to fail to ask important questions. Why is the code the way that it
> is? Should we be making this change? What is the argument for making
> this change?

Maybe I should submit these as tickets somewhere?  Clearly, something is incorrect, either with missing code or too much of it.

xoa

--
Andy Lester => andy@petdance.com => www.techworklove.com => AIM:petdance
