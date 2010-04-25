From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 22:33:41 -0500
Message-ID: <20100425033340.GA20921@progeny.tock>
References: <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221651590.7232@xanadu.home>
 <87vdbitu9v.fsf@frosties.localdomain>
 <25441792-181D-456D-8182-F33B49209EFF@wincent.com>
 <87aastx6sa.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004231639180.7232@xanadu.home>
 <8739yktuvs.fsf@frosties.localdomain>
 <20100424214024.GA8044@progeny.tock>
 <87mxwsgser.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Apr 25 05:33:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5sb1-0005i6-S2
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 05:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab0DYDdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 23:33:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49529 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab0DYDdG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 23:33:06 -0400
Received: by gwj19 with SMTP id 19so3388003gwj.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 20:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kt62kw0/yr/nyRSUpgK4Nosr+eC82YP/eNiCiYb7sus=;
        b=VY/WEuQEzsHkpdteJLivncMD7oPl25Ib6ocWY6acBHWjyFETlWDU96caoFWQX9l6mk
         uEa4n9KeVIxN9yWqld2bgD+EQ05MWpntmB/0ZwO6ScwBkSQfAxDGfu+9Llw1o+y96QZL
         MoZ1xIpZl4fYRMVhajiwrRwKe2s8RzJfIQxZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=v2pTpr64DRHZrnVIsNB7ijU40FVuq34+tLEkzEy3m4JvlI3ZPOH5fS7T8CuAP8mwUw
         DFkhqpkYcD0LFcwCUoiNmCweJIbPfCVxOt8ZbDppPrjcuClhhGq3AwG6kaJs7Gid+jBv
         Lf/Nvj/G2fDqz3bRAmxvs2WD9uxoa8zNZB7hs=
Received: by 10.101.130.5 with SMTP id h5mr2673050ann.54.1272166382975;
        Sat, 24 Apr 2010 20:33:02 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1996009iwn.7.2010.04.24.20.33.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 20:33:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87mxwsgser.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145717>

Miles Bader wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> But dense as I am, I still can=E2=80=99t imagine why
>>
>> echo '[alias] ci =3D commit -a' >>$HOME/.gitconfig
>>
>> wouldn=E2=80=99t be better in every way (especially if Jakub=E2=80=99=
s
>> commit.preserveindex is enabled).
>
> If the latter is enabled, you can't use "git add" to add new files,
> you'll have to remember to use "add -N" (or add some alias for that
> too).

Didn=E2=80=99t he first [1] propose a variant in which using =E2=80=98g=
it add -N=E2=80=99 was
not necessary?  The rule was something like this: consider each entry.
If it

 - matches HEAD, or
 - matches the work tree, or
 - is an intent-to-add

then we say it is easily recoverable.  If all index entries are
easily recoverable, then let the commit -a go through.

Jonathan

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/69800=
1/focus=3D145662
