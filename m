From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Wed, 14 Jul 2010 02:22:35 +0200
Message-ID: <20100714002235.GF12639@debian>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <20100713235825.GC12639@debian>
 <20100714001530.GB2308@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 02:21:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYpib-0003GI-D2
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 02:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab0GNAUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 20:20:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47141 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab0GNAUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 20:20:51 -0400
Received: by ewy23 with SMTP id 23so1277015ewy.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 17:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=obiFz+jUkKlcLgODoET2qgDdvd/l5IfswzurVy3zBvE=;
        b=JJXFiwlb7GtN61DrkcGV6KwyV/IwM4I49FfuBhGfnUswtF1n2WxSzWxLQB4g51mU9J
         8LkYt8KPqH+lwFdHqGRVPQq4moqajK0C7HxDDu9HHaYqZDybVqiMJML0bnTco5QVfJCc
         YR8xf0pQ/gS2pFgrOkO1pP5x034bpQld6Gd/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=r5Wl0LNkkFTriqC6aleJ348s7USOzEfzO/gsmoEeeTXgxkDD+1gN90P7ZZrlgThu6L
         yTwkseODComd/+wWK7t4vM+KlKj+Db8B3ryVid7kVsNEYsduOUEi8/DqnRnWk+0vhpJz
         9ibUOYh6DLMVR5xn8E7uF9zZd27YaRNTVPxT8=
Received: by 10.213.16.140 with SMTP id o12mr10157138eba.20.1279066849154;
        Tue, 13 Jul 2010 17:20:49 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm51785356eeh.11.2010.07.13.17.20.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 17:20:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100714001530.GB2308@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150952>

Hi Jonathan,

Jonathan Nieder writes:
> If we are including a convenience copy of files that are (soon to be)
> in svn trunk, I don=E2=80=99t see much reason to diverge from the svn
> version except for API differences and the overhead of updating too
> frequently.

Is licensing an issue? I won't be the copyright holder or the sole
contributor to svnrdump when it's in ASF. Can I just copy-paste from
there into the git.git tree?

-- Ram
