From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 05/15] Add new simplified git-remote-testgit
Date: Thu, 22 Nov 2012 00:39:44 +0100
Message-ID: <CAMP44s28O+O582OZNB8D064UYyypKHMjg9hbAa6w_zqXrKFs8Q@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-6-git-send-email-felipe.contreras@gmail.com>
	<7vboeq3h0t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:59:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbeng-0008Pl-J9
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 22:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781Ab2KVV6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 16:58:51 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63897 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab2KVV6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 16:58:49 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8459223obb.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E16ugc+SfDy0+IgaJqbdxSEWb9xVE4DOMr13ljmR0eA=;
        b=tRS7wCFhpyfbLljFz3fwEhsQImBqJMilB1FK9qruSkzjVAJF56+rSUkHf/Xe6MpR/6
         z33RRK6Fx1DwKtaz2fDWbf8jisk+fHbDOD45sXJo62dzzhccPUU/RL1bgyNiPXRV4Be6
         aW0GfwQLbe88p0phbXbsPmltw/q/FTMFsYTeUoJc0m+jlh1dTLp5m7SrBF55GkOxvIJs
         SghR7SVkiJmFSTuBbPw7qpVme2rQqXWx6JF06O4v2GHBRlrv0VCrf6hmtvsSoEW7BqlG
         YVDVerwrKTzrbt4FVT96GGV/jHHU75FEtaBUjnsWks2tQcO/g2TPFo34bv4/iUIAZYfh
         pEpA==
Received: by 10.60.31.6 with SMTP id w6mr1865743oeh.65.1353541184203; Wed, 21
 Nov 2012 15:39:44 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 21 Nov 2012 15:39:44 -0800 (PST)
In-Reply-To: <7vboeq3h0t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210215>

On Wed, Nov 21, 2012 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It's way simpler. It exerceises the same features of remote helpers.
>> It's easy to read and understand. It doesn't depend on python.
>>
>> It does _not_ exercise the python remote helper framework; there's
>> another tool and another test for that.
>
> You mention why you _think_ it is better, and what it is _not_, but
> with your excitement, end up failing to mention what it is.  I'll
> try to reword the commit with this sentence:
>
>         This script is to test the remote-helper interface.

That's right.

-- 
Felipe Contreras
