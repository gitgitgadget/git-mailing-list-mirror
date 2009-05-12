From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: How to create a new commit with the content of some commit?
Date: Tue, 12 May 2009 18:04:38 +0200
Message-ID: <83048193-FBD1-4D14-9CC9-B95BD08C67F7@dbservice.com>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com> <46dff0320905120847wae71bday4d4a890b00abc222@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uUQ-0001ga-Li
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbZELQFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbZELQFI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:05:08 -0400
Received: from office.neopsis.com ([78.46.209.98]:38167 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486AbZELQFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:05:06 -0400
Received: from [10.3.96.145] ([147.88.200.112])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Tue, 12 May 2009 18:05:04 +0200
In-Reply-To: <46dff0320905120847wae71bday4d4a890b00abc222@mail.gmail.com>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118911>


On May 12, 2009, at 5:47 PM, Ping Yin wrote:

> On Tue, May 12, 2009 at 10:35 PM, Ping Yin <pkufranky@gmail.com>  
> wrote:
>> a----b
>>  \----c
>>
>> Given the graph above, I want to create a commit b1 on top of c,  
>> where
>> b1 and b have the same content. i.e.
>>
>> a----b
>>  \----c----b1    ( content(b) == content(b1) )
>
> More precisely, b1 and b point to the same tree object

git checkout c
git cherry-pick b

tom
