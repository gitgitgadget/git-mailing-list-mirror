From: knittl <knittl89@googlemail.com>
Subject: Re: How to do a fast-forward merge without a checkout?
Date: Mon, 18 Jul 2011 18:08:16 +0200
Message-ID: <CACx-yZ1H5UfA9SeaGy-Ph+20BEsewJe7_78wQsr92Y09skSWHA@mail.gmail.com>
References: <CAF_dkJCvtVqoDmRXMy23ZnZL6iUAVX0nNA9Ev6e4zvBp9mfTpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 18:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiqN8-000612-A3
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab1GRQIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 12:08:37 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61534 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1GRQIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 12:08:36 -0400
Received: by vxh35 with SMTP id 35so1727530vxh.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4dShBbUhuozY2H2X1Wz0YJ69iOjnyJ5E8Yb03jpxEV8=;
        b=rR1cUvutRYDSE98fLF8pke3KY9AqkLF3W3ooBEtgQn8GdhDZOQhBoNJWwPpdmt5wnw
         hT0zN9YXO971UbKHC7hUG92DREfMXw1BOMnbLK6epFBvIOCmYVF4GKI1MyZH+U3Egbok
         5nfQhqviJCZ2sWaq7/3hO5fjvRaTnH/9fIu8M=
Received: by 10.52.92.233 with SMTP id cp9mr6458630vdb.421.1311005316097; Mon,
 18 Jul 2011 09:08:36 -0700 (PDT)
Received: by 10.52.106.163 with HTTP; Mon, 18 Jul 2011 09:08:16 -0700 (PDT)
In-Reply-To: <CAF_dkJCvtVqoDmRXMy23ZnZL6iUAVX0nNA9Ev6e4zvBp9mfTpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177379>

On Mon, Jul 18, 2011 at 4:18 PM, Patrick Doyle <wpdster@gmail.com> wrot=
e:
> [=85]
>
> $ git push
> [=85]
> To somehost:path/to/repo
> =A0 e1004df..bad8767 =A0wpd -> wpd
> =A0! [rejected] =A0 =A0 =A0 =A0master -> master (non-fast-forward)
> error: failed to push some refs to 'somehost:path/to/repo'
> To prevent you from losing history, non-fast-forward updates were rej=
ected
> Merge the remote changes (e.g. 'git pull') before pushing again. =A0S=
ee the
> 'Note about fast-forwards' section of 'git push --help' for details.
>

another way to avoid pushing the master branch is to explicitely name
the branch to push (wpd):

    $ git push origin wpd

cheers, daniel

--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
