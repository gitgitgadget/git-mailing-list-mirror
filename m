From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the
 remote(-tracking) branch terms
Date: Sun, 24 Oct 2010 10:18:39 -0500
Message-ID: <20101024151839.GA31764@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
 <9A09AA7C-BAE2-4571-8453-17CB3F3256D4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 17:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA2PC-0000F1-AX
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 17:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801Ab0JXPWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 11:22:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33305 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab0JXPWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 11:22:36 -0400
Received: by yxn35 with SMTP id 35so1588834yxn.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jHrc0FR9EcuW6PuM6XyJDWbgxSLeAQ9CszAeJiPvsEg=;
        b=D34SNaFBY7VXO+zmsT4NZmDoY8+4+r8CfiUL6l6mnuqjaFGOhfQXvnVTztNtEbBsny
         VrR+pYB3qa1R76Agh3WkHSErj0iOzgIJDQMwHkjJmA3PZf9Kqg9tTxCNwIIFVRFtIB7a
         Qr8BjPRDiVxHYbRJR0xu+lrteHGzcNynuV6ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Jd3AY6m9PYQbew2PUW4/uMPsrmqqp20Mps2oS/eOrKJzK9b0id6eBYDckqCrFipUgA
         gKMl8ktUFS+oeeAeUh78nLjy83ClaGCLP8VCXTV4uz72HitV1OPDC8dwSJXuxeUFDfVw
         q7q8uUwTecjwubbYP5R7/SNerdgrk3E/9pQoA=
Received: by 10.151.105.19 with SMTP id h19mr10662614ybm.369.1287933755353;
        Sun, 24 Oct 2010 08:22:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q14sm5590284ybk.19.2010.10.24.08.22.33
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 08:22:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9A09AA7C-BAE2-4571-8453-17CB3F3256D4@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159879>

Thore Husfeldt wrote:
> On 23 Oct 2010, at 18:31, Matthieu Moy wrote:

>> +In this case, "origin" is called a remote repository, or "remote" f=
or
>> +short. The branches of this repository are called "remote branches"
>> +from our point of view, and Git will maintain a copy of these
>> +branches, called "remote-tracking branches" in the local repository=
=2E
>
> No. Git does not =E2=80=9Cmaintain a copy of [the remote] branches=E2=
=80=9D. It=E2=80=99s exactly one
> of the pitfalls I fell into: that Git, automagically, puts the *curre=
nt*
> state of the remote branch into remote/branchname, or at least
[...]
> I realise that it would be more constructive for me to suggest a conc=
rete
> improvement, but I=E2=80=99m not quite there yet.

Yes, it really would.  Or could you try to figure out what exactly is
confusing in the wording (for example by giving an interpretation like

	[do a good job at] maintain[ing] a copy of the branches

to indicate which part was confusing)?

As it is, I'm a little confused.  At least according to one interpretat=
ion,
Git does maintain a copy of the remote branches.  This is not tracking =
like
a Basset hound, and it is not maintaining a copy like cron running rsyn=
c
every 5 minutes, but git tracks remote branches like a human and
maintains a copy like a human running rsync whenever she finds time to
get around to it.

Of course, the wording can be improved.  A nice side-effect of clear
suggestions intended to disambiguate one aspect is that they tend to
result in the text becoming clearer in other ways at the same time.
