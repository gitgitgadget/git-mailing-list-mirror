From: "Eivind LM" <eivliste@online.no>
Subject: Re: Split a subversion repo into several git repos
Date: Fri, 12 Oct 2007 16:47:12 +0200
Message-ID: <op.tz290yyfjwclfx@ichi>
References: <op.tz09zaizjwclfx@ichi> <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com> <470E9858.5050904@vilain.net> <op.tz28hnd2jwclfx@ichi> <1B9700E6-5DFB-443D-9465-30E0DCAD0619@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 16:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgLnn-0002Wb-De
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 16:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbXJLOrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 10:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbXJLOrf
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 10:47:35 -0400
Received: from mail-forward.uio.no ([129.240.10.42]:38637 "EHLO
	mail-forward.uio.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbXJLOrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 10:47:33 -0400
Received: from mail-mx5.uio.no ([129.240.10.46])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <eivliste@online.no>)
	id 1IgLnY-0002IA-Kp; Fri, 12 Oct 2007 16:47:32 +0200
Received: from cma-eivindlm.uio.no ([129.240.223.140] helo=ichi)
	by mail-mx5.uio.no with esmtp (Exim 4.67)
	(envelope-from <eivliste@online.no>)
	id 1IgLnW-0002Fr-9D; Fri, 12 Oct 2007 16:47:30 +0200
In-Reply-To: <1B9700E6-5DFB-443D-9465-30E0DCAD0619@steelskies.com>
User-Agent: Opera Mail/9.23 (Linux)
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 23FC05026812FE111DEAAFD3BD54891B3D327FA2
X-UiO-SPAM-Test: remote_host: 129.240.223.140 spam_score: -49 maxlevel 200 minaction 2 bait 0 mail/h: 3 total 17 max/h 3 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60694>

On Fri, 12 Oct 2007 16:23:44 +0200, Jonathan del Strother  
<maillist@steelskies.com> wrote:
[...]
>>
>>  $ git-svn init -b eivindlm/branches \
>>                 -t eivindlm/tags \
>>                 -T eivindlm/trunk/src/probesimulator \
>>                 file:///svn-repo/
>> , which prints the happy message:
>>  Initialized empty Git repository in .git/
>>
>> The next command is unfortunately not as happy:
>>  $ git fetch
>>  fatal: 'origin': unable to chdir or not a git archive
>>  fatal: The remote end hung up unexpectedly
>>  Cannot get the repository state from origin
>
>
> I believe you actually wanted "git-svn fetch" here

You are right, that solved the problem :)

So both methods work now, apparently giving the same result. Is there a  
difference between the fetch- versus the clone-approach? I am doing this  
as a once-and-for-all import, and would like to forget everything about  
the subversion repository afterwards.

Thanks,
Eivind
