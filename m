From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Detecting GIT_DIR runtime
Date: Wed, 05 May 2010 18:54:33 +0200
Message-ID: <4BE1A2C9.6010408@dbservice.com>
References: <t2gb42431c81005050838w425412d9jfe176c3b637e77c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 18:54:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9hrx-00018k-If
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 18:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab0EEQyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 12:54:38 -0400
Received: from office.neopsis.com ([78.46.209.98]:42559 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab0EEQyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 12:54:37 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Wed, 5 May 2010 18:54:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <t2gb42431c81005050838w425412d9jfe176c3b637e77c1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146410>

On 5/5/10 5:38 PM, Mahesh Vaidya wrote:
> I have a tree like
> /home/mvaidya/WORKSPACE/nvos/mvaidya-master-100.local/some/folder
>
> I would like to issue come command say "git fetch" from any level of
> the tree. How can I deduce path of .git folder. Reason I need it as I
> some application configuration saved in .git/workspace.properties and
> I need to some action before git fetch.
>

Take a look at:
$ git rev-parse --cdup

tom
