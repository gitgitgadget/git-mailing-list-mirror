From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit bug] git user settings not retrieved when launched for Windows explorer
Date: Tue, 7 Oct 2008 13:57:42 +0200
Message-ID: <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
References: <48EB10C8.4070009@lyx.org>
	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
	 <48EB49B3.1090509@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 13:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnBDd-0001ad-Pf
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 13:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbYJGL5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 07:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbYJGL5p
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 07:57:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:49530 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbYJGL5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 07:57:44 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2761595fkq.5
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SNh8ONRprTxAqjP6oEZ2SZDFldZfYlgdvOeBu5KjXis=;
        b=Zn+CkbqHwmNa9/cRFNQxTzjEv+/aWT5yyx3RODlvt59KBp6rh6DHiWYAACJoZdhkg8
         Ipt0UGQLgkcqvALdACXqkjfFYoUUuquuc4cZuLAC3L/qA2teKH9IRhrRQNPszNzegzCX
         iJjPjob6JbG4eyMoDTEsNwtR8lTK6HrJmgEDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=G0s/hGu/Qj81nLK1H1EyZ6FewCYP0D/2Q3NBjN62x5Q7G/A5cilkMMK06QmCXDTlGO
         i3hR35CujzE2vmW3XInK28wwltUwMxM5HZXHCIUDJkXQDxgj5tVeTrIkTV4Zh68mdBaW
         63a7TR6e4v92hOCd1pqOzx3drUamHFM/OQ1M4=
Received: by 10.181.23.2 with SMTP id a2mr4701488bkj.24.1223380662986;
        Tue, 07 Oct 2008 04:57:42 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 04:57:42 -0700 (PDT)
In-Reply-To: <48EB49B3.1090509@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97698>

On Tue, Oct 7, 2008 at 1:36 PM, Abdelrazak Younes <younes@lyx.org> wrote:
>
>> Sound like a problem of startup directory: on the command line you
>> start from the right directory...when you double click on which repo
>> qgit is open ?
>>
>
> None of course. But when I open a repository manually I would expect that
> this is properly filled in.
>

In git.cpp, Git::userInfo() function get info about user by means of
'git config' calls, my guess (I cannot it test now) is that 'git
config' does not work if we are not in a git directory.


> And if I launch qgit with the context menu (right clicking a directory in
> the Explorer), qgit never managed to open the repository.
>

This is a bug that I never managed to get rid of :-(

It is strange because it works if you try in a subdirectory, as
example try right clicking on 'src' directory of qgit project.

Thanks
Marco
