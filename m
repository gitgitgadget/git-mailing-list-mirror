From: "Pascal Obry" <pascal@obry.net>
Subject: Re: rebase, file permissions and removed file
Date: Mon, 27 Oct 2008 16:33:22 +0100
Message-ID: <a2633edd0810270833q482260b4pf0ae11dcf2d4936f@mail.gmail.com>
References: <a2633edd0810270702x416bb659ke183b0cc6266071@mail.gmail.com>
	 <4905D276.9020308@viscovery.net>
	 <a2633edd0810270809w7fec93b2rc314cc025f41d41f@mail.gmail.com>
	 <4905DC90.6050503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 16:34:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuU78-00015K-2K
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 16:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbYJ0Pd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 11:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbYJ0PdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 11:33:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:63192 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbYJ0PdY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 11:33:24 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2099015wfd.4
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 08:33:23 -0700 (PDT)
Received: by 10.140.191.14 with SMTP id o14mr3329298rvf.130.1225121602777;
        Mon, 27 Oct 2008 08:33:22 -0700 (PDT)
Received: by 10.141.51.13 with HTTP; Mon, 27 Oct 2008 08:33:22 -0700 (PDT)
In-Reply-To: <4905DC90.6050503@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99239>

On Mon, Oct 27, 2008 at 4:21 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Pascal Obry schrieb:
>> On Mon, Oct 27, 2008 at 3:38 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Since you don't have any content to lose, you can always just
>>>
>>>  $ touch file1
>>>  $ git add file1
>>>  $ git rm file1
>>
>> Does not work:
>
> Yes, it did! ;)

Well, on my side I add to use:

   $ git rm --cached file1

For the last command.

> This is an entirely different matter. My interpretation is that the
> permission change of file1 was the only change in this commit. Since this
> is no longer needed, you should run 'git rebase --skip'.

No no :) Too easy! I have plenty of other permission changes in my commit
that I do not want to loose!

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
