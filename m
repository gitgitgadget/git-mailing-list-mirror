From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 11:06:11 +0100
Message-ID: <20130418100610.GV2278@serenity.lan>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
 <1366258473-12841-2-git-send-email-felipe.contreras@gmail.com>
 <20130418082441.GR2278@serenity.lan>
 <CAMP44s0cJwHSJrWKkWAwKSv8OE=OqVRdKEtBNdAvQ7YAE5-JKw@mail.gmail.com>
 <20130418094531.GU2278@serenity.lan>
 <CAMP44s35tmmgNd-vJQnqG56avSPY2NOBR6iR7eNtpfemXsfPJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USljd-0004kA-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab3DRKG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:06:29 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:40165 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3DRKG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:06:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 62E2B866002;
	Thu, 18 Apr 2013 11:06:28 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ffunlCbCsBte; Thu, 18 Apr 2013 11:06:27 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id B6BCFCDA5E8;
	Thu, 18 Apr 2013 11:06:26 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A0EEC161E515;
	Thu, 18 Apr 2013 11:06:26 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWDb8effGXKl; Thu, 18 Apr 2013 11:06:24 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id ACBE4161E52D;
	Thu, 18 Apr 2013 11:06:13 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s35tmmgNd-vJQnqG56avSPY2NOBR6iR7eNtpfemXsfPJA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221639>

On Thu, Apr 18, 2013 at 05:02:11AM -0500, Felipe Contreras wrote:
> On Thu, Apr 18, 2013 at 4:45 AM, John Keeping <john@keeping.me.uk> wrote:
> > In my copy of pu I don't see the text "It's mandatory for 'export'", it
> > just stops after "It is recommended that all importers providing the
> > 'import' capability use this".  That paragraph also starts with "This
> > modifies the 'import' capability" making no mention of export.
> 
> This is patch 1 of 6, keep going.

Ah, I see now.  I had read all of the patches initially, but then
focused on this one for discussion.

The end result after this series does look good, but I find it slightly
strange to take a step backwards on the way.
