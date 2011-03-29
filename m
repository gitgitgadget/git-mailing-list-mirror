From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH/RFC 0/9] add long forms for format placeholders
Date: Tue, 29 Mar 2011 08:27:00 +0100
Message-ID: <1301383620.2335.50.camel@dreddbeard>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
	 <7vei5qvkgw.fsf@alter.siamese.dyndns.org>
	 <4D918032.3010608@drmicha.warpmail.net>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:27:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4TKc-0006RM-D7
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab1C2H1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 03:27:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56467 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab1C2H1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 03:27:07 -0400
Received: by wwa36 with SMTP id 36so4738984wwa.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=+8+AbGiIEtZfYShFyizici8oOqAr7T8E/hPyNrHcuE4=;
        b=frj6MfssbGqvDChj0Q9vCM3KWGZXik8Th/0uEKvNmGqhtZGOlz9nsxUn5/0WiEsJIO
         ZSFVYITcudR3u8fQjWMMjP82DALhpTHqPZpea780UVo9hZwc9NH4BZNswGAgPfvdFlHW
         VNMXOe9YilJiKZGrLdEHlob7pd+VOeB3B7i5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=SvQqcmyDx1WdKeWZZ8a81rzVEnfrGIlH3dBsuZuefQ5n5TSwGjnXQ6Df+tw6zBjaUB
         9zA5X6mopQMinhMO3EqZliVYPvzAddHSdcz+fT/UxEyLXh9mlMLx1Ie3vQG6sUHux48A
         u0oQkk9yf/0xbhOttHWI1gHzGLR0/1S3kd1sQ=
Received: by 10.227.208.73 with SMTP id gb9mr5007385wbb.194.1301383625765;
        Tue, 29 Mar 2011 00:27:05 -0700 (PDT)
Received: from [192.168.0.129] (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id e13sm2376295wbi.23.2011.03.29.00.27.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 00:27:03 -0700 (PDT)
In-Reply-To: <4D918032.3010608@drmicha.warpmail.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170241>

On Tue, 2011-03-29 at 08:46 +0200, Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 29.03.2011 02:28:
> > Will Palmer <wmpalmer@gmail.com> writes:
> > 
> >> I've been kicking around this series for a while now as part of a larger
> >> effort of refactoring the pretty formats. A recent discussion on the
> >> list has lead me to believe that this smaller subset may be of use
> >> sooner, rather than later.
> >>
> >> This series attempts to add "long forms" for common format placeholders
> >> in the "git log" family of commands, making the way for yet more
> >> placeholders to be added without needing to worry too much about the
> >> increasingly limited set of available one-letter mnemonics. It also
> >> moves towards the possibility of eventual unification with the format
> >> options in for-each-ref.
> > 
> > I don't claim that I read 1300+ long [PATCH 5/9] carefully, but I like the
> > direction in which this topic is going very much.
> > 
> > Except that [PATCH 2/9] looked quite out of place---more like "I wanted to
> > sneak this feature in" than "this was needed to keep the resulting code
> > backward compatible" or anything like that.
> > 
> > Off the top of my head, I don't think of a reason to say that [PATCH 3/9]
> > is going in a wrong direction---is there a reason to make you worried in
> > the particular change?
> 
> I'm wondering how much of this could and should be shared with
> for-each-ref. ......................................

I agree with this.
Not only that, but I think the "list" modes of branch and tag should
also call for-each-ref internally, and I hope that some of the
conditional formats that this series is moving slowly towards will help
with that.

> ............. Notable differences that I'm aware of:
> 
> - for-each-ref is about (named) refs which can point to any type of
> object; rev-list/log is about commit objects
> 
> - for-each-ref deals with "few" objects typically, rev-list/log with many
> 
> So, other than %(refname), %(upstream) and %(tagger...), all
> for-each-ref placeholders make sense for rev-list/log.

I think the "right thing to do" here is to allow the parser to accept
any of the for-each-ref specifications, but for the formatter to return
an empty string for anything that doesn't make sense in context. This is
what for-each-ref currently does. for-each-ref also gives an empty
string for some invalid specifications, such as %(tree:short), but I
assume this is a bug.

I'm not sure what the implications are in terms of what additional
structures we'll need to pass in to the formatter, as I haven't looked
much at the for-each-ref code. It may also be that there are some
commit-related things which for-each-ref doesn't currently bother to
grab, since its placeholder list is comparatively smaller than the
rev-list one.

> 
> Sharing the parser would serve several purposes:
> 
> - reduced code
> - increased test coverage (for-each-ref tests would test the parser)
> - speed up for for-each-ref (due to your nice separation)
> - short placeholders for for-each-ref
> - automatic consistency between the two
> 

This is already a part of my longer-term plans, though those were mostly
as a "I bet it would be fairly simple to do this once the rest is done".
What I'm actually working towards is strictly related to the --pretty=
formats, so I expect it will be a while before I get to anything like
for-each-ref unification. It may also be worth noting that the last part
of this work I submitted, "pretty aliases", was sent nearly a year ago.
I am not going to be working on any of this full-time.
The point here is: I would not be offended if someone were to snatch
for-each-ref unification up from me, since I really don't know when I
would get to it myself.


> Michael

-- 
-- Will
