From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Tue, 30 Aug 2011 06:16:04 +0000 (UTC)
Message-ID: <loom.20110830T081442-547@post.gmane.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com> <CA+55aFzk+hn9wMAp3H92SHAGO8CQVBpTsmR41FgCy32T7muUzA@mail.gmail.com> <7v1uw36fgb.fsf@alter.siamese.dyndns.org> <CA+55aFz9givAWhP5_SfnneY6x_0ekcN2U9HrKr+NTgY=Ot=6TQ@mail.gmail.com> <7vfwkj4wff.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 08:16:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyHcl-0004yV-S6
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 08:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab1H3GQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 02:16:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:47512 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085Ab1H3GQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 02:16:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QyHcO-0004sf-Hr
	for git@vger.kernel.org; Tue, 30 Aug 2011 08:16:17 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 08:16:16 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 08:16:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180392>

Junio C Hamano <gitster <at> pobox.com> writes:
> Marat, if/when you have a chance could you try a patched git on your
> original use case and see if it produces correct output with shorter
> amount of time?

30s without patch and 0.3s with it. You rock :)
