From: Pedro Melo <melo@simplicidade.org>
Subject: Re: Perl module for Git
Date: Tue, 17 Feb 2009 07:58:25 +0000
Message-ID: <70CD5CFD-9E5A-46D2-982C-A7FC12F89DAF@simplicidade.org>
References: <2E5115F2-7692-4E6F-B163-3DD2D3943C25@simplicidade.org> <200902161845.45530.nadim@khemir.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 09:00:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZKs6-0005Aa-HP
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbZBQH6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZBQH6e
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:58:34 -0500
Received: from speed.simplicidade.org ([81.92.204.129]:50785 "HELO
	speed.simplicidade.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751069AbZBQH6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:58:34 -0500
Received: (qmail 28361 invoked from network); 17 Feb 2009 07:58:35 -0000
Received: from bl4-172-146.dsl.telepac.pt (HELO MrTray.lan) (81.193.172.146)
  (smtp-auth username melo@simplicidade.org, mechanism plain)
  by speed.simplicidade.org (qpsmtpd/0.43rc1) with (AES256-SHA encrypted) ESMTPSA; Tue, 17 Feb 2009 07:58:35 +0000
In-Reply-To: <200902161845.45530.nadim@khemir.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110326>


On Feb 16, 2009, at 5:45 PM, nadim khemir wrote:

> On Monday 16 February 2009 16.44.45 Pedro Melo wrote:
>> Hi,
>>
>> I'm writting a small web-based tool for designers to manage a small
>> set of HTML templates. They will use SFTP or DAV to edit the  
>> templates
>> in a development server, and then use the web-based tool to commit
>> their changes and push to the test server.
>>
>> What is the best Perl module for this? I'm thinking on using Git.pm
>> but I wonder if there isn't a better solution?
>
> You please give use a few use cases. I must admit that I don't get  
> exactely
> what you want to do.

Simple stuff.

I have a git repo on a server, designers edit the template directly  
using DAV or SFTP.

When their changes are ok, they would go to the web tool, see the  
diffs, commit them, and push the result to our "for test" repo.

So basically I need to be able to see the status of a workdir, diff,  
commit and push from within a web app.

I'm just wondering if the Git.pm that comes with git is the best tool  
for this.

Best regards,
