From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 6/6] format-patch --notes: show notes after three-dashes
Date: Sun, 21 Oct 2012 22:33:54 +0100
Organization: OPDS
Message-ID: <B15B2D6C9AAB43AF9D480D9DEB3D2F47@PhilipOakley>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com> <1350539128-21577-7-git-send-email-gitster@pobox.com> <C2D3CE0879B345FFAC2A6487760B5378@PhilipOakley> <7vlif3l9fw.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Eric Blake" <eblake@redhat.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 23:34:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ39r-0005zb-F9
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 23:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab2JUVdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 17:33:52 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:58680 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754574Ab2JUVdw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 17:33:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuIKAFZfhFBcHlx7/2dsb2JhbABDi1O0MAQBA4EEgQmCGwUBAQQBCAEBLh4BARMOBQYCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGHbQoHuheMGkQRHIRjYAOIJYVHkyKFHIJw
X-IronPort-AV: E=Sophos;i="4.80,626,1344207600"; 
   d="scan'208";a="407383988"
Received: from host-92-30-92-123.as13285.net (HELO PhilipOakley) ([92.30.92.123])
  by out1.ip01ir2.opaltelecom.net with SMTP; 21 Oct 2012 22:33:49 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208152>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>> When inserting the note after the commit log message to format-patch
>>> output, add three dashes before the note.  Record the fact that we
>>> did so in the rev_info and omit showing duplicated three dashes in
>>> the usual codepath that is used when notes are not being shown.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>> Should this also include a documentation update to make this
>> substantive benefit visible, whether that be in the format-patch man
>> pages, the SubmittingPatches guide, in the git-notes description of 
>> 'A
>> typical use...', or even in the user-manual?
>
> Eric Blake (http://mid.gmane.org/507EB310.8020904@redhat.com) was
Added to distribution.

> already working on a documentation updates already, I thought.
>
> As long as what it does is explained in format-patch, that is fine.
>
> I do not think this deserves to be in the SubmittingPatches.  We do
> tell people to hide "here is the context of the change" additional
> explanation after three dashes, but how the submitters prepare that
> text is entirely up to them (and I personally do not think notes is
> not necessarily the right tool to do so).
>
I've prepared a short set of patches for the documenation I mentioned.

I, like Eric, feel some of the methods available are a bit of a Catch 
22.
We do need to at least hint about capabilities as a way of helping new
users who aren't already experts (the inverse Kruger Dunning problem).

I have tried hard to make the patches concise so hopefully they will be
acceptable.

Philip 
