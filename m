From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: A sudden lack of permission
Date: Mon, 27 Sep 2010 17:16:43 +0100
Message-ID: <4CA0C36B.5000708@llaisdy.com>
References: <4CA0AFC4.1060001@llaisdy.com> <20100927160759.GB10256@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0GNq-0000cu-Na
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163Ab0I0QQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:16:47 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:34909 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759768Ab0I0QQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:16:46 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 3037FDEC1E;
	Mon, 27 Sep 2010 17:16:45 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id zSImTKWZA-rn; Mon, 27 Sep 2010 17:16:45 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id E5BD0DEC16;
	Mon, 27 Sep 2010 17:16:44 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20100927160759.GB10256@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157348>

  Dear Peff

Thanks for your help.

Yes, I can ssh onto the server, cd to /var/www/git/my_repos.git and add, 
edit files, etc.

There is another person on the box doing sysadmin.  I'll ask.

Is there any reason the repos could have just broken somehow?  A corrupt 
push?

Best wishes

Ivan



On 27/09/2010 17:07, Jeff King wrote:
> On Mon, Sep 27, 2010 at 03:52:52PM +0100, Ivan Uemlianin wrote:
>
>> I have been using git quite happily for a good while, pushing to my
>> remote.  Suddenly this afternoon the remote told me I didn't have
>> permission:
>>
>>      $ git push
>>      ivan@remote.org's password:
>>      Counting objects: 19, done.
>>      Delta compression using up to 2 threads.
>>      Compressing objects: 100% (11/11), done.
>>      Writing objects: 100% (11/11), 1.04 KiB, done.
>>      Total 11 (delta 8), reused 0 (delta 0)
>>      error: insufficient permission for adding an object to repository
>> database ./objects
>>
>>      fatal: failed to write object
>>      error: unpack failed: unpack-objects abnormal exit
>>      To ivan@remote.org:/var/www/git/my_repos.git
>>       ! [remote rejected] master ->  master (n/a (unpacker error))
>>      error: failed to push some refs to
>> 'ivan@remote.org:/var/www/git/my_repos.git'
>>
>> I had sufficient permission even this morning!
>>
>> Please could someone tell me what might have happened and, more
>> importantly, how I can start pushing to the remote again?  The
>> project in my_repos is large, so I'd rather not start a new repos
>> from scratch.
> Presumably the permissions on the server changed for some reason. Can
> you ssh to the remote host and confirm that user "ivan" has permissions
> to write to the repo's objects dir? If not, then you will have to figure
> out what happened, but it is likely outside the scope of git (e.g., an
> overly inclusive chmod by some cron job or admin on the box).
>
> If you do have permissions, then we will have to dig deeper into why git
> would fail, but the permissions would appear fine.
>
> -Peff


-- 
============================================================
Ivan A. Uemlianin
Speech Technology Research and Development

                     ivan@llaisdy.com
                      www.llaisdy.com
                          llaisdy.wordpress.com
                      www.linkedin.com/in/ivanuemlianin

     "Froh, froh! Wie seine Sonnen, seine Sonnen fliegen"
                      (Schiller, Beethoven)
============================================================
