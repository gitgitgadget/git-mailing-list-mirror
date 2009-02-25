From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Fix a bunch of pointer declarations (codestyle)
Date: Wed, 25 Feb 2009 00:02:04 -0800
Message-ID: <7veixnaqrn.fsf@gitster.siamese.dyndns.org>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 09:03:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcEk1-0007si-5a
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913AbZBYICN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757618AbZBYICN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:02:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbZBYICM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:02:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D31929D2E1;
	Wed, 25 Feb 2009 03:02:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B20669D2E0; Wed,
 25 Feb 2009 03:02:06 -0500 (EST)
In-Reply-To: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 24 Feb 2009 23:59:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A29A3C6-0312-11DE-8384-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111386>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This applies on top of the 'next' branch.
>
>  alias.c                                   |    4 +-
>  alloc.c                                   |    2 +-
>  attr.c                                    |    4 +-
>  builtin-blame.c                           |    8 +++---
>  builtin-checkout-index.c                  |    4 +-
>  builtin-describe.c                        |    4 +-
>  builtin-fetch-pack.c                      |    2 +-
>  builtin-help.c                            |    6 ++--
>  builtin-update-index.c                    |    6 ++--
>  cache.h                                   |    2 +-
>  combine-diff.c                            |    4 +-
>  compat/mingw.c                            |    2 +-
>  config.c                                  |   30 ++++++++++++++--------------
>  contrib/convert-objects/convert-objects.c |    6 ++--
>  diff-no-index.c                           |    2 +-
>  diff.c                                    |    6 ++--
>  dir.c                                     |    2 +-
>  fast-import.c                             |   14 ++++++------
>  git.c                                     |    8 +++---
>  http.c                                    |    4 +-
>  lockfile.c                                |    2 +-
>  reflog-walk.c                             |    2 +-
>  run-command.c                             |    2 +-
>  server-info.c                             |    4 +-
>  sha1_file.c                               |    2 +-
>  wt-status.c                               |    2 +-

Sorry, but I cannot take this as is.

These trivial clean-ups are welcome either as part of a preparatory
clean-up before starting to work in the area of code you are touching, or
as a standalone patch to files that nobody is currently working on.

There is a huge overlap between "git diff --name-only master..pu" and the
above list, so it is impossible for me to take the patch and I cannot
afford the time to sift through gems out of stones.
