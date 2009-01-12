From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: patches in context format ?
Date: Mon, 12 Jan 2009 11:34:00 +0200
Message-ID: <871vv8rhpz.fsf@iki.fi>
References: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Christian MICHON" <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJCl-0006U1-Gc
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbZALJeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZALJeG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:34:06 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:37188 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbZALJeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:34:05 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B89039B8267; Mon, 12 Jan 2009 11:34:01 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LMJBI-0002C9-Hz; Mon, 12 Jan 2009 11:34:00 +0200
In-Reply-To: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com> (Christian MICHON's message of "Mon\, 12 Jan 2009 10\:00\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105313>

Christian MICHON (2009-01-12 10:00 +0100) wrote:

> is there another way to translate from "context" to "unified" format ?

Well, this is not exactly the best solution for a Vim user but this is
the only way I know. Emacs can convert diffs between the formats. You
don't even need to launch Emacs, just run it in batch mode:

    $ emacs --batch -Q --file input.diff \
        --eval '(diff-context->unified (point-min) (point-max))' \
        --eval '(save-buffer)'
