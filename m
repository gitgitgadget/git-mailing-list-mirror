From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: receive.denyCurrentBranch
Date: Mon, 9 Feb 2009 10:46:15 -0500
Message-ID: <76718490902090746x49e06f54sa409eacf1078ddca@mail.gmail.com>
References: <20090208042910.19079.qmail@science.horizon.com>
	 <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
	 <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
	 <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
	 <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com>
	 <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de>
	 <76718490902081747s7a1ebe12yaf08665429a594c6@mail.gmail.com>
	 <20090209050659.GA12655@mini-me.lan>
	 <alpine.DEB.1.00.0902091204100.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, George Spelvin <linux@horizon.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYML-0003If-Tl
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbZBIPqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755330AbZBIPqS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:46:18 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:40690 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233AbZBIPqR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:46:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1846703rvb.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6AkOboJ4oiioPKlQRcb5SZ8QKThkmYhrWPVPHlUFH80=;
        b=BAnSonRPAcoz+DI/s1umsF5YDc7G12/iGs072jhUL9/Vzk6n0M+NAXpkq1KaxaLkO9
         BSowuqxGaVmLM/Oo/N9vv7LjWIF0UdjHz7JjPgFF4rSq/qxL0m2lglZrv9MFya9KPR7C
         6weIcBUVfPa0+NVtqR6CJT3LjzHZ3JXMNG8gE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pHVzLhfCFOAKwd4D7HcaAylu9e52hfkyyJWiQpvMhP1H1aQI5xZOnF6i17qe0xIKrb
         w0MA0i1YrpueGyl1MiUNr4R4gtkSwdqil3sNOyLA5JTRG/VKJYuyVkRXxvWUWdgP2iP1
         003Jirba9O0DtPOMLAD3ZYgCGMXTrk3Hguwes=
Received: by 10.141.82.20 with SMTP id j20mr3895623rvl.67.1234194376034; Mon, 
	09 Feb 2009 07:46:16 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902091204100.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109084>

On Mon, Feb 9, 2009 at 6:06 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 9 Feb 2009, Theodore Tso wrote:
>>
>>
>> What happens when the next person pushes to the same remote repo, and
>> their refs/heads/master push is not a fast-forward merge of the
>> current refs/remotes/incoming/master?
>>
>> Do you lose the first user's push at that point?  Or do you refuse the
>> push?
>
> This is meant for non-bare repositories, right?  Repositories that do have
> reflogs...

Absolutely. It would be insane on a bare repository.

> P.S.: There _have_ been times when I would have liked an automatic
> PUSH_HEAD that is always temporary, such as FETCH_HEAD.  I _could_ imagine
> that this is something we could do (opt-in, of course): storing what was
> already pushed in a PUSH_HEAD, even if the refs could not be updated.

Oooh. Interesting idea.

j.
