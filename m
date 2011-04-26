From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: RFC: Folder Git
Date: Tue, 26 Apr 2011 08:59:31 +0200
Message-ID: <BANLkTinK40EQzog6WyZCyUGKN4DpYJ-YwA@mail.gmail.com>
References: <BANLkTim=xKxN9JovToVuOg=SQ2Mba1LvxQ@mail.gmail.com>
	<m3fwp6wr7h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 08:59:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEcFH-0008Ad-2T
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 08:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496Ab1DZG7d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 02:59:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43424 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059Ab1DZG7c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 02:59:32 -0400
Received: by bwz15 with SMTP id 15so268256bwz.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Pmiw0oUJGetNnKlHGAdgbk6XsDtF38gQvShsL7uQbU=;
        b=Kx18s5yX7WyuJhvQn2iE+Qh7fEwuGZLSNoE4iTB4/MHAJq2Ztr+ENW0H/WXa/X4xtD
         Ss6oJOrW/lU7yqwZ6I1Nb2xv+oHjVy1H0xJKrsCl5Irw9RUwyJ5R79jgLZzZyn72lgyF
         G2YToHzkiJbDYXa62JLxw54gTrvpCb3QSSrUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mEjmc2CgakTxsv6ogOoaK44XpVA8id4kiREk8xbaZlhHtS+5okYpt0QIC+zi+nMxd0
         RwJ3kWR+CqzZmSF+PtDo1MuEkD2dAeoQA3yvWfagTbsHNtmz7l873JJNw67MYqH+F9zu
         tZ82iFSm7GD6PZdvsYxXsfCDgEd+OjMaLUC4k=
Received: by 10.204.81.203 with SMTP id y11mr337167bkk.124.1303801171242; Mon,
 25 Apr 2011 23:59:31 -0700 (PDT)
Received: by 10.204.48.143 with HTTP; Mon, 25 Apr 2011 23:59:31 -0700 (PDT)
In-Reply-To: <m3fwp6wr7h.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172070>

On Mon, Apr 25, 2011 at 12:39 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> Victor Engmark <victor.engmark@gmail.com> writes:
>
> [...]
>> I wrote a script for it: fgit
>> <https://github.com/l0b0/fgit/blob/master/fgit.sh>. Features include=
:
>> * Runs the Git command given in all specified directories which have=
 a
>> .git subdirectory, and warns about any that lack this directory.
>> * Should work with any path, containing spaces, newlines or other
>> exotic characters.
>> * Should work with any Git command that doesn't require the "--"
>> separator between the options and arguments.
>> * Prints the Git command before running it, for logging and repetiti=
on.
>> * errexit and nounset are active for each line, with one exception:
>> errexit is disabled for the running of the command, to allow it to
>> continue to other repositories.
>
> Do you think this tool is mature and stable enough to add it to
>
> =C2=A0https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndToo=
ls
>
> page on Git Wiki?

It's already there, so I guess someone thought it was :) I'll try to
fix the description as soon as the web page works with Firefox (I
could only load the contents with wget).

--=20
Victor Engmark
