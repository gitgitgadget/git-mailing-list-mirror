From: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Subject: Re: [RFC] Common library for Git GUIs
Date: Tue, 17 Feb 2009 13:55:04 +0100
Message-ID: <8b65902a0902170455lda80ea3ybb8ca94eb86d0453@mail.gmail.com>
References: <20090216212459.GA25046@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Feb 17 13:56:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZPVA-00052P-LN
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 13:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbZBQMzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 07:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbZBQMzM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 07:55:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:20210 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZBQMzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 07:55:10 -0500
Received: by fg-out-1718.google.com with SMTP id 16so403595fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 04:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fxIXjtWYnTabPxZoDbUFpq3/fJ2T8xeP8F8kN9hew7c=;
        b=v4a4k/4vTjF5LTVHNl+zpNysV9Fn6MAhbIWZXGjaAXQpxUr62H0cnLE065EfYUG/DF
         pYVhbcJwlLqwR6xt+Gsqfa5QgjO816sZqeOMj9cIa9k7TEK6TwIacJAFizrfilOz0lgJ
         6IPuIY9hHKcZwei60kxT3jQV63MmLHl0y9dkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i0YCdIn/5uaJ30DTaHX/LO7b8uZeRztIo/QIZvOXIjQhtcJ4xF3aLuwmGk1tQ7iP61
         GsPjWlwWxA7rWZ/KlxwQbO56+JUeocXE4fz0BKcUuDeOkgQVlnIVQyderYSAGoAI0SCy
         RZQdNAaRr1itwM7yqnmZfvJNhnNYHvsNwPDHQ=
Received: by 10.103.90.17 with SMTP id s17mr1191026mul.93.1234875304934; Tue, 
	17 Feb 2009 04:55:04 -0800 (PST)
In-Reply-To: <20090216212459.GA25046@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110367>

Hi,

I don't know if it is possible to elect a toolkit. Each toolkit is good.

Concerning the design of the library, I think it is better to split
the library into different layers. The part of the e-world I know
concern Gtk/Gnome, so I will use it for my example.

IMHO, it should be interesting to build a library containing only
GObject'ification of Git and some wrappers/helpers to construct these
objects. For example, some objects to represent authors, commits,
branches, remotes and so on. Coupled to these base-types, this library
should provide solutions to construct these base-types (wrappers
around Git commands and/or internal files).
This library can be named libgit-glib for example.
Such library can help developement of current UI (giggle, gitg,
anjuta-git plugin, and probably others I don't know).

Then, on top of this library, we can imagine another one providing
high-level widgets. But it seems harder to identify common widgets
between different GUI.

In order to justify my idea, take a look at Qt. They started with a
large library, merging low-level with widgets. And then, they split it
in order to allow access to low-level features only.


I'm really interested in such project. So, if someone knows such
project, or create such a project, drop me a line, please.

Regards,
-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
