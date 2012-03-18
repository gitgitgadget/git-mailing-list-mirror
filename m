From: Felipe Tanus <fotanus@gmail.com>
Subject: Re: [GSoC] Improving parallelism
Date: Sun, 18 Mar 2012 01:58:09 -0300
Message-ID: <CANELHzNsZH5zJ9Y-E9yacuBwx6sTw+5AXR8cdbGG0j=SX_2TZg@mail.gmail.com>
References: <CANELHzNc+28ZDiZ69zv3X0DJMf0DTkiZXQD1-32Wsy-=vtWDhw@mail.gmail.com>
 <CACsJy8BFcx0dR12MYtZiHsmh3=z71NoT9CuL9Xsgq6bca-Q_Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 05:58:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S98Cl-0007Jd-5y
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 05:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab2CRE6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 00:58:33 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:36395 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab2CRE6b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 00:58:31 -0400
Received: by wejx9 with SMTP id x9so4996251wej.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ibMbbTIBwP1JzHfBOhQBNp+9cv0jIayh4i2MSm4Jbi0=;
        b=qInrYc0A9nM3Nv4gWkYgMfoGyrsf9FkbQzkFNXWw477NltFeo6I9EfcUgXtEKuOlQc
         YmS4IvFpbVS07kvQnMtxRcqamLhVQYB+UfgNhnG14PLW6dIWI8hCQtSvCA6fVhaQMKUC
         Ywy6VgMQEDLEPZ5c7zVJQ6Q20093DKJ5OY7led5vFErpXzIOlY4CQ6OFKKFSV424Hk8d
         L9P0D2TCLinSDiOvnIvrpUKzf86lQWJJYSlo/XAtIDxigrnudFgVWUytkrvwFDPLDcOH
         GUQBCxgmUEiiuLp+YRxc0KlCH2SAUscJ7QMW3wf63kRQudrt1IfS0Els6a4TTqgoTCnA
         fXXg==
Received: by 10.180.83.72 with SMTP id o8mr10213966wiy.5.1332046709957; Sat,
 17 Mar 2012 21:58:29 -0700 (PDT)
Received: by 10.216.26.4 with HTTP; Sat, 17 Mar 2012 21:58:09 -0700 (PDT)
In-Reply-To: <CACsJy8BFcx0dR12MYtZiHsmh3=z71NoT9CuL9Xsgq6bca-Q_Cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193370>

On Sun, Mar 18, 2012 at 1:42 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Sun, Mar 18, 2012 at 5:18 AM, Felipe Tanus <fotanus@gmail.com> wrote:
>>  but if you know already other
>> commands that might benefit from this parallelism, please tell me in
>> order for me to include in my proposal.
>
> "git blame" (I think, I don't use this command much) and "git fsck".
> "git index-pack" is getting multithread support soon (you can search
> mail archive), but even then I think there's still room for further
> improvements (i.e. parallelize the hashing code in the first phase of
> checking the pack).
>
> If that's not enough, you may want to investigate whether multithread
> support can speed up "git rev-list --objects --all" without adding too
> much complexity. Speeding up this can also be achieved by implementing
> pack format version 4 (current version is 3). But that's a bigger work
> and may need more time to land.
> --
> Duy

Hi Duy,

Thanks for the answer, was very helpful. I'll check this commands and
see what can I complete in time to add into the proposal.

Regards,


-- 
Felipe de Oliveira Tanus
E-mail: fotanus@gmail.com
Site: http://www.inf.ufrgs.br/~fotanus/
-----
"All we have to decide is what to do with the time that is given us." - Gandalf
