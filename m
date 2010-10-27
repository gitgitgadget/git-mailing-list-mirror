From: Pat Notz <patnotz@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2010, #02; Tue, 26)
Date: Wed, 27 Oct 2010 07:41:13 -0600
Message-ID: <AANLkTimAMxRZYZYWe716YG=S9H=WzjV-TN4KmNqKqpJw@mail.gmail.com>
References: <7v62woduyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 15:41:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB6G5-0000mI-VM
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 15:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761168Ab0J0Nlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 09:41:37 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58366 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0J0Nlf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 09:41:35 -0400
Received: by gwj21 with SMTP id 21so358244gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VYX/AeFUyK5FKj12I6OMRvcs2Gb1x5szvLA7bHTGMJk=;
        b=O4jDxIYuHDpSIkoqmqYZTR2k60X7T5tPPHO8FplaLEJXzab2O9h1/3RDR5t/bd128T
         VnPmc/YerMRmJ0Dnm2HFxi7kZyQVVU0sY8AJxs0P56BZpbpNKhkdQ48g6Er8DvObiutS
         2gYUQeKyYUic1AN2OcEO/vgBe5xgz31XcD924=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hUNRdtpEJ/K7KbPamLbjcsdFJP+CXdJUgcjfokXl94Y8VNMTXG919hJYx1Fo7fBSrI
         3o2WaWHzxBBqDLFyW5x1HebFqS1S5Bo+pL23CtC1yj56MFw08vWGa1ZeRQF2YyjKp74U
         u8ak1NZlqhWreJ0+46aKHO4pVTcn6/j6wQQvo=
Received: by 10.239.162.209 with SMTP id m17mr2601894hbd.10.1288186893211;
 Wed, 27 Oct 2010 06:41:33 -0700 (PDT)
Received: by 10.239.156.143 with HTTP; Wed, 27 Oct 2010 06:41:13 -0700 (PDT)
In-Reply-To: <7v62woduyp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160037>

On Wed, Oct 27, 2010 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> * pn/commit-autosquash (2010-10-07) 8 commits
> =A0- add tests of commit --squash
> =A0- commit: --squash option for use with rebase --autosquash
> =A0- add tests of commit --fixup
> =A0- commit: --fixup option for use with rebase --autosquash
> =A0- pretty.c: teach format_commit_message() to reencode the output
> =A0- pretty.c: helper methods for getting output encodings
> =A0- commit.c: new function for looking up a comit by name
> =A0- commit.c: prefer get_header() to manual searching

This is the v5 patch series... There's a v6 that I think addresses
your concerns with some of the implementation.

http://thread.gmane.org/gmane.comp.version-control.git/159547
