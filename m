From: Pat Notz <patnotz@gmail.com>
Subject: Re: Output from git diff
Date: Wed, 29 Jul 2009 11:29:02 -0600
Message-ID: <1cd1989b0907291029r2efd78br3506ded03dedf438@mail.gmail.com>
References: <87hbwxaolw.fsf@krank.kagedal.org>
	 <873a8fflt2.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Jul 29 19:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWD5f-0007W1-3N
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 19:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbZG2RhN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 13:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbZG2RhN
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 13:37:13 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62381 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbZG2RhM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 13:37:12 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 13:37:12 EDT
Received: by mail-ew0-f214.google.com with SMTP id 10so146547ewy.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LYGwV/cvPcPjlUYjTfRV4gBFUcjFV8+s1LUwOcT/81k=;
        b=tz/RYxhAe+H7bMd1W1hw9BZhZZEbgxVxrVCpHFBjbU77vC54fuJYAaVwV5KCZLk405
         b+QzPHhcWrpIBk+E0hO0txUspz1Q/NO/VExj9aZBQpiB8p5LUdIidEyFdmUyBnK7SAct
         ba5Wven2QFz+V0RMnaaRR7MhlU1skCJwR1MTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CfW99fR6vPTPb1FyYtIPj5c65StivElkMomiAhik472aW0roOtt88m/rto8JZZBcma
         UXVuMsXijWTHIYpD6Lrx8oTUHPdGWNwrFewhLGl0SSinkjcp7paH0Yz4DlrKcwYw8jGf
         s1J8ZI0qwg41IMxCM91ORTHEzHxy33TQRRcoo=
Received: by 10.210.19.7 with SMTP id 7mr296485ebs.52.1248888542949; Wed, 29 
	Jul 2009 10:29:02 -0700 (PDT)
In-Reply-To: <873a8fflt2.fsf@krank.kagedal.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124374>

On Wed, Jul 29, 2009 at 11:20 AM, David K=E5gedal<davidk@lysator.liu.se=
> wrote:
> Here is another diff output question. The updated documentation in
> diff-format.txt still claims that the output from the diff commands
> has this format:
>
> :100644 100644 bcd1234... 0123456... M file0
>
> This is true for "git diff --raw", but diff-tree and friends print
> full 40-char hashes.
>
> I can get diff-tree to use abbreviated hashes with --abbrev, but how
> do I tell diff to stop abbreviating?

Probably not the answer you *really* want but 'git diff --raw
--abbrev=3D40' will give you the full sha1

>
> And what should the documentation really say?
>
> --
> David K=E5gedal
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
