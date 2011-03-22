From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: /usr/lib/git-core/git-rebase: 590: cannot open /home/mathieu/dummy/.git/rebase-merge/rewritten:
 No such file
Date: Tue, 22 Mar 2011 16:18:30 +0100
Message-ID: <AANLkTikn30scXd2F3z1QqntROyqfcvEBF4gEFtHyU=9c@mail.gmail.com>
References: <AANLkTinx1bDaChNwrn6pQjxbyZ-rH6TZ_5JuWszY1LTE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 16:24:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q23Rp-0005h0-L7
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 16:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab1CVPYi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 11:24:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32890 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab1CVPYg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 11:24:36 -0400
Received: by gyf1 with SMTP id 1so2334441gyf.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=LnY3rcvHe6tlqaG1bPd21BmwyJZIZLP8u+wYciIwaKE=;
        b=GtyD87nteTddg+exP5SRQfG8aGVjIwg26HtWmbAapvcOFTxitnsyUBIUd9kBJzpDIS
         WmrgWkiiHteTGNUUuX3fYB+S8HUnU9WJiI/jOEVDxxJRl2N7H8zAoMvMkLwLcr0CxaNB
         1sUyhjaYDJcnPbYVC1nbkbr/bPHVTLp33DZ84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=afp4CjFM+fUqEuSzW8a648GsnOcpgvTOZgkYHIaBpa7rw4YUpXNwkoz0L2XFhQxGeh
         kkuP9dIrYa+10CFO5JC068umpvzcvp1xcDlQuF4pj/iPnzmT/IbuDev4b1EBZ1JmCH0s
         v+LzgVBKhQPTeiKYlrKFC0Z43fNdDxFF2Chis=
Received: by 10.91.151.9 with SMTP id d9mr5196889ago.176.1300807475866; Tue,
 22 Mar 2011 08:24:35 -0700 (PDT)
Received: by 10.90.51.11 with HTTP; Tue, 22 Mar 2011 08:18:30 -0700 (PDT)
In-Reply-To: <AANLkTinx1bDaChNwrn6pQjxbyZ-rH6TZ_5JuWszY1LTE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169745>

Dear all,

=A0I tried a rebase of my local branch (say 'local') against master.
Here is what I did:

$ git checkout local
$ git rebase -s ours master
=2E..
Already applied: 0017 smore more work
/usr/lib/git-core/git-rebase: 590: cannot open
/home/mathieu/dummy/.git/rebase-merge/rewritten: No such file
All done.

I have no idea on how to get back to the initial state. Where did my
'local' branch go ? Using git 1.7.2.3

I can find some references:

$ cd .git && grep -lr "smore more work" *
logs/refs/heads/progresscallback
logs/HEAD

Thanks a bunch !
--=20
Mathieu
