From: Eric Niebler <eric@boostpro.com>
Subject: Re: help moving boost.org to git
Date: Mon, 05 Jul 2010 13:51:43 -0400
Message-ID: <4C321BAF.8020303@boostpro.com>
References: <4C31E944.30801@boostpro.com> <4C31F0D4.1040207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 19:52:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVppj-0007O1-HP
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 19:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab0GERvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 13:51:50 -0400
Received: from boostpro.com ([206.217.198.21]:50742 "EHLO boostpro.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753456Ab0GERvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 13:51:49 -0400
Received: from [192.168.2.114] (c-76-118-178-34.hsd1.ma.comcast.net [76.118.178.34])
	(Authenticated sender: eric)
	by boostpro.com (Postfix) with ESMTPSA id 1139E14BC88
	for <git@vger.kernel.org>; Mon,  5 Jul 2010 18:51:49 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.10) Gecko/20100512 Lightning/1.0b1 Thunderbird/3.0.5
In-Reply-To: <4C31F0D4.1040207@viscovery.net>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150280>

On 7/5/2010 10:48 AM, Johannes Sixt wrote:
> Am 7/5/2010 16:16, schrieb Eric Niebler:
>> I have a question about the best approach to take for refactoring a
>> large svn project into git. The project, boost.org, is a collection of
>> C++ libraries (>100) that are mostly independent. (There may be
>> cross-library dependencies, but we plan to handle that at a higher
>> level.) After the move to git, we'd like each library to be in its own
>> git repository.
> 
> You could use svn2git: http://gitorious.org/svn2git
> KDE uses it to split its SVN repository into pieces. The tool is driven by
> a "ruleset" that specifies SVN subdirectories and revision numbers that
> make up a module.

I'm off to learn about filter-branch, tree-filter and svn2git. Thanks
for the suggestions. More questions to come, I'm sure.

-- 
Eric Niebler
BoostPro Computing
http://www.boostpro.com
