From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: What's the definition of a valid Git symbolic reference?
Date: Tue, 15 Feb 2011 06:02:57 +0100
Message-ID: <4D5A0901.7080202@dbservice.com>
References: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com> <F624322D-359A-48ED-A241-622042F77CDA@sb.org> <AANLkTi=FKXqu_psoT+gvyq2c_o8Mej+DgpccecOpQd8H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>, libgit2@librelist.com
To: Emeric Fermas <emeric.fermas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 06:03:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpD4M-0005LA-UH
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 06:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982Ab1BOFDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 00:03:05 -0500
Received: from office.neopsis.com ([78.46.209.98]:39105 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab1BOFDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 00:03:04 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.072,BAYES_00: -1.665,TOTAL_SCORE: -1.593,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Tue, 15 Feb 2011 06:02:58 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTi=FKXqu_psoT+gvyq2c_o8Mej+DgpccecOpQd8H@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166811>

  On 2/15/11 4:49 AM, Emeric Fermas wrote:
> Another possibility would be that only git internal symbolic
> references are allowed to live under the ".git" dir (HEAD, FETCH_HEAD,
> ...) and that user defined symrefs should live under refs/. In this

All refs should live under refs/ (except the special ones like HEAD 
etc). It's usually a mistake if someone manages to create one outside of 
refs/. The plumbing commands allow you to do that, but users usually 
shouldn't use those.

tom
