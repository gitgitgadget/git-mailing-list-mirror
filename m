From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Sun, 28 Mar 2010 21:08:45 -0600
Message-ID: <fabb9a1e1003282008x59f64389k95716867a1e7daa5@mail.gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com> 
	<4BAFFFAB.4080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 05:14:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw5RB-0003xl-Ow
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 05:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab0C2DOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 23:14:33 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:55585 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab0C2DOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 23:14:33 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Mar 2010 23:14:32 EDT
Received: by bwz25 with SMTP id 25so8016742bwz.28
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=iOzJGSOX80VWYQZy56gwrIB3g312GhmPOCw2sCIGtnY=;
        b=IKKEfUhGRgLpnjF1f03r1Apmk99pz9thFObxOhceX/mCn0HJSa9h3LaRf8vINIPKjO
         67KX6xpUP58Z6uT9ZZSsnX1krNj+caKiKtZvxHy8cJTNhvnImbm7huN6mUBNpVfW1mLr
         X3rFeC6T3U4b85AuGwhChmvnpDa8hUZhTjzqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xpP27z5UPQHF/sHlysI/rHvOXHtW8VRf3Izt1tJJyhDUZoKFHQLftfcn+8Vv+dGSos
         wg12h/MsAfTB4Gz2cZAInf/Exm3hS3GZ8MHqZfGWgU8bV9HJChvw5uWOo6gplNyp2c6z
         aEPLYwE0JYEd7FGP7fl4F4YHM5ryxwGlFK1nQ=
Received: by 10.204.142.7 with HTTP; Sun, 28 Mar 2010 20:08:45 -0700 (PDT)
In-Reply-To: <4BAFFFAB.4080808@gmail.com>
Received: by 10.204.9.6 with SMTP id j6mr4004859bkj.37.1269832145130; Sun, 28 
	Mar 2010 20:09:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143429>

Heya,

On Sun, Mar 28, 2010 at 19:17, Gabriel Filion <lelutin@gmail.com> wrote:
> Should we add this information on this man page?

Yes we should. Also, I have almost finished a 'testgit' helper, which
simply invokes git-fast-import and git-fast-export behind the scenes.
So it's really a clumsy way to communicate with another git repository
but using the remote-helper import/export API. I've also written tests
for it, so it should be pretty clear from the tests and the simple
helper how to implement your own.

-- 
Cheers,

Sverre Rabbelier
