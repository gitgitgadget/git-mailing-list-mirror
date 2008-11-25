From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Unable to clone empty repositories remotely
Date: Tue, 25 Nov 2008 22:33:48 +0100
Message-ID: <46d6db660811251333u583468e0ma2846796ca9df68d@mail.gmail.com>
References: <837i6rplcd.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Hannu Koivisto" <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Nov 25 22:35:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L55Yp-0004Nw-PL
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 22:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbYKYVdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 16:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYKYVdw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 16:33:52 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:49720 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbYKYVdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 16:33:51 -0500
Received: by ey-out-2122.google.com with SMTP id 6so71440eyi.37
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 13:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xsoMROFniTFJEnrcS+aECyabXaLjeKCS2AwsPdxVUz0=;
        b=xIvR67/xsVSese7f2t4oKd0I003FswkMDb99OJcVninpqjRIRa/QL6FZRs6rQiORBg
         qKVnig4YTiOL4T9jzNpdBp6qx0edYYCApDDlIyjKlEAAetLCaq5u8MfQ+czMtoP9LPM4
         KaN0/A2BQrrAX/EOmss5MF0oDeOv3KZjpYu7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a++D36ktNuuHVzY60+GB4Y1F1IRiVhkhWIbIBaAEk1BWv7xojh05QWF30eJ9YAHvON
         44+5Qe15j7kUH+saJvAUOVJXkLg35cdibQKNAtxKwRyZTcCzPwOdLSfjJzMIyaQf5+RA
         BS4r3h5xzytOWaN1Ierx6gljBhYOwWrpBdkx8=
Received: by 10.103.222.1 with SMTP id z1mr1801102muq.100.1227648828570;
        Tue, 25 Nov 2008 13:33:48 -0800 (PST)
Received: by 10.103.189.18 with HTTP; Tue, 25 Nov 2008 13:33:48 -0800 (PST)
In-Reply-To: <837i6rplcd.fsf@kalahari.s2.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101685>

On Tue, Nov 25, 2008 at 10:05 PM, Hannu Koivisto <azure@iki.fi> wrote:
> Greetings,
>
> mkdir test
> cd test
> git init --bare --shared=group
> cd ..
> git clone test test2
>
> works, though clone says it cannot checkout, which is expected.
> This is nevertheless very useful when you create a shared
> repository for a new project; you can then create a personal clone
> and start adding stuff to it.  If, however, you normally work on
> another machine and want to have your personal clone there
> (i.e. git clone ssh://therepomachine/somewhere/test), cloning
> doesn't work at all (tested with git 1.6.0.3.525.ge32c2 in Cygwin):
>
> Initialized empty Git repository in /cygdrive/c/temp/test/.git/
> fatal: no matching remote head
>
> This behaviour isn't documented by either git-init(1) or
> git-clone(1).  I think it would be very convenient if this worked
> for the reasons mentioned above.  I'm sure you could create your
> personal repository with git init and then git remote add the
> shared repository to it but that's much more difficult.
>
> --
> Hannu
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

how about creating at least 1 empty commit before any cloning ?

wouldn't this solve the problem ?

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
