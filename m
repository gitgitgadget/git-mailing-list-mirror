From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 23:02:41 +0100
Organization: OPDS
Message-ID: <8629441933A94862982C5CDD6BF47690@PhilipOakley>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com> <20131014205908.GA17089@shrek.podlesie.net> <525c63b6711fa_197a905e845b@nysa.notmuch> <20131015123505.GA3097@shrek.podlesie.net> <525d35e766ad4_55661275e7426@nysa.notmuch> <20131015133327.GA22723@shrek.podlesie.net> <525d4354a5436_5844e73e843d@nysa.notmuch> <20131015145139.GA3977@shrek.podlesie.net> <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com> <525e0e1b28c87_81a151de743f@nysa.notmuch> <CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com> <525ee9d93c3af_3983c19e7caa@nysa.notmuch>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Krzysztof Mazur" <krzysiek@podlesie.net>, <git@vger.kernel.org>
To: "John Szakmeister" <john@szakmeister.net>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 00:03:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWZBP-00032o-LX
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 00:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761319Ab3JPWCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 18:02:52 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:51262 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761081Ab3JPWCh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Oct 2013 18:02:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An0GAHQMX1JOl3+a/2dsb2JhbABagweEM4U+tQMKgRwXdGmBIRYBBAEBBQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcXBgESCAIBAgMBhTgHghcNAxOtC4hPDYlrgSmLOoJugnE1gQYDjxaHBY41hTaBOoFrOw
X-IPAS-Result: An0GAHQMX1JOl3+a/2dsb2JhbABagweEM4U+tQMKgRwXdGmBIRYBBAEBBQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcXBgESCAIBAgMBhTgHghcNAxOtC4hPDYlrgSmLOoJugnE1gQYDjxaHBY41hTaBOoFrOw
X-IronPort-AV: E=Sophos;i="4.93,509,1378854000"; 
   d="scan'208";a="434852389"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip05ir2.opaltelecom.net with SMTP; 16 Oct 2013 23:02:35 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236276>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
> John Szakmeister wrote:
>> On Tue, Oct 15, 2013 at 11:55 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> [snip]
> Similarly, if a user does core.mode = next, the user is expecting to 
> enable all
> future behaviors, because that's what core.mode = next does, if he 
> doesn't want
> to do that, then why would he use that option?
>

Would this be a good time to suggest a specific wording should be 
proposed (or a reminder of what was proposed repeated) for the 
documentation of this option. It will be the documentation that users 
will refer to when they need to know, rather than the list discussions.

The too and fro discussion suggested that it would be important to 
present the chosen viewpoint well, so there would be no 
misunderstanding, such that 'users' of the mode realise that they are 
acting as testers, and there are no promises for the posterity of any 
trial behaviour, and they (the tester) have a 'caveat emptor' 
responsibility. And that they need to keep up with developments (list & 
release notes) so that at any update they know what will disappear and 
appear without warning.

Philip

> -- 
> Felipe Contreras
> --
