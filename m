From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 2 Dec 2010 12:14:25 -0600
Message-ID: <20101202181425.GG3962@burratino>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
 <7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
 <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:14:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODg2-0002UN-LC
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0LBSOh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 13:14:37 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53037 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab0LBSOg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 13:14:36 -0500
Received: by vws16 with SMTP id 16so1220268vws.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=njgHnV+jym2UyKzkmhujHwUXwrrxZnMvsuSRq5UOdGA=;
        b=EatlPi6jekCcWfJxbOE9i7NREM/eO26O6P5i3baN8uImtCDzhAK1gVxDbXTvUaZMUl
         LinTu7rbHOSdxcvwl3ubsjHIuvwShNNt9kAqqdlfLQo2JM/4YxtRARGToFDupiZqcbyJ
         bWga4OlPR5M+BKfN0XV1mNhfWv77eLq5oujsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AfpYlf82WvToFLLzsplDaHGUJ0rM8naAcsjoFkgUoNlf4OIFcQrG8p5xt9a/ICmj8T
         BJ3eHJV16AIjI0T0ICCkNjjoFzuqMug0nA/iNdwkMXqlYpkYkrr1zfXf6epAJ+1gkwrI
         rTI6XzSeqhgDSOlYvk28xVgD09fztUw4i42jk=
Received: by 10.220.186.10 with SMTP id cq10mr114984vcb.111.1291313676150;
        Thu, 02 Dec 2010 10:14:36 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id l5sm117244vcr.38.2010.12.02.10.14.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 10:14:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162724>

demerphq wrote:
> On 2 December 2010 18:46, Junio C Hamano <gitster@pobox.com> wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> Why are you using it? It's for internal use only.
>>
>> That is not a valid question nor answer, I am afraid.
>
> So you are saying that it is for more than internal use?

I assume so.  I had guessed the same thing (that it is meant to be
generally useful), based on the following:

 - it is installed to be usable with a simple "use Git"
   automatically

 - "perldoc Git" tells me that this module gives Perl scripts an easy
   way to interface the Git version control system, not that it is an
   implementation artifact

 - tools like "git svn" were not historically part of core git, and
   usage by them was not exactly internal use.

Hope that helps.
Jonathan
