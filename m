From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Tue, 29 Jan 2013 23:02:38 +0000
Message-ID: <20130129230238.GF1342@serenity.lan>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
 <20130129194846.GD1342@serenity.lan>
 <7vr4l3oi1z.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4e=pg=YJ4CfUk7guUCcikBtXTveVX9j6CV5NtGvPB=9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 00:03:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0KCp-00069i-Sm
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 00:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab3A2XCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 18:02:47 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:42700 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3A2XCp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 18:02:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 30EE6CDA605;
	Tue, 29 Jan 2013 23:02:45 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3GqGGeKAwYkY; Tue, 29 Jan 2013 23:02:44 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 8817ACDA5AF;
	Tue, 29 Jan 2013 23:02:40 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr4e=pg=YJ4CfUk7guUCcikBtXTveVX9j6CV5NtGvPB=9Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214980>

On Tue, Jan 29, 2013 at 02:27:21PM -0800, David Aguilar wrote:
> I don't want to stomp on your feet and poke at this file too much if
> you're planning on building on top of it (I already did a few times
> ;-).  My git time is a bit limited for the next few days so I don't
> want to hold you up.  I can help shepherd through small fixups that
> come up until the weekend rolls around and I have more time, but I
> also don't want to hold you back until then.
> 
> I will have some time tonight.  If you guys would prefer an
> incremental patch I can send one that changes the "ls" expression and
> the way the unavailable block is structured.  Otherwise, I can send
> replacements to handle the "test -z" thing, $TAB$TAB, and the
> simplification of the unavailable block.
> 
> Later patches (that are working towards the new feature) can
> generalize show_tool_names() further and eliminate the need for the
> available/unavailable variables altogether.  John, I would imagine
> that you'd want to pick that up since you're driving towards having
> --tool-help honor custom tools.
> 
> What do you think?

I was planning to hold off until this series is in a reasonable state -
there's no rush as far as I'm concerned, but if Junio's happy to leave
these patches with just the small fixups I'm happy to build on that with
a patch that removes the available and unavailable variables before
adding the tools from git-config.


John
