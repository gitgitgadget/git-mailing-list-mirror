From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 18:27:30 +0200
Message-ID: <AANLkTi=D19oucaPu6rZQeVjLetgY+s5_-q+n1Lb4oijo@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<87k4h34bhj.fsf@catnip.gol.com>
	<7vr5bbupj4.fsf@alter.siamese.dyndns.org>
	<AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
	<4D58D2DF.1050205@viscovery.net>
	<AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
	<4D5906FD.7030502@drmicha.warpmail.net>
	<AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
	<4D59316E.5090203@drmicha.warpmail.net>
	<AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>
	<4D594911.40409@drmicha.warpmail.net>
	<AANLkTi=cvObd83_5qiUxLKmVxiTMP2kgMfXaRb3uo4YY@mail.gmail.com>
	<4D59528F.6030202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 17:27:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp1HB-0003Lv-K4
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 17:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab1BNQ1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 11:27:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48527 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab1BNQ1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 11:27:42 -0500
Received: by fxm20 with SMTP id 20so5401091fxm.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 08:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dkH4AcR6cRU8JhAF0CZlq6vFBV7t0vg3u+YtV7P9pf0=;
        b=dd/AgLajgioHT/2gPDKWQ97Y4AkmTi78czSe0nx4ln38NdByKMapnhr80RYyWN2+zs
         yJIFyoLhBcl5/B0cxVhoSnqFzFqPn981tNaGaPexNB1Cj6mKJjsIWVe3I3KT8K6YifDU
         EjZ+MCICyRK4LCgQXgz3L+3zgLOZdDjv81jJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=a4GMNdurG/bgZ0+tGRSNYOtAPOg3TJUUX+ZlWNYLBsgWD2u61pm3YACkDTgcHm/Ltx
         vOfh8Qb+zgdHNdguV/+5EwykhrXNLQdv+nU9+nc7LM8x6uanUFmB6FJU40CtrH/5fROo
         0G95ucH0sg8cClQ4sLHsNCjZ4Bs3XcS+h1Mng=
Received: by 10.223.73.202 with SMTP id r10mr5017664faj.133.1297700850879;
 Mon, 14 Feb 2011 08:27:30 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 14 Feb 2011 08:27:30 -0800 (PST)
In-Reply-To: <4D59528F.6030202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166732>

On Mon, Feb 14, 2011 at 6:04 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 14.02.2011 17:00:
>> Except 'git branch', 'git tag', 'git remote', 'git stash', and 'git
>> submodule'. In fact, every logical object in git seems to have their
>> own command, except the stage.
>
> Yes, remote, stash and submodule are the ones with the different
> subcommand handling I mentioned: the subcommand is the verb, and
> specified undashed.
>
> We have other commands with double-dashed (i.e. option) subcommands,
> such as "brach --set-upstream", and others single-dashed, such as "tag -v".
>
> Note that branch, tag and stash are verbs as well as nouns.

So is stage.

-- 
Felipe Contreras
