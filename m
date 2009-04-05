From: Teemu Likonen <tlikonen@iki.fi>
Subject: Gnus content transfer encoding (was: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to  efficiently lookup sha1)
Date: Sun, 05 Apr 2009 23:28:22 +0300
Message-ID: <87r60626c9.fsf_-_@iki.fi>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
	<fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
	<7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
	<94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
	<3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
	<7vocvaq36x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYym-0002MJ-Jh
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261AbZDEU2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbZDEU2g
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:28:36 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:41139 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881AbZDEU2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:28:35 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 49D075A8004C236C; Sun, 5 Apr 2009 23:28:29 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LqYx4-0001Rk-QK; Sun, 05 Apr 2009 23:28:22 +0300
In-Reply-To: <7vocvaq36x.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 05 Apr 2009 13\:02\:30 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115700>

On 2009-04-05 13:02 (-0700), Junio C Hamano wrote:

> Reece Dunn <msclrhd@googlemail.com> writes:
>> I think Junio is trying to learn base64 :)!
>
> I think that is what my Gnus/message-mode did. I do not know which
> letter triggered it to decide it is UTF-8 to begin with, though. As
> far as I am aware, I didn't type anything non-ascii in my message.

You can customize the encoding decision mechanism, for example:

    (setq mm-body-charset-encoding-alist
          '((iso-8859-1 . 8bit)
            (utf-8 . 8bit)))

For more info, see:

    C-h v mm-body-charset-encoding-alist RET
