From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Applying the changes of a specific commit from one branch to 
	another.
Date: Mon, 2 Mar 2009 14:58:18 +1300
Message-ID: <a038bef50903011758v11706f27v897df8b6d0d9ca7c@mail.gmail.com>
References: <22280717.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: NewToGit <omarnetbox@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 02:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdxRd-0007HK-Ej
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 02:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbZCBB6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 20:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbZCBB6U
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 20:58:20 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:54085 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZCBB6U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 20:58:20 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1095712wah.21
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 17:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7DLVcUDiYzUMJh9RdmdmqfWUB/FgfwWvFq0r00v9cbc=;
        b=UP9Vwe09yknxPHRN+pXFVeRRD2HUwI5ejqPuizFssVDYKBHNZBtkCRe3c4QqwCKQ2p
         DSWjSboApnzuZsj2nTkNNktmyhdz4joz5VGP+N/JdevbBkCaBPAn6FnH0Fh0XZ0ELQqU
         R0j0GUY7bK3UNDmeDSoJxqLUsFB2RtCkY6nEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DcSqHzXCiXMur+GZy8larZ7kz7BnHO3wbteWGbLD+i61t5mNELdmlzIyyyefX2WVPH
         XxIG8lDnuwK8VCdl2bzxyCgg6Y79P763C0RCF1BKSnRNhwuU+jHik2ztOT9pddnvHDzk
         xCOXBcITEuCLEkFKkqDkpvPPGccN/I4ntGVwY=
Received: by 10.114.169.20 with SMTP id r20mr2399475wae.110.1235959098537; 
	Sun, 01 Mar 2009 17:58:18 -0800 (PST)
In-Reply-To: <22280717.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111900>

On Mon, Mar 2, 2009 at 2:44 PM, NewToGit <omarnetbox@gmail.com> wrote:
> Scenario:
>
> - branched off master and created story123 branch.
> - made three separate change commits to story123:
> =A0 =A0 =A0 =A0- 'fixed bug123'
> =A0 =A0 =A0 =A0- 'fixed bug456'
> =A0 =A0 =A0 =A0- 'fixed bug789'
>
> - now I realized that I need to apply only one commit 'fixed bug789' =
to
> master
>
> Question: What's the best way to go about doing this?
>

What you want to do is "cherry-pick" the commit 'fixed bug789'. With
git there are several ways to do this but the one I'd use is the
cherry-pick functionality of gitk.

git checkout master
gitk --all
<right click on the 'fixed bug789' commit and select "cherry-pick this =
commit">

Like I say there are plenty of ways to do something like this. I'm
sure you'll get plenty more responses.
