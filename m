From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 21 Aug 2011 18:53:57 -0700
Message-ID: <CAE1pOi1AnDLY6GUaDSK-YKbV=eRnusnOeOZK-BOb=PbYJMrSSg@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
	<7vvctvdf5r.fsf@alter.siamese.dyndns.org>
	<CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
	<CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
	<CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
	<CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com>
	<CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
	<CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
	<CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
	<CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 03:54:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvJiF-0005RW-HE
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 03:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab1HVBx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 21:53:58 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:63521 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360Ab1HVBx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 21:53:58 -0400
Received: by yie30 with SMTP id 30so3275854yie.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 18:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1mJ1St4dvM9T6AuKbpq+/xNZKYFnbPPk0ErCKb2NTY8=;
        b=rmxq3q2F485xc4EZfVx5fV/XptMxsAiLBPyrMdgHztcUZp2RviEzBSG0MeBn5oTVvS
         scUeJQvBygXNsOZvo+MM7C6puFeAE5U09+AEjRJhCwC8h3jai4cihTZXqbufvGUVG31H
         vLAbwAufIs6qy1Jz9ZBzR86OcJtpL7NyQ11aM=
Received: by 10.236.136.135 with SMTP id w7mr10886497yhi.51.1313978037614;
 Sun, 21 Aug 2011 18:53:57 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Sun, 21 Aug 2011 18:53:57 -0700 (PDT)
In-Reply-To: <CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179831>

On 21 August 2011 17:47, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> And I'm getting quite close with "git ls-files -io --exclude-standard
> --directory". :-) The cobbling-together-of-components approach looks
> promising. ;-)

Wow, it looks like this sort functionality is already available in
Git. I just cloned the Git repo and git stash now has (in master) two
new options: -u|--include-untracked and -a|--all. It looks like my
wish is about to come true. :-)
