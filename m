From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Amending merge commits?
Date: Tue, 29 Jul 2014 20:29:20 +0100
Organization: OPDS
Message-ID: <DFE66A48CBC646E795B3B4A0903AB19E@PhilipOakley>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com><87r4147agk.fsf@osv.gnss.ru> <CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"Besen, David" <david.besen@hp.com>, <git@vger.kernel.org>
To: "Nico Williams" <nico@cryptonector.com>,
	"Sergei Organov" <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:29:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCD5S-0007MQ-10
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 21:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbaG2T3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 15:29:22 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:54239 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751321AbaG2T3V (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 15:29:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiUaAFT111NOl3UmPGdsb2JhbABPCoMOgSmCeIQ3gQTKfwUBAgEBgREXBQEBAQE4NoN+BQEBBQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBgESCAIBAgMBiDWndoZ/kF6BLI1EXIMANoEbBZE1ojI8Lw
X-IPAS-Result: AiUaAFT111NOl3UmPGdsb2JhbABPCoMOgSmCeIQ3gQTKfwUBAgEBgREXBQEBAQE4NoN+BQEBBQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBgESCAIBAgMBiDWndoZ/kF6BLI1EXIMANoEbBZE1ojI8Lw
X-IronPort-AV: E=Sophos;i="5.01,759,1400022000"; 
   d="scan'208";a="642171268"
Received: from host-78-151-117-38.as13285.net (HELO PhilipOakley) ([78.151.117.38])
  by out1.ip06ir2.opaltelecom.net with SMTP; 29 Jul 2014 20:29:19 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254462>

From: "Nico Williams" <nico@cryptonector.com>
> On Tue, Jul 29, 2014 at 4:58 AM, Sergei Organov <osv@javad.com> wrote:
>> Nico Williams <nico@cryptonector.com> writes:
>>> That exception aside, keeping all local commits "on top" by always
>>> rebasing them onto the upstream is extremely useful: a) in 
>>> simplifying
>>> conflict resolution, b) making it easy to identify 
>>> as-yet-unintegrated
>>> local commits, c) making it easy to contribute local commits.
>>
>> But 'pull --rebase=preserve' does rebase local commits onto the
>> upstream, and result is exactly the same as 'pull --rebase=true', 
>> unless
>> you have some of your own merges to be rebased. That's where the
>> difference between these two options appears. It's --rebase=false 
>> that
>> performs merges rather than rebase.
>
> Local merge commits mean that you either didn't rebase to keep all
> your local commits on top of the upstream, or that you have multiple
> upstreams (the example exception I gave).
>
> Conversely, if you always rebase your local commits on top of the
> upstream then you won't have merge commits to worry about.
>
Whilst it may not be "the Git Way", I'd expect that in many less well 
informed companies, the need to keep merge commits fom other lines of 
development would be quite a common (political ) technique where some 
preparatory branch needs to be merged in before one's feature can be 
completed (similar to all those cases on the list when folk say 'builds 
on top of xy's commit deadbeaf)

Philip 
