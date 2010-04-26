From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: MIME problem when using git format-patch / git am
Date: Mon, 26 Apr 2010 09:50:39 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1004260948070.22806@ds9.cixit.se>
References: <20100425233549.GA8737@triton> <20100426014941.GA29220@progeny.tock>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: =?ISO-8859-15?Q?=D8yvind_A=2E_Holm?= <sunny@sunbase.org>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 10:51:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6K20-0000Pd-KU
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 10:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab0DZIu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 04:50:57 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:35782 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751893Ab0DZIu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 04:50:56 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o3Q8oeka027930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Apr 2010 10:50:40 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o3Q8odRg027927;
	Mon, 26 Apr 2010 10:50:39 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20100426014941.GA29220@progeny.tock>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 26 Apr 2010 10:50:40 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145799>

Jonathan Nieder:

> This leads to a question: what if one wants to include a word that quotes 
> to more than 75 characters?

You just split it into two encoded words. The whitespace between the 
encoded words is there for syntactic reasons only, it is not included in the 
final result if both parts are encoded words (look at the "Examples" section 
of the RFC for some examples of how it works).

-- 
\\// Peter - http://www.softwolves.pp.se/
