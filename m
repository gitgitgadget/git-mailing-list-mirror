From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Thu, 28 May 2015 00:42:48 +0100
Organization: OPDS
Message-ID: <68A62E92218D4FD4A71EA138C9F3725A@PhilipOakley>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr><c78cd2ac17333a2e70d1113d95495c41@www.dscho.org><1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr><vpq1ti23vva.fsf@anie.imag.fr> <xmqqsiahltbu.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Remi Galan Alfonso" <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	<git@vger.kernel.org>,
	"Remi Lespinet" <remi.lespinet@ensimag.grenoble-inp.fr>,
	"Guillaume Pages" <guillaume.pages@ensimag.grenoble-inp.fr>,
	"Louis-Alexandre Stuber" 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	"Antoine Delaite" <antoine.delaite@ensimag.grenoble-inp.fr>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 01:43:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxkyP-0006lI-KC
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 01:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbbE0Xmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 19:42:51 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:39000 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752310AbbE0Xmr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 19:42:47 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CEPQA2VWZVPCS2BlxcgxCBMoZNbcF6BAQCgURNAQEBAQEBBwEBAQFBJBtBAQMBg1cGAQEECAEBLh4BASELAgMFAgEDFQwlFAEEGgYHAxQGARIIAgECAwELiBW1T51nizqFBYMegRYFjAqGfnmhRYEEgxg9MYJHAQEB
X-IPAS-Result: A2CEPQA2VWZVPCS2BlxcgxCBMoZNbcF6BAQCgURNAQEBAQEBBwEBAQFBJBtBAQMBg1cGAQEECAEBLh4BASELAgMFAgEDFQwlFAEEGgYHAxQGARIIAgECAwELiBW1T51nizqFBYMegRYFjAqGfnmhRYEEgxg9MYJHAQEB
X-IronPort-AV: E=Sophos;i="5.13,509,1427756400"; 
   d="scan'208";a="593199289"
Received: from host-92-6-182-36.as43234.net (HELO PhilipOakley) ([92.6.182.36])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 28 May 2015 00:42:45 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270120>

From: "Junio C Hamano" <gitster@pobox.com>
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I find it weird to write
>>
>> noop <sha1> <title>
>
> True, but then it can be spelled
>
>    # <sha1> <title>
>
> too, so do we still want 'drop'?  Unless we have a strong reason to
> believe migrants from Hg cannot be (re)trained, personally, I'd feel
> that we do not need this 'drop' thing.
>
To me, the addition of "drop" would be a better completion of the list 
of action verbs for 'normal' users.

Training/Retraining users to use atypical techniques is a never ending 
task, so making drop a synonym for the existing noop appeals to my 
experience of users (of all sorts of tools, including personal 
experience ;-).

--
Philip 
