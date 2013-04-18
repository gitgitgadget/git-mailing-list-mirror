From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 05:02:11 -0500
Message-ID: <CAMP44s35tmmgNd-vJQnqG56avSPY2NOBR6iR7eNtpfemXsfPJA@mail.gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-2-git-send-email-felipe.contreras@gmail.com>
	<20130418082441.GR2278@serenity.lan>
	<CAMP44s0cJwHSJrWKkWAwKSv8OE=OqVRdKEtBNdAvQ7YAE5-JKw@mail.gmail.com>
	<20130418094531.GU2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:02:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USlfW-0007Tp-CG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab3DRKCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:02:14 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:44175 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab3DRKCN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:02:13 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so1278032lab.35
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=JX7tFDR7rVKII8ViUJEMo5UJfB4NrppoZLHddi4+vA0=;
        b=U7GmgOTA9W/6sxJzfDyIVIj973FR6WepHAwBs9gASVlfNl/ysxjiNdH/fj41G7gKdG
         ylWic042FM+lzjkcWtkaGLxoHn74qnK3b6srO873LOWh5zyUGEshBw2K4dDMmQW3N/eq
         A1RFE5ytMco96SeyDfNGmhxcNsJ9RF+n2ZsJbSoKmsD217WWZ3pfoDiqbwocNpnncIpp
         srC+RA3MissxzbHILr+oKv794bBq/FZkps+1u/ff2vwJq78Si1vf5bHZIjU+qNkmoGNL
         MTq8fMznk8dctYvJ5uLKUfTe5gozsjKpyNh4T3NV5aPk/agAjkdfFeGiW7hUfX31DBDQ
         buhA==
X-Received: by 10.152.27.229 with SMTP id w5mr2874657lag.46.1366279332084;
 Thu, 18 Apr 2013 03:02:12 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 03:02:11 -0700 (PDT)
In-Reply-To: <20130418094531.GU2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221637>

On Thu, Apr 18, 2013 at 4:45 AM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, Apr 18, 2013 at 04:27:57AM -0500, Felipe Contreras wrote:

>> Maybe my version was "misleading" because it didn't mention it was for
>> historical reasons, but yours is plain wrong; remote helpers might not
>> be using 'import' or 'export' at all, so not all remote helpers should
>> always specify an explicit refspec. And if the previous text "It is
>> recommended that all importers providing the 'import' capability use
>> this. It's mandatory for 'export'." does not convey the idea these
>> remote helpers should always specify an explicit refspec, I don't know
>> what it does.
>
> I didn't say mine was correct, but there was a reason that I wanted to
> change the existing text.  Just going back to what was there before is
> not a good way to make things better.

And just because it was that way before doesn't mean it was worst.
Your patch essentially switched from "it is implied", to "it should be
explicit", which is wrong. Going back to the previous text is the
simplest change that restores a reasonable explanation. The next
patches in this series deal with the rest of the issues in this text.

> In my copy of pu I don't see the text "It's mandatory for 'export'", it
> just stops after "It is recommended that all importers providing the
> 'import' capability use this".  That paragraph also starts with "This
> modifies the 'import' capability" making no mention of export.

This is patch 1 of 6, keep going.

-- 
Felipe Contreras
