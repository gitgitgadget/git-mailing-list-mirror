From: Ian Molton <spyro@f2s.com>
Subject: how to import stuff?
Date: Wed, 25 Jan 2006 23:40:39 +0000
Organization: The Dragon Roost
Message-ID: <43D80C77.70207@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 26 00:37:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1uCl-0001m2-5t
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 00:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWAYXh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWAYXh2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 18:37:28 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:23953 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S1751189AbWAYXh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 18:37:27 -0500
Received: from [192.168.1.2] (i-195-137-81-187.freedom2surf.net [195.137.81.187])
	by outmail.freedom2surf.net (8.12.10/8.12.10) with ESMTP id k0PNbQch032035
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 23:37:26 GMT
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15141>

Hi.

I'd like to track the -mm tree in git.

I already have a linux git tree cloned from kernel.org, so I thought I'd try

git checkout -b v2.6.16-rc1 v2.6.16-rc1
git checkout -b v2.6.16-rc1-mm3
patch -Np1 < 2.6.16-rc1-mm3

So far so good - I have a tree with the patches applied

but then how do I add / remove new / deleted files?

git update-index --add --remove --refresh --ignore-missing

seems to generate a list of said files, but I cant seem to figure out 
how to get it to actually do anything useful with them.

git add . adds all the new files, but there seems to be no equivalent to 
remove files

and I really dont want to run git updat-index on *every single file* 
that changed by hand.

Surely Im missing something, but I cant see what for the life of me. The 
  'everyday git' document seems to focus on small changes to one or two 
files.

managing files not yet in or removed from the source isnt something 
effectively covered in the document (or if it is, I missed it somehow).

Its probably obvious that Im new to this kind of SCM - and I've not got 
on with SCMs generally... they never seem to be logical to me.

TIA!

-Ian
