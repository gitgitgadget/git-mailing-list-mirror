From: Doug Ireton <dougireton@gmail.com>
Subject: =?windows-1252?Q?How_can_I_get_full_filenames_from_Git_difftool_=28for_?=
	=?windows-1252?Q?Microsoft_Word_=93Compare_Documents=94_feature=29=3F?=
Date: Sun, 13 Dec 2009 22:25:30 -0800
Message-ID: <b507cb050912132225j1bdc39c2v42a3bf6bddf1cb1a@mail.gmail.com>
References: <b507cb050912132222x7e1daa9cw73b13f3db0ee22c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 07:25:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK4NG-0000i7-5I
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 07:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbZLNGZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 01:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbZLNGZd
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 01:25:33 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60402 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbZLNGZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 01:25:32 -0500
Received: by bwz27 with SMTP id 27so1773139bwz.21
        for <git@vger.kernel.org>; Sun, 13 Dec 2009 22:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=1FGu3CaTD0VxeB7AEE1zuIzZ6fJk66GqTqZptIOzCsc=;
        b=xXTLkh0RZRQv2kAAA1ln5Wt5e7+PkcR8t0uH+VYrME+MFOis70un1K39bBMk5DrYHM
         MKm9KvE/xarKpSJrGDS0wKeDlE4uKYVaP8nV4hc6jUCSNT9sZF7uWhw4+wZfVmlbVWVI
         5T2nMBjAzgLABD6RYpt8xkRyPWnqy6sF4Ku8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ZpZRva6HCKimDCocfyvSkkAdH/1EbJXeq7kimjxHiWJ1s1tU++1wqMpHwB3OMaAOnp
         FAYEz0n6Hz+Tj1R0f4KHZYLXtjftK2NHcgcm7N0ehpjfmH9Yael4bkJRl66yY9fNqcal
         9moWWd4NiBVdzOoU4dOJRjrtjY6tGw0oPDEMs=
Received: by 10.204.7.213 with SMTP id e21mr208105bke.151.1260771930873; Sun, 
	13 Dec 2009 22:25:30 -0800 (PST)
In-Reply-To: <b507cb050912132222x7e1daa9cw73b13f3db0ee22c6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135169>

I am using the latest version of=A0Git (1.6.6)=A0on a Mac. My wife want=
s
to use Git to manage her fiction writing as long as she can still use
Microsoft Word 2008=A0(Mac). Instead of pushing her into saving
everything as plain text, I would like to use Git Difftool to pass the
files to Word and use Word's Compare Documents feature. She wouldn't
be able to use Git Diff since Word docs are binary files but she could
still use Git Difftool.

I have written an Applescript which takes two filenames in this
format: /Users/foo/Documents/my_novel.docx and opens Word to do the
file comparison. However, Git Difftool seems to only pass the bare
filenames (e.g. my_novel.docx) as parameters.

Is there anyway to get the full filenames from Git Difftool?

Thanks,

Doug Ireton
