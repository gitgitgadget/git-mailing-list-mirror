From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Sun, 25 Jan 2009 02:32:38 -0500
Message-ID: <f73f7ab80901242332x7de1f856j51181c3c05cf2b11@mail.gmail.com>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
	 <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
	 <831vuvfh7t.fsf@kalahari.s2.org>
	 <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
	 <83wscndv57.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Sun Jan 25 08:34:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQzVS-00031x-U2
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 08:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZAYHck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 02:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZAYHck
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 02:32:40 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:25016 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbZAYHcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 02:32:39 -0500
Received: by an-out-0708.google.com with SMTP id c2so1023390anc.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 23:32:38 -0800 (PST)
Received: by 10.100.48.19 with SMTP id v19mr638902anv.129.1232868758373; Sat, 
	24 Jan 2009 23:32:38 -0800 (PST)
In-Reply-To: <83wscndv57.fsf@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107046>

On Thu, Jan 22, 2009 at 1:59 PM, Hannu Koivisto <azure@iki.fi> wrote:
> In any case, what Cygwin git does should be expected by Cygwin
> users.  If msysgit wanted to be a really native Windows application
> and store the configuration where Microsoft thinks it should be
> stored, it probably shouldn't store the config under "home
> directory" to begin with (I'm guessing that's what it does) but
> under %USERPROFILE\Application Data\Git (...FILE\Local
> Settings\... in case non-roaming storage is wanted).  And in that
> case the manual might be misleading for msysgit users.  See
> e.g. <http://msdn.microsoft.com/en-us/library/ms995853.aspx>.

Actually, if msysgit really wanted to be a "native" windows program,
it would use the good-old brain-damaged method of storing
everything-and-the-kitchen-sink in the registry, including the
locations and reflogs for every repository you have ever examined.
Admittedly the collection of 150+ dotfiles in my Linux homedir looks
relatively similar to parts of the windows registry at times...

Cheers,
Kyle Moffett
