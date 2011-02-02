From: david@lang.hm
Subject: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 18:23:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1102011822340.10088@asgard.lang.hm>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com> <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com> <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com> <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
 <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com> <alpine.LFD.2.00.1102011647000.8580@xanadu.home> <AANLkTikaztSn+xQ3xT7d-3-Yghk69qXXN1DRg9h+kEHx@mail.gmail.com> <alpine.LFD.2.00.1102012110320.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="Boundary_(ID_Q1bQXMK9bLGtowVEDPVRPQ)"
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 03:24:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkSO2-0001OZ-7B
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 03:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab1BBCX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 21:23:57 -0500
Received: from mail.lang.hm ([64.81.33.126]:41680 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442Ab1BBCX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 21:23:56 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p122Nm2I011927;
	Tue, 1 Feb 2011 18:23:49 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.2.00.1102012110320.8580@xanadu.home>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Content-ID: <alpine.DEB.2.00.1102011822341.10088@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165886>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Q1bQXMK9bLGtowVEDPVRPQ)
Content-Type: TEXT/PLAIN; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.00.1102011822342.10088@asgard.lang.hm>

On Tue, 1 Feb 2011, Nicolas Pitre wrote:

> On Tue, 1 Feb 2011, Shawn Pearce wrote:
>
>> On Tue, Feb 1, 2011 at 13:51, Nicolas Pitre <nico@fluxnic.net> wrote:
>>> On Tue, 1 Feb 2011, Shawn Pearce wrote:
>>>
>>>> On Tue, Feb 1, 2011 at 09:11, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>>>> Narrow/Subtree clone is still just an idea, but can pack cache support
>>>>> be made to resumable initial narrow clone too?
>>>>
>>>> This would be very hard to do.  We could do cached packs for a popular
>>>> set of path specifications (e.g. Documentation/ if documentation only
>>>> editing is common), but once we start getting random requests for path
>>>> specifications that we cannot predict in advance and pre-pack we'd
>>>> have to fall back to the normal enumerate code path.
>>>
>>> Also... people interested in Narrow clones are likely to be shallow
>>> clone users too, right?
>>
>> I think that depends.  Some users might want the full history of the
>> files they are working on.  Others wouldn't care and just want the tip
>> revision so they can make changes.  Obviously a shallow clone of depth
>> 1 is very cheap to implement on the server; there really isn't any
>> caching required.
>>
>> Probably 50% want full history, 50% want shallow clone.  So I doubt we
>> can assume that narrow implies shallow and thus is cheap.  :-(
>
> Let's see what happens when this gets used in the wild.

also, many users may assume that a full clone is very expensive, but for 
code-based projects a full clone is usually comparable to the size to 
download a single tarball.

if you have large binary files this changes, but most projects don't.

David Lang
--Boundary_(ID_Q1bQXMK9bLGtowVEDPVRPQ)--
