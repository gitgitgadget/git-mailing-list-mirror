From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 22:20:10 +0100
Message-ID: <3f4fd2640709191420w1245449cwb9646b6c6e0e1c82@mail.gmail.com>
References: <20070917193027.GA24282@old.davidb.org>
	 <46EF7DD1.9090301@vilain.net> <20070918154918.GA19106@old.davidb.org>
	 <3f4fd2640709181053t70b7abcdi2c4eaf67e7b75338@mail.gmail.com>
	 <46F06C0F.3040609@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 23:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY6y3-000310-4o
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 23:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbXISVUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 17:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbXISVUO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 17:20:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:48316 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbXISVUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 17:20:12 -0400
Received: by wr-out-0506.google.com with SMTP id 36so157278wra
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0zmJBw2quRiHMLvs1jp8e1LnROlUMO05/smIpI9X0ic=;
        b=HpY0cJC2sG4ChAUKlH82Ik6d4eiK92lMyXsLOUU67KHt5irz30I0EkMWhzJhH5YrpqpkQfEIl2HnMKdzZ2zrqlSJ7Xv5S+N/vqocqZZsr7mg+xTQE5yUwKd+BI/MoPFstQsEhWAigbh4SrfKvuUY7w8VfmnuxR2E92RZ4+w/75o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ds9JuOvpOC6rwUpbl+BX/0mbhd3buFKeZUSZ8j2zqyLBgsSUa/gcozxk4vho+4fHq7uqu5BjGO/3tHdt92qPrmFjCL+J3sCgqrbl7d8LFO2TaWTwmpRJgZeRsUH0JZ+lmazGJM3uH27VjQ881jtKfco6+mU45i0tCr37TOzbUIk=
Received: by 10.142.88.20 with SMTP id l20mr30346wfb.1190236810600;
        Wed, 19 Sep 2007 14:20:10 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Wed, 19 Sep 2007 14:20:10 -0700 (PDT)
In-Reply-To: <46F06C0F.3040609@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58738>

On 19/09/2007, Sam Vilain <sam@vilain.net> wrote:
> Reece Dunn wrote:
> > There is no need to create yet another Perforce importing tool, git-p4
> > works well in most cases. If we focus on improving git-p4, extending
> > it to support the functionality mentioned here, fix the issues that
> > there are with it, then that will be more beneficial to the community
> > as they will not have to learn another tool with a different set of
> > bugs and issues.
>
> I like my approach; it's clean and I think shows a tasteful level of
> distrust towards the sanity and integrity of the data held by Perforce.
>  Actually it really helped me understand what was really going on;
> because the information as displayed by for instance "p4 integrate" is
> a lot more confusing than the underlying tables (IMHO).

I agree. What I wasn't clear about in that paragraph, but had eluded
to in other comments in that email, is that having both git-p4 and
git-p4raw is a good thing as they operate on two differing use cases.
What I was referring to there is to have another equivalent of git-p4
that interfaced using the p4 client.

- Reece
