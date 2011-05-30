From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref:
 refs/remotes/origin/master
Date: Mon, 30 May 2011 09:52:04 -0500
Message-ID: <20110530145203.GA10879@elie>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie>
 <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 16:52:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR3pO-00060u-JL
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 16:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab1E3OwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 10:52:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40833 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757224Ab1E3OwO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 10:52:14 -0400
Received: by iyb14 with SMTP id 14so3008541iyb.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=h9Zw9sN2752RLsoGP++ZUlxqDPF9vN57FdE4nkxUJcw=;
        b=TrKj2XnmRmTlwNsr6zltx35pwbkU+TV5FBu5HQSEpS0hD+04QfNbB270+VTnVT3AkN
         BUUi8/jN5lWNEdhZ5VWmxTnEZHTlu777qEjnlHnyw3vBBRI2E4qVI6wyiKJHKomEMaCT
         uX3sfK69zv5Pc1r+uiguY6ZETsB5YFzrZo4vE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sKbwnus6y+MpjlHJEbqSufoUmdxV4D3LK8nbaijLdxZYDfmJzg5w89RuPgKBqZU5Ja
         r1XOZhqJIlITipB6QSuW7o6gnjh69hCyiZHJapp1KSG9TusYaq+28vlMFDF4cQgLZEvK
         5cEVGSYrmoYhr7BH/RO75JAxXsaNK2w+uxbbM=
Received: by 10.42.152.74 with SMTP id h10mr8728907icw.484.1306767133751;
        Mon, 30 May 2011 07:52:13 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id d6sm1280560ibj.57.2011.05.30.07.52.09
        (version=SSLv3 cipher=OTHER);
        Mon, 30 May 2011 07:52:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174752>

J=C3=A9r=C3=A9mie NIKAES wrote:
>> J=C3=A9r=C3=A9mie NIKAES wrote:

>>> a "Warning duplicated
>>> ref: refs/remotes/origin/master" is thrown.
[...]
> No, I actually still have the problem. The version commited on github
> is pulling revisions straight to refs/heads/master which is gross
> After discussing this matter with our teacher Matthieu Moy, I wanted
> to change this to refs/remotes/origin/master but then this warning
> gets thrown.

Could you push a branch exhibiting the problem?  The reason I ask
is that searching with

	git grep -F -e 'duplicated ref' origin/master

in git.git yields no hits for me, so I wanted to reproduce this to get
the exact error message or figure out which program is printing it.

Thanks.
