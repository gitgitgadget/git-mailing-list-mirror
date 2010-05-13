From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [remote rejected] master -> master (n/a (unpacker error))
Date: Thu, 13 May 2010 05:30:43 -0400
Message-ID: <AANLkTilz_gbHl_RLyOuvEIdjPoUDIfZTUCpnswdHTiej@mail.gmail.com>
References: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
	 <20100513005218.GA20655@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 11:30:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCUkn-0007TT-2M
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 11:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab0EMJar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 05:30:47 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44270 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab0EMJaq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 05:30:46 -0400
Received: by wwi18 with SMTP id 18so693660wwi.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Q8N130Zz+J1DwJ6WylsqSfre/Ah1erwoS9yng/u0jbw=;
        b=qsgTskkjJoMr9BQkcxa+vxSyJ9DKGvWybUO0vgmDVoWThVqKwQhZlSko1hhPBY8YSx
         d9xK+DQIS6xGdxWpzrSQAoirMM6BUI5LuZa9mOYTxmzgW4U2AEO9wZxHiAZZ3SfYUlc2
         A7v8Gxm3bIaiRvdJ7bGfKoOzsi55nPcdrqGqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XeqbEZrw1HoT0dSBiMPuL4i8uRwLkS5Ndbt1sHJ6vvS0ypMNqrta5U25YSfUpYEhGJ
         qL+rTdoqmiyMTZRlsvYfkmL2/mxSFMJ+gsP2yXM7OdN87hlxz6+8GjfaOGUWpZ1qYgxA
         4GXpemoeKwOAtJ2sT20LLmFx0Jydg1gZj+vCE=
Received: by 10.216.185.78 with SMTP id t56mr574299wem.40.1273743043691; Thu, 
	13 May 2010 02:30:43 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Thu, 13 May 2010 02:30:43 -0700 (PDT)
In-Reply-To: <20100513005218.GA20655@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146983>

Thanks.

Yes, the repository is shared by several people, and in geographically
different locations, ssh-ing to the same host, under different groups.
So your recommendation would be to use --shared. But this won't work
so well out in the wild will it? Meaning, what if people's accounts
are NOT under the same group that is?

It would sound to me like in general, when one goes to production with
a git environment that some sort of chrooted account is preferable if
not highly recommended?

Bob
