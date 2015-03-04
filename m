From: Noel Grandin <noel@peralex.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 04 Mar 2015 13:25:10 +0200
Message-ID: <54F6EB96.6080500@peralex.com>
References: <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com> <20150225143116.GA13567@peff.net> <xmqqk2z5on72.fsf@gitster.dls.corp.google.com> <20150225185128.GA16569@peff.net> <xmqqbnkholx9.fsf@gitster.dls.corp.google.com> <20150225191108.GA17467@peff.net> <20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com> <xmqqvbilh0wn.fsf@gitster.dls.corp.google.com> <20150301130142.GA24782@tsaunders-iceball.corp.tor1.mozilla.com> <xmqqr3t8fgm4.fsf@gitster.dls.corp.google.com> <20150302125017.GA4464@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Trevor Saunders <tbsaunde@tbsaunde.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 12:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT7Qa-00011s-VO
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 12:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759243AbbCDLZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 06:25:18 -0500
Received: from mail.peralex.com ([41.164.8.44]:59375 "EHLO mail.peralex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755693AbbCDLZR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 06:25:17 -0500
Received: from [192.168.1.95] (noel1.ct [192.168.1.95])
	by mail.peralex.com (Postfix) with ESMTPSA id 24A00336F5A;
	Wed,  4 Mar 2015 13:25:14 +0200 (SAST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=peralex.com;
	s=default; t=1425468314;
	bh=amyeeq4mcMHqACt9PqXwOv7uI317/Dq8koDf7RuMcG8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wSO/Vr896AbPjN54Haofuocg3Dsoq0ykGbFV28GSY4MkYigoIepUUUt0GqafuAg9a
	 5EB9uDcbpS79biPeG+DbIT94OboCWQuJ3JdXm2RoKt0TMhJ5sKwmCOQjd0VDSpAWTs
	 y2iLXUZbwMDN7r+i9/++AH0qOt0GFK1stLkMZiGc=
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150302125017.GA4464@tsaunders-iceball.corp.tor1.mozilla.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.4.3 (mail.peralex.com); Wed, 04 Mar 2015 13:25:14 +0200 (SAST)
X-Scanned-By: MIMEDefang 2.74 on 41.164.8.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264754>

On 2015-03-02 02:50 PM, Trevor Saunders wrote:
> I think they solve somewhat different problems, but maybe my problem is so specialized I should just have a wrapper 
> around grep that changes defaults. Trev 

I'm with Trevor on this one. While I see the appeal of the generality of a macro solution, this is really just about 
convenience for me on a per-project basis.

As in, while working on a specific project, I sometimes just want to exclude, for the time being, a bunch of stuff from 
'git grep'.

Mind you, I use 'git grep' a hang of a lot during development, since it is so powerful, so maybe that's just me.

Thanks, Noel Grandin



Disclaimer: http://www.peralex.com/disclaimer.html
