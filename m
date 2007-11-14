From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Fix man page breakage with DocBook XSL v1.72
Date: Wed, 14 Nov 2007 01:46:53 -0800
Message-ID: <7vbq9xjh0y.fsf@gitster.siamese.dyndns.org>
References: <20071114093846.GA21082@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsEq3-0000nN-Oe
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 10:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbXKNJq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 04:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbXKNJq7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 04:46:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56297 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbXKNJq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 04:46:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3E3062F9;
	Wed, 14 Nov 2007 04:47:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CFBD4945C2;
	Wed, 14 Nov 2007 04:47:16 -0500 (EST)
In-Reply-To: <20071114093846.GA21082@diku.dk> (Jonas Fonseca's message of
	"Wed, 14 Nov 2007 10:38:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64972>

Jonas Fonseca <fonseca@diku.dk> writes:

> From version 1.72 it will replace all dots in roff requests with U+2302
> ("house" character), and add escaping in output for all instances of dot
> that are not in roff requests.

Wasn't this "house" thing brought up on the list earlier?  I may
well be recalling things incorrectly, but I somehow thought that
DocBook people realized this was a mistake and the "house" trick
was retracted in later snapshots, or something.
