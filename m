From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Pull is Mostly Evil
Date: Fri, 2 May 2014 23:34:18 +0100
Organization: OPDS
Message-ID: <2F8B2EEED0594446A6FCF771BBEDFB56@PhilipOakley>
References: <5363BB9F.40102@xiplink.com> <87k3a4xjzg.fsf@fencepost.gnu.org> <C439C0C76DA44AB5AAC91E7C0D2991BA@PhilipOakley> <5363ec734572a_70ef0f30cdc@nysa.notmuch>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat May 03 00:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgM2B-00054Q-Vo
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbaEBWeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:34:20 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:34104 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129AbaEBWeS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 18:34:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmFVADkcZFMCYJ6l/2dsb2JhbABZgwZfA4MshT28IAUBAgEMgQIXdIIgBQEBBQgBARkVHgEBLAIDBQIBAxUBAgICBSECAhQBBAgSBgcXBgESCAIBAgMBiBwDFaYlhVqYBA2GRBeBKogHgwqCTIJBNYEVBJAEhzqPBoVbgzU8
X-IPAS-Result: AmFVADkcZFMCYJ6l/2dsb2JhbABZgwZfA4MshT28IAUBAgEMgQIXdIIgBQEBBQgBARkVHgEBLAIDBQIBAxUBAgICBSECAhQBBAgSBgcXBgESCAIBAgMBiBwDFaYlhVqYBA2GRBeBKogHgwqCTIJBNYEVBJAEhzqPBoVbgzU8
X-IronPort-AV: E=Sophos;i="4.97,975,1389744000"; 
   d="scan'208";a="445372791"
Received: from host-2-96-158-165.as13285.net (HELO PhilipOakley) ([2.96.158.165])
  by out1.ip04ir2.opaltelecom.net with SMTP; 02 May 2014 23:34:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247999>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Friday, May 02, 2014 8:05 PM
> Philip Oakley wrote:
>> From: "David Kastrup" <dak@gnu.org>
>> > Marc Branchaud <marcnarc@xiplink.com> writes:
>> >
>> >> To that end, I suggest that pull's default behaviour should be to 
>> >> do
>> >> *nothing*.  It should just print out a message to the effect that 
>> >> it
>> >> hasn't been configured, and that the user should run "git help 
>> >> pull"
>> >> for guidance.
>> >
>> > Fetching is uncontentious, and I _think_ that fast-forwards are 
>> > pretty
>> > uncontentious as well.
>>
>> While the fast forward is /pretty/ uncontentious, it still maybe
>> contentious for some.
>
> So? No defaults can please absolutely everyone, the best anybody can 
> do
> is try to please the majority of people, and merging fast-forwards 
> only
> does that.

That assumes that doing something is better than doing nothing, which is 
appropriate when the costs on either side are roughly similar. However 
in this case, as we have essentially all agreed, there have been some 
bad down sides. In that case a precautionary principle is more 
appropriate where doing nothing (that is git pull does nothing until 
user configured) is better.

While a shift to merging fast-forwards would reduce the cost difference, 
they have to be matched against the potential user confusions when 
comparing to all the old web miss-instructions, hence my shift away from 
trying to best guess a default, rather than simply suggest it as a 
suitable user choice.
>
> -- 
> Felipe Contreras
> --
Philip 
