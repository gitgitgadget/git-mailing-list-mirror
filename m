From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Sat, 17 Oct 2015 12:44:25 +0200
Message-ID: <20151017104425.GF2468@distanz.ch>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
 <1444911524-14504-3-git-send-email-tklauser@distanz.ch>
 <xmqqoag0ggjh.fsf@gitster.mtv.corp.google.com>
 <20151016075134.GM11304@distanz.ch>
 <xmqq8u72g1hm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 12:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnOyY-0003IM-Nv
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 12:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbbJQKoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 06:44:30 -0400
Received: from sym2.noone.org ([178.63.92.236]:55816 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbbJQKo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 06:44:29 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ndLZL5k0XzQWhr; Sat, 17 Oct 2015 12:44:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqq8u72g1hm.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279785>

On 2015-10-16 at 19:35:49 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> >> So this is your output code, which gives only the number of lines
> >> without the cleaned up result.
> >
> > This should better be a simple printf("%zu\n", lines) I guess?
> 
> I think we actively avoid using %z conversion that is only C99.
> 
> If you really want to, you could count in size_t and use %lu with
> appropriate casting, which I think is what we do in the rest of the
> codebase.
> 
> For this one, I think it is sufficient to just count in int and
> print as int with %d, though.

Ok, will use an int to count and printf("%d\n").
