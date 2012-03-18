From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sat, 17 Mar 2012 21:02:27 -0700
Message-ID: <4F655E53.6030408@zytor.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <CADVrmKSGbA2gWVyPLMCBay3EikOykwq3eEH1+qWCpZvOron3Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 05:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S97Ko-0006nR-FV
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 05:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848Ab2CRECf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 00:02:35 -0400
Received: from terminus.zytor.com ([198.137.202.10]:51801 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab2CRECe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 00:02:34 -0400
Received: from titan.hos.anvin.org ([IPv6:2001:470:861f:2:221:5cff:fe7d:a2a7])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q2I42WSe027465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sat, 17 Mar 2012 21:02:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
In-Reply-To: <CADVrmKSGbA2gWVyPLMCBay3EikOykwq3eEH1+qWCpZvOron3Aw@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193368>

On 03/17/2012 11:43 AM, fREW Schmidt wrote:
> On Sat, Mar 17, 2012 at 12:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> There is a proposal to change the default behaviour of 'git push' on the
>> Git mailing list. The goal of this message is to encourage you to discuss
>> it before it happens (or the change is aborted, depending on the outcome
>> of the discussion).
> 
> I personally much prefer the one where it pushes the current branch to
> its tracking branch only.  That leaves very little room for surprises
> and mistakes (the one exception being git push after git checkout -b
> new-branch origin/master.)
> 

I would agree with this being the least surprising behavior.  I believe
this is what push.default = upstream does.

	-hpa
