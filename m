From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: git remote vs. submodules
Date: Thu, 11 Nov 2010 16:00:07 +0100
Message-ID: <4CDC04F7.6080801@dbservice.com>
References: <AANLkTinev0W7-mm9wXmnZwY6DxN0Y2X0hJdpBOgM_4q=@mail.gmail.com> <4CDBD4D4.1080607@dbservice.com> <AANLkTin=t7RoLTwxc1KOv7_vZi-OgD_Jcu+66-fte6Sq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 16:00:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGYdP-0003O4-Dz
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 16:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab0KKPAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 10:00:12 -0500
Received: from office.neopsis.com ([78.46.209.98]:39992 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab0KKPAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 10:00:11 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: -0.013,BAYES_00: -1.665,TOTAL_SCORE: -1.678,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.2.175.86])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 11 Nov 2010 16:00:09 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTin=t7RoLTwxc1KOv7_vZi-OgD_Jcu+66-fte6Sq@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161264>

On 11/11/10 3:44 PM, Patrick Doyle wrote:
> On Thu, Nov 11, 2010 at 6:34 AM, Tomas Carnecky <tom@dbservice.com> wrote:
>> Are you maybe looking for a subtree merge?
>> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
> 
> Yeah, that looks like it.  I never would have hit upon the read-tree
> step by myself -- I would have just laid things out with the prefix
> already embedded in the subprojects.
> 
> Hmmm... it seems to me that feeding changes back to the subprojects
> might be difficult (and that is born out by a comment at the end of
> the page you referenced.)

https://github.com/apenwarr/git-subtree, it makes exactly that easier.

tom
