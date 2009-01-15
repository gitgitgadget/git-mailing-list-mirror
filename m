From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: git submodule merge madness
Date: Thu, 15 Jan 2009 01:32:31 +0100
Message-ID: <bd6139dc0901141632x6d3a0b6bl3abd489e155dc97d@mail.gmail.com>
References: <ADC7A3B1-6756-4258-93CD-DB40C7D2793C@develooper.com>
	 <alpine.DEB.1.00.0901142354120.3586@pacific.mpi-cbg.de>
	 <AE1922C4-0543-424B-A635-494445E17E45@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?=" <ask@develooper.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:33:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGBJ-0004fa-HF
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247AbZAOAce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 19:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758082AbZAOAcd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:32:33 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:44743 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757631AbZAOAcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 19:32:32 -0500
Received: by yw-out-2324.google.com with SMTP id 9so360829ywe.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 16:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=9yNhXqyrG6IciK7IgC97yyp/VpTMgsqsI55ienNU+/k=;
        b=HsfmHuo4wcCI/MNWWAPI/3JbuOfHJd2dCn5clcm12PkTZBwTvbRQ56ciIerojvl+rq
         SFF0PPSOlLKbKu3e33T1b+/F22QfA+lx9VAZVMmjVneIcKlI1HA25UruKCI/P113rZeY
         cO6HTj721Jgwhu5JOrWVrPLuZ6N1k7cofkEN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=TSwldeVYJLyrYliretq2gZ/S1sG6xXF9IBoY5Yuysf5jyXiJW3SWU5bu678bQ8Cg0d
         9Yfl195BZd+Olyyzug45R93UWqUawSNoQkuFgfAKqoGPMvtNLyDZ2PxDAKgPuEDqa7Ip
         j2GOXxfHdEGvgVdKdoeMOnuirzxx9tvlMAjpk=
Received: by 10.151.111.1 with SMTP id o1mr2833659ybm.215.1231979551565;
        Wed, 14 Jan 2009 16:32:31 -0800 (PST)
Received: by 10.150.198.12 with HTTP; Wed, 14 Jan 2009 16:32:31 -0800 (PST)
In-Reply-To: <AE1922C4-0543-424B-A635-494445E17E45@develooper.com>
Content-Disposition: inline
X-Google-Sender-Auth: a2b8ef4dda87dfad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105740>

On Thu, Jan 15, 2009 at 00:49, Ask Bj=F8rn Hansen <ask@develooper.com> =
wrote:
> On Jan 14, 2009, at 2:55 PM, Johannes Schindelin wrote:
>> So.... Which Git version are you are using?  Did you test any Git ve=
rsion
>> containing the commit d5a84fb(merge-recursive: fail gracefully with
>> directory/submodule conflicts)?
>
> IIRC I tried 1.6.1 and master as of about a week ago.
>
> I don't see d5a84fb in my repository (and google doesn't find it refe=
renced
> anywhere when I search for "directory/submodule conflicts".

I checked current master:
$ git log --grep=3D"fail gracefully with"
returns nothing. Searching the archive I don't see any reference to
"fail gracefully with" either. I don't see it on your gitweb [0]
either. Did that commit magically dissapear?

[0] http://repo.or.cz/w/git/dscho.git

--=20
Cheers,

Sverre Rabbelier
