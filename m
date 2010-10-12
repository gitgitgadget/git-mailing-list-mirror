From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Tue, 12 Oct 2010 18:39:50 +0200
Message-ID: <4CB48F56.3020404@dbservice.com>
References: <loom.20101012T114900-532@post.gmane.org> <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Christian Halstrick <christian.halstrick@gmail.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 18:40:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5htR-00005J-AC
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 18:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484Ab0JLQjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 12:39:55 -0400
Received: from office.neopsis.com ([78.46.209.98]:47640 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457Ab0JLQjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 12:39:54 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.028,BAYES_00: -1.665,TOTAL_SCORE: -1.637,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Tue, 12 Oct 2010 18:39:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158864>

On 10/12/10 5:39 PM, Alex Riesen wrote:
> On Tue, Oct 12, 2010 at 12:03, Christian Halstrick
> <christian.halstrick@gmail.com> wrote:
>> Can I checkout a certain file to a specific revision without also adding this
>> content to the index? I only want to alter the working-tree - no modification of
>> index or HEAD needed.
> 
> "git show <revision-specification>:path/name > path/name" ?

I heard that git-show doesn't apply filters to the file (smudge/clean or
any custom ones). Keep that in mind when using it.

tom
