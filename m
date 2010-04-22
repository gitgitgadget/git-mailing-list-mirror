From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: GIT counterpart to "svn list"
Date: Thu, 22 Apr 2010 05:47:41 +0200
Message-ID: <4BCFC6DD.4040206@dbservice.com>
References: <20100421222237.1758ca66@pennie-farthing>	<4BCFC180.5020009@dbservice.com> <20100421223716.6526f625@pennie-farthing>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jack Desert <jackdesert556@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 05:47:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4nOJ-0000XS-R8
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 05:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab0DVDrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 23:47:46 -0400
Received: from office.neopsis.com ([78.46.209.98]:58264 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab0DVDro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 23:47:44 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 22 Apr 2010 05:47:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100421223716.6526f625@pennie-farthing>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145500>

On 4/22/10 5:37 AM, Jack Desert wrote:
> "svn list" displays which files and folders in the current directory are under version control. It's helpful in figuring out which files you still need to add to the repository. Attached is sample output from one of my directories under subversion souce control.

git ls-files. If you want to find out which files you haven't added to 
git, use 'git ls-files --other --exclude-standard', but 'git status' is 
usually much more helpful, and shorter to type.

tom
