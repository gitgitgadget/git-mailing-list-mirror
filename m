From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Unable to delete remote branch with a strange name
Date: Tue, 28 Dec 2010 18:59:29 +0100
Message-ID: <4D1A2581.9050305@dbservice.com>
References: <loom.20101228T080344-503@post.gmane.org> <m2hbdy9top.fsf@whitebox.home> <loom.20101228T170808-756@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jingzhao Ou <jingzhao.ou@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 18:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXdpj-0008Sx-A4
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 18:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375Ab0L1R7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 12:59:34 -0500
Received: from office.neopsis.com ([78.46.209.98]:43641 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0L1R7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 12:59:34 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.066,BAYES_00: -1.665,TOTAL_SCORE: -1.599,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Tue, 28 Dec 2010 18:59:29 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <loom.20101228T170808-756@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164280>

  On 12/28/10 5:10 PM, Jingzhao Ou wrote:
> Yes, using the absolute path works like a champ!
>
> git push origin :refs/heads/remotes/origin/dev/main

Do not use the term 'path' in this context. The fact that a ref looks 
like a path, and can be stored on the filesystem under the same 
directory structure is just an implementation detail. Note the *can*, 
because in the case of packed refs (see man git-pack-refs) the term 
'path' is not even remotely accurate.

We use the term 'fully qualified ref' (see the similarity with 'fully 
qualified domain name') if we want to stress out that the full name of 
the ref is used (refs/heads/foo) instead of an abbreviation (foo).

tom
