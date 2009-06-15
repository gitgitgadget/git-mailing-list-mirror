From: Dotan Barak <dotanba@gmail.com>
Subject: Re: How can i find the origin of a branch?
Date: Mon, 15 Jun 2009 15:03:57 +0300
Message-ID: <2f3bf9a60906150503p69e992b4m18bdc2cc842b933e@mail.gmail.com>
References: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
	 <4A363741.9030604@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Kristian Amlie <kristian.amlie@nokia.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 14:09:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGB0M-0003gQ-EE
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 14:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbZFOMJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 08:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbZFOMJX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 08:09:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:37999 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbZFOMJX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 08:09:23 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1084667fgg.17
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+xJiRUwTDWX2e36qNSy1Et4X10XLyxMUsyivx3bttNY=;
        b=ofKaXtziuklq9DuPQTZ6IAXyinYbs+T/Edvw8HElfUDqLc8w/gGWimLHV0VtKn0v9e
         WOtjkq2QJLBg+9TlM5NvY3MXnsQWMDbxltpc9O0HnmJPUMeRQUbNQmE98KKEnI/+8PLf
         Ui8V2y/wLeR0alOvZz5S23ocdCfsjlWMe1AHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qFqa3MbfKU18RAuMmCydD5I01W5TR+QBFhaixPrj/dp47/chQu2E5eRei8h/mk6qdo
         zr6rDVNZ7wJHFmMCjLjqVbh4vtgnibaxBY5Hr1l0TaiDbt5fMpvo3WHUFMtcwG53HT/P
         A0su85pH8zOqgaL/WwyATgG5EoFWrEyeusr6k=
Received: by 10.86.95.8 with SMTP id s8mr6608652fgb.2.1245067437112; Mon, 15 
	Jun 2009 05:03:57 -0700 (PDT)
In-Reply-To: <4A363741.9030604@nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121601>

Thank you very much for a quick and exact answer
:)

Dotan


On Mon, Jun 15, 2009 at 2:57 PM, Kristian Amlie<kristian.amlie@nokia.com> wrote:
> ext Dotan Barak wrote:
>> Hi.
>>
>> Is it possible to find the origin of a branch?
>> (the remote repository that this branch was cloned and checked out from)
>
> git config -l
>
> Assuming you're on the master branch, branch.master.remote and
> branch.master.merge will tell you which remote and which branch you are
> tracking. Assuming that the remote is origin, you can check
> remote.origin.url to see the URL of the repo.
>
> --
> Kristian
>
