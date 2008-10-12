From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 06:09:47 -0400
Message-ID: <ee2a733e0810120309o1fbfa4dxe6f2292a28bd6db3@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 12:13:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Koxx4-0002Ea-Ux
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 12:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYJLKJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 06:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYJLKJv
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 06:09:51 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:33873 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbYJLKJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 06:09:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1157646fkq.5
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ICWViKUIrUAEqChwuBS/HLOIrzSY5x+ewebC+zUfdPs=;
        b=UMTExKj/u2pee2aHgSXBofCL7mefdZ65Z3g9I5744jykOh6cXgYvI1evVd3zFdiTJd
         wif3+kDCxNyD2bgP8/IBb3KGGZ93L1/aDnKiVBQfF95Jzt4r0T5SijQ6pCeacuMiOhO0
         cq1CqTbFfl2gsyXjzdCksxunx6J1C0UwPycAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=bDU0lDvuxK/Wcmg5A31SqjE40g6fQrFKjsaXNDbOWBxxSLYNe/Ld20kp55TzGSCsCI
         UrIlwrzlFuYUZYURL/ZfJI0uSpQzJVnYMRt+S5oMgY9ur/Bg4gzVTOS7YCgfh+Q8vCwN
         U8ycADLkNobtL16Fp56A5saUNKdDUpdw+AQvo=
Received: by 10.187.188.19 with SMTP id q19mr880327fap.48.1223806187887;
        Sun, 12 Oct 2008 03:09:47 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sun, 12 Oct 2008 03:09:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98010>

On 10/12/08, Junio C Hamano <gitster@pobox.com> wrote:
> [..snip..]
> I was going to suggest the same.  "git st" for people who come from "svn st"
>  so that "git status" can be kept as traditional "preview of 'git commit'".
>
>  And just make it mimic whatever folks accustomed to "svn st" would expect,
>  modulo we would need two status letters to signal difference between
>  (HEAD, index), and (index, worktree).  Perhaps three if you want to show
>  difference between (HEAD, worktree) while at it.
>
>  And no, I have not seen any argument good enough to change ls-files nor
>  diff-$lowlevel output and break people's existing scripts.
>

Please, at least introduce a new option (--status-letters)  that makes

git log --name-status
git diff --name-status
git ls-files -v

to use consistent letters to indicate the status. For details, see
recent discussion
http://www.spinics.net/lists/git/msg81141.html

Thanks,
--Leo--
