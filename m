From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] "not uptodate" changed to "has local changes"
Date: Mon, 19 May 2008 10:47:52 -0700
Message-ID: <7vzlqm89tj.fsf@gitster.siamese.dyndns.org>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
 <alpine.DEB.1.00.0805161125320.30431@racer>
 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
 <alpine.DEB.1.00.0805171102480.30431@racer>
 <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
 <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
 <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org>
 <D925ECD3-1EE2-48EB-B1E5-2604C10AD643@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sverre@rabbelier.nl, "Steven Walter" <stevenrwalter@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Andr?= =?utf-8?Q?=C3=A9?= Goddard Rosa 
	<andre.goddard@gmail.com>, "Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon May 19 19:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy9UA-0004KG-5Z
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 19:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763128AbYESRsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2008 13:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763119AbYESRsO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 13:48:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763110AbYESRsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2008 13:48:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 98E9F2AD2;
	Mon, 19 May 2008 13:48:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B11CC2ACF; Mon, 19 May 2008 13:47:56 -0400 (EDT)
In-Reply-To: <D925ECD3-1EE2-48EB-B1E5-2604C10AD643@wincent.com> (Wincent
 Colaiuta's message of "Mon, 19 May 2008 08:55:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCBD5DA8-25CB-11DD-9A60-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82436>

Wincent Colaiuta <win@wincent.com> writes:

> El 17/5/2008, a las 21:03, Junio C Hamano escribi=C3=B3:
>> +	/* not_uptodate_file */
>> +	"Entry '%s' not uptodate. Cannot merge.",
>
>
> Minor nit, "uptodate" is not a word. Should be either "up-to-date" or
> "up to date"; most dictionaries list both.

Why does *everybody* keep missing the whole point of this patch?

Grumble.
