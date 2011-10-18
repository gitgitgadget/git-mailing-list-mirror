From: Phil Hord <phil.hord@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2011, #06; Tue, 18)
Date: Tue, 18 Oct 2011 10:09:17 -0400
Message-ID: <CABURp0po3C9-a4_cGm8gq71=gq2ELzHWBK0y7H=OEcY1=DUdsw@mail.gmail.com>
References: <7vzkgyhh6n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 16:10:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGAMo-000105-U9
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 16:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267Ab1JROJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 10:09:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35042 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab1JROJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2011 10:09:55 -0400
Received: by wyg36 with SMTP id 36so634690wyg.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JP/G+GCUar5SMXCKAvNiiDMFUfg9v/WAcguBySo10Os=;
        b=gzp3YOv++OJoJ5CZ+tNKR3Wbj4XOg/L93J8cLCBbWpeOcE5w0AcirU0O9FjUWcIq+3
         ZuvDGexwVEhMurXaBx8+b9aSXr6zYvB4MIikC8Sws80D7qNdZPXDFSMfEEFYliIk885v
         2sA3AcvSSaGUvcz5W+wFro8xvLwX4GvhoQ8mE=
Received: by 10.216.229.225 with SMTP id h75mr790435weq.87.1318946977160; Tue,
 18 Oct 2011 07:09:37 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 18 Oct 2011 07:09:17 -0700 (PDT)
In-Reply-To: <7vzkgyhh6n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183883>

On Tue, Oct 18, 2011 at 3:50 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> What's cooking in git.git (Oct 2011, #06; Tue, 18)
> --------------------------------------------------
[...]
> * ph/transport-with-gitfile (2011-10-11) 5 commits
> =A0(merged to 'next' on 2011-10-12 at 6d58417)
> =A0+ Fix is_gitfile() for files too small or larger than PATH_MAX to =
be a gitfile
> =A0(merged to 'next' on 2011-10-06 at 891b8b6)
> =A0+ Add test showing git-fetch groks gitfiles
> =A0+ Teach transport about the gitfile mechanism
> =A0+ Learn to handle gitfiles in enter_repo
> =A0+ enter_repo: do not modify input
>
> Will merge to 'master' in the fifth wave.

Do you want a re-roll of this with your is_bundle() changes added in?
I do like them better.

Phil
