From: Thomas Anderson <zelnaga@gmail.com>
Subject: Re: a few beginner git questions
Date: Sat, 6 Mar 2010 23:02:20 -0600
Message-ID: <15b345f1003062102l22ac2d2fn3ed5b73221bf4216@mail.gmail.com>
References: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
	 <20100306070533.GL2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 06:02:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8dH-0002Jd-0F
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163Ab0CGFCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:02:22 -0500
Received: from mail-px0-f188.google.com ([209.85.216.188]:53875 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab0CGFCV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Mar 2010 00:02:21 -0500
Received: by pxi26 with SMTP id 26so1738629pxi.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gQoHV2SjKtzl7hwBfDZpct/xZmtrc+KHlcdfop2IKSU=;
        b=br1sMc52GiA5IYaxEKAJnWFTxHRBUf0WWo+BhhaJzZE2ukpr7RAxsT8DYuHu2crMMA
         4XTVm46XDDBIowCNQXo5o7qbdqdTRZe1SnbkO7phFIBN/Fiis21bNtvy/y5ES2dq52bg
         kJ+fUyxAHsaK4coitz0gN6qsHlatmSace0l10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wyRwQAiCG21VrVfbzW7ldqpzSMrhcKnlYWIA/sAYm5ciZUq2Glidf0QWMkakPFVgTL
         X7pIwJ90qbEOHd+LK2RwR1sLl9z4rzwH4LyFrGJ+bk5yL/LjRjlB0fEPxrPrunxtLipM
         FXoE7nAMDQrrsNc4qo0cgN8aQvljhuOCJSBrc=
Received: by 10.142.152.6 with SMTP id z6mr2055944wfd.214.1267938140999; Sat, 
	06 Mar 2010 21:02:20 -0800 (PST)
In-Reply-To: <20100306070533.GL2480@ece.pdx.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141662>

On Sat, Mar 6, 2010 at 1:05 AM, Tait <git.git@t41t.com> wrote:
>> 4. I clone git://github.com/symfony/symfony.git to c:\git\test\root
>> and clone that to c:\git\test\clone. =A0I then blank
>> c:\git\test\clone\README, stage it, commit it and push it and the
>> change does not appear in c:\git\test\root\README. =A0I then reopen =
Git
>> Gui and open root and there I see the blanked README as an uncommite=
d
>> state change. =A0I commit it and the change still does not appear in
>> c:\git\test\root\README. =A0Is this what Git should be doing?
>
> You shouldn't push into a non-bare repository (unless you know what y=
ou're
> doing and really mean it). This:
> =A0 =A0 =A0 =A0http://git.wiki.kernel.org/index.php/GitFaq#Why_won.27=
t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F
> explains a bit more on the subject.

How, then, do I update code?  ie. I perform my initial clone, make
some changes and commit / push them.  Someone else then comes along,
makes some changes and commits them.  The next day, I do Remote ->
=46etch from -> origin to update my code to the latest in Git but
c:\git\test\clone\README is exactly the same as it was before.  How do
I update the initial clone such that I can edit the updated files?
