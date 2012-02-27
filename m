From: =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
Subject: Re: [PATCH 2/2] builtin/symbolic-ref.c: add option to output shortened
 ref
Date: Mon, 27 Feb 2012 23:46:05 +0100
Message-ID: <4F4C07AD.3050404@jk.gs>
References: <1330380638-9738-1-git-send-email-jk@jk.gs> <7vwr7752s8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 23:50:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S29OW-0007xY-Fp
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab2B0WuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 17:50:06 -0500
Received: from plane.gmane.org ([80.91.229.3]:43541 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224Ab2B0WuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 17:50:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S29ON-0007qw-9Z
	for git@vger.kernel.org; Mon, 27 Feb 2012 23:50:03 +0100
Received: from xdsl-89-0-11-50.netcologne.de ([89.0.11.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 23:50:03 +0100
Received: from jk by xdsl-89-0-11-50.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 23:50:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: xdsl-89-0-11-50.netcologne.de
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vwr7752s8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191689>

On 02/27/2012 11:28 PM, Junio C Hamano wrote:
> I think this one (unlike 1/2) makes sense, but a single letter -s feels a
> bit too vague.  Always spelling in long option "--short" so that it
> matches "%(refname:short)" in for-each-ref might be better, I would think.
> 
> Especially given that the expected use case is primarily in scripts not
> from the command line, being more explicit and easier to read has value
> over being short and easier to (mis)type.

Good point. If we can agree on what to do with the first patch, I'll
change that in the next iteration.

-Jan
