From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 13:19:13 +0100
Message-ID: <49804D41.3010801@dbservice.com>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com> <1233144045221-2231849.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zabre <427@free.fr>
X-From: git-owner@vger.kernel.org Wed Jan 28 13:21:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS9Q0-0006NI-L9
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 13:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbZA1MTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 07:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbZA1MTu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 07:19:50 -0500
Received: from office.neopsis.com ([78.46.209.98]:49168 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZA1MTt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 07:19:49 -0500
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Wed, 28 Jan 2009 13:19:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090126 Shredder/3.0b2pre
In-Reply-To: <1233144045221-2231849.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107530>

On 01/28/2009 01:00 PM, Zabre wrote:
>
> Tomas Carnecky wrote:
>> Do you mean 'undelete' a file? git checkout d.txt - That restores the
>> file in the working tree and resets the index just for that file.
>>
>
> Hi Tom,
> (thank you for your interest in my newbie problems)
>
> yes that's what I mean : 'undelete' a file, after a "git rm d.txt".
> But I did not manage to apply your solution succesfully :
> $ git rm d.txt
> $ ls
> a.txt b.txt c.txt
> $ git status
> # On branch new
> # Changes to be committed:
> #   (use "git reset HEAD<file>..." to unstage)
> #
> #	deleted:    d.txt
> #
> $ git checkout d.txt
> error: pathspec 'mamma.txt' did not match any file(s) known to git.
> Did you forget to 'git add'?

Oops, sorry. git checkout HEAD -- d.txt
You have to tell which version of d.txt you want. In your case the 
version in HEAD.

tom
