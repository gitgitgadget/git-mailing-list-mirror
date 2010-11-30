From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: http://tech.slashdot.org/comments.pl?sid=1885890&cid=34358134
Date: Tue, 30 Nov 2010 09:43:50 +0000
Message-ID: <1291110230.11984.21.camel@wpalmer.simply-domain>
References: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>
	 <AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>
	 <AANLkTima6meFsovFS-15X7CMTD53n=kkvueKrOeN4Yd4@mail.gmail.com>
	 <AANLkTi=aCRGNtKxrPLH81H8_NvpBNOmJ-0MHgRms2a3T@mail.gmail.com>
	 <1291025571.4262.21.camel@wpalmer.simply-domain>
	 <4CF3FEB0.9040806@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Nov 30 10:44:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNMkl-000670-AY
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 10:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab0K3Jn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 04:43:58 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49878 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab0K3Jn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 04:43:56 -0500
Received: by wwa36 with SMTP id 36so5841903wwa.1
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 01:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=v4a4vb7/7Xn6kQ3yiqNnl7jS4dS2WeU3uZyZAXJWWKE=;
        b=Uqyo5sTEkfNnYtga8LjTvs3T9fcm8LBP5b2U/Csa9T1VGTVHn7NXDUiCG+k3GHTxGS
         UDfec5SqK5DS6EBRby+A8aigaWhfDzHJzorcksvDVtdEp3RlaNUI8jjGEPnAXcFJwq1F
         w2BWF+Buq4ftCbRAIYlYKkq5nZQzd2qBlgTSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=jc/4kb7eTom4cZuIc+boj3KILv7zkInPMM2AdPBrecEOMUOP02ktUFofD8SdhwVyYw
         gpHHtnN2RZTzXx2AjetUFtCedinTqtnkv+T+mR8KlAvtIKiF4uhU4aH/hRa3Zu8g0Kqz
         lYERaeNgwG5tHSv9ie6dkAAH/K4+G4Iw0CLGc=
Received: by 10.227.133.135 with SMTP id f7mr7459909wbt.117.1291110234694;
        Tue, 30 Nov 2010 01:43:54 -0800 (PST)
Received: from [192.168.2.128] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id x6sm2877535weq.37.2010.11.30.01.43.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Nov 2010 01:43:52 -0800 (PST)
In-Reply-To: <4CF3FEB0.9040806@eaglescrag.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162482>

On Mon, 2010-11-29 at 11:27 -0800, J.H. wrote:
> > I want my version control software to use p2p concepts for efficiency. I
> > don't want my version control software to be a p2p client any more than
> > I want my text-editor to be a mail client.
> 
> Keep in mind that adding p2p concepts to something doesn't make it more
> efficient, in fact in most cases it makes it dramatically *LESS* efficient.

As a simple use-case:
Everyone comes into an office in the morning and runs "git remote
update". This potentially causes a lot of traffic between the office and
their offsite central repository. If this were a p2p scenario, the
transfer from the offsite could potentially happen only once.

That counts as "more efficient", to me.

> 
> git-torrent like concepts have come up in the past, and I keep pointing
> out how and why they likely won't be useful.  The biggest reason: there
> is no advantage for a client to stay in the cloud once they have their
> data.  

This is true of bittorrent as well: People stay in the cloud for
altruistic reasons.

You're thinking p2p in terms of "every peer serves data, and keeps
serving data. The network is more robust over time". I'm thinking p2p in
terms of "Every peer has the ability to serve data. Adding a server is
as trivial as adding a client."

The greatest advantage I can think of is "no existing server needs to
agree to the addition of a new server", or at least "the addition of an
existing server is accepted by convention, no questions asked"

> ..... You can force this, sure, but clones are seldom and rare to begin
> with (as you mentioned) so there won't be a very large cloud to pull
> from to start with.  With that in mind, I really see no advantage to p2p
> inside of the git core at all.  It adds a lot of complexity for little gain.

I agree that git itself is not a good place to explore p2p concepts. I
assume it would be much more useful to develop an independent p2p layer
and allow git to somehow use that.
And while there won't be "a large cloud", it's almost a guarantee that
there would be more than the /one/ server currently available during
clones or long fetches.

> Now you do mention things that would be useful:
> 
> - Ability to resume a clone that you only have a partial download for
> (maybe just pack files?)
> - Ability to include something like a 'meta-link' like list of
> repositories to check for data (inferred from the multiple download
> locations)
> 
> There are things we can learn from p2p, but I don't think adding it to
> git is actually useful.
> 
> Just my $0.02 though.
> 
> - John 'Warthog9' Hawley
> 

The biggest hurdle, I assume, would be "get git to talk to more than one
source of data at once", even if one needs to set those up manually. If
I understand correctly, packfiles are generated in a way which would not
necessarily be consistent between clones.
