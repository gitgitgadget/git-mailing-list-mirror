From: David Lang <dlang@digitalinsight.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 10:58:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610201057070.5248@qynat.qvtvafvgr.pbz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com><eh
 ao3e$2qv$1@sea.gmane.org>  <4538EC8F.7020502@utoronto.ca><200610201821.34712.jnareb@gmail.com>
  <45390168.6020502@utoronto.ca><20061020172125.GF18019@spearce.org>
 <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Shawn Pearce <spearce@spearce.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 19:58:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaydS-0007rz-Sr
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 19:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWJTR6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 13:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWJTR6U
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 13:58:20 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:44760 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964828AbWJTR6T
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 13:58:19 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 20 Oct 2006 10:58:19 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 20 Oct 2006 10:57:59 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29512>

On Fri, 20 Oct 2006, Linus Torvalds wrote:

> On Fri, 20 Oct 2006, Shawn Pearce wrote:
>>
>> I renamed hundreds of small files in one shot and also did a few
>> hundered adds and deletes of other small XML files.  Git generated
>> a lot of those unrelated adds/deletes as rename/modifies, as their
>> content was very similiar.  Some people involved in the project
>> freaked as the files actually had nothing in common with one
>> another... except for a lot of XML elements (as they shared the
>> same DTD).
>
> Heh. We can probably tweak the heuristics (one of the _great_ things about
> content detection is that you can fix it after the fact, unlike the
> alternative).
>
> That said, I've personally actually found the content-based similarity
> analysis to often be quite informative, even when (and perhaps
> _especially_ when) it ended up showing something that the actual author of
> the thing didn't intend.
>
> So yeah, I've seen a few strange cases myself, but they've actually been
> interesting. Like seeing how much of a file was just a copyright license,
> and then a file being considered a "copy" just because it didn't actually
> introduce any real new code.
>

isn't the default to consider them a copy if they are 80% the same, with a 
command line option to tweak this (IIRC -m, but I could easily be wrong)

David Lang
