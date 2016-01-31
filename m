From: Jonathan Smith <Jonathan.Smith@fphcare.co.nz>
Subject: RE: [RFC/PATCH] Git doc: GPL2 does not apply to repo data
Date: Sun, 31 Jan 2016 22:15:48 +0000
Message-ID: <6D15DFBB73355B4E9EFB1AD5EF9FCA31842442AA@NZ-EXCHANGE1.fphcare.com>
References: <alpine.DEB.2.20.1601280913450.2964@virtualbox>
	<1454274011-4880-1-git-send-email-philipoakley@iee.org>
 <xmqq8u35xv00.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: GitList <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 23:15:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ0Hk-0002mo-0S
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 23:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529AbcAaWPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 17:15:52 -0500
Received: from mailout.fphcare.co.nz ([218.101.54.164]:16617 "EHLO
	mailout.fphcare.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466AbcAaWPv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2016 17:15:51 -0500
Received: from NZ-EXCHANGE2.fphcare.com (Not Verified[10.209.10.179]) by mailout.fphcare.co.nz with MailMarshal (v7,2,2,6606) (using TLS: SSLv23)
	id <B56ae87950000>; Mon, 01 Feb 2016 11:15:49 +1300
Received: from NZ-EXCHANGE1.fphcare.com ([fe80::a8c3:cd32:65a1:7dd2]) by
 NZ-EXCHANGE2.fphcare.com ([fe80::94a3:f661:e3f0:8f4b%15]) with mapi id
 14.03.0279.002; Mon, 1 Feb 2016 11:15:49 +1300
Thread-Topic: [RFC/PATCH] Git doc: GPL2 does not apply to repo data
Thread-Index: AQHRXHPhUUSO/xFD60CJhPLWH4pqVJ8WL4tg
In-Reply-To: <xmqq8u35xv00.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-GB, en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.32.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285175>

Hi all

I would like to thank you each for being so helpful with my request.

As a humble developer trying to penetrate the corporate environment with leading technologies such as Git, it's awesome to know you guys are so proactive with providing support.

I'll be taking all of your contributions as ammo as I continue to fight for Git here.

Thank you!

Jonathan

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Monday, February 01, 2016 11:08 AM
To: Philip Oakley <philipoakley@iee.org>
Cc: GitList <git@vger.kernel.org>; Jonathan Smith <Jonathan.Smith@fphcare.co.nz>; Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Git doc: GPL2 does not apply to repo data

Philip Oakley <philipoakley@iee.org> writes:

> diff --git a/Documentation/git.txt b/Documentation/git.txt index 
> bff6302..137c89c 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1132,6 +1132,17 @@ of clones and fetches.
>  	  - any external helpers are named by their protocol (e.g., use
>  	    `hg` to allow the `git-remote-hg` helper)
>  
> +Licencing: Your data, and the Git tool[[Licencing]]
> +---------------------------------------------------
> +
> +Git is an open source tool provided under GPL2.
> +Git was designed to be, and is, the version control system for the 
> +Linux codebase.
> +Your respository data created by Git is not subject to Git's GNU2 
> +licence, see GPL FAQs 
> +http://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.html#TOCGPLOutput).
> +
> +User should apply a licence of their own choice to their repository data.
>  
>  Discussion[[Discussion]]
>  ------------------------

While I know you mean well, and I do understand the sentiment behind this addition, there are at least two reasons why I do not want to (and why we should not) add any "clarification" or "interpretation"
like this.

One is because such a statement is pointless.  Because we do not do copyright assignment to the project, you are not the sole copyright owner of Git.  Individual contributors hold copyright to the part they wrote.  The above statement you made, even with an endorsement by me as the project lead, does not have any power to assure that the users will not get sued by one copyright holder, who is not you or me, and at that point it is up to the court to interpret GPLv2.
We can call such a copyright holder crazy or call such a suit frivolous, but that does not change the fact that the court is what decides the matter, so having that statement does not help the user.

Another is because we are amateurs.  Philip, you may or may not be a lawyer yourself, but I know you are not _our_ lawyer.  An amateurish "interpretation" or "clarification" does not necessarily clarify the text but it muddies it, especially when done carelessly.  Imagine a case where a user creates a derived work of Git itself and stored it in a Git repository.  "Your respository data created by Git is not subject to Git's GNU2"--really?  At least the phrasing must say that the act of storing something in Git alone would not *MAKE* that something governed under GPLv2.  What the user puts in Git may already be covered under GPLv2 for other reasons, and a statement carelessly written like the above can be twisted to read as if we are endorsing use of our code outside GPLv2 as long as they s
 tore it in Git repository, which is not what you meant to say, but "that is not what the copyright holder meant" is another thing the lawyer need to argue in court to convince the judge, when we need to go after a real copyright violator.

We should leave the lawyering to real lawyers and we should not add unnecessary work of interpreting our amateurish loose statement to our laywers.

Thanks.
____________________________________________________________

This e-mail and any attachments may contain confidential information. If you
are not the intended recipient (or have received this e-mail in error)
please notify the sender immediately and destroy this e-mail. Any
unauthorized copying, disclosure or distribution of the material in this 
e-mail is strictly forbidden.
