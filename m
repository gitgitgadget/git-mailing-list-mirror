From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Sat, 18 May 2013 14:12:05 +0100
Organization: OPDS
Message-ID: <E74470E4201142788D36127322130401@PhilipOakley>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com><1368689474-28911-2-git-send-email-felipe.contreras@gmail.com><7v61yi9arl.fsf@alter.siamese.dyndns.org><CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com><7v8v3e7udi.fsf@alter.siamese.dyndns.org><CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com><7vk3my6bu1.fsf@alter.siamese.dyndns.org><CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com><7vk3my33vb.fsf@alter.siamese.dyndns.org><CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com> <7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Jens Lehmann" <Jens.Lehmann@web.de>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 15:12:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udgvb-0001nD-8D
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 15:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab3ERNLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 09:11:47 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:40867 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115Ab3ERNLq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 May 2013 09:11:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AskNALl9l1FZ8YNG/2dsb2JhbABbgwiJKrhKBAEDAYEAF3SCGgUBAQQBCAEBLh4BASEFBgIDBQIBAxEEAQEKJRQBBBoGBw8IBgESCAIBAgMBh3UKvSCOBDNqgnphA4hnhgGaEIMQOw
X-IronPort-AV: E=Sophos;i="4.87,699,1363132800"; 
   d="scan'208";a="428600520"
Received: from host-89-241-131-70.as13285.net (HELO PhilipOakley) ([89.241.131.70])
  by out1.ip02ir2.opaltelecom.net with SMTP; 18 May 2013 14:11:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224792>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, May 17, 2013 7:30 PM
Subject: Re: [PATCH 1/3] fetch: add --allow-local option

[...]

> So when "the user" is running "git fetch" on "mywork" branch that
> happens to be forked from a local "master", i.e. her configuration
> is set as
>
> [branch "mywork"]
>        remote = .
>                merge = refs/heads/master
>

Was the '.' example illustrative rather than exact. I see no case of 
using '.' in my configs. Or am I completely missing the point? (e.g. 
that the use of '.' an example of possible future usage)?


> we still need to have FETCH_HEAD updated to point at what we would
> be merging if she did a "git pull".  It may be OK to additionally
> fetch objects from 'origin' and update the remote tracking branches
> associated with 'origin', but anything from 'origin' should not
> contaminate what results in FETCH_HEAD---it should record whatever
> we record when we did fetch refs/heads/master from '.'.
>
> As I said in the very beginning, it was a mistake for me to suggest
> adding a special case behaviour for '.' remote in the first place.
> It breaks a long-standing expectation and workflow built around it.
>
> So sorry for wasting our time, and consider this as a misguided
> excursion.
> --

Philip 
