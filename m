From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: reset color before printing newline
Date: Mon, 16 Jun 2008 17:59:44 -0700
Message-ID: <7vhcbs98qn.fsf@gitster.siamese.dyndns.org>
References: <1213653602-31307-1-git-send-email-szeder@ira.uka.de>
 <20080617002205.GD7003@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 03:00:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8PZ3-0007YH-EC
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 03:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbYFQA7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2008 20:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYFQA7y
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 20:59:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYFQA7y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 20:59:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCDF5C3EC;
	Mon, 16 Jun 2008 20:59:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 28212C3EA; Mon, 16 Jun 2008 20:59:47 -0400 (EDT)
In-Reply-To: <20080617002205.GD7003@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Tue, 17 Jun 2008 02:22:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0FAAC16-3C08-11DD-B061-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85253>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> So this should be squashed to the previous patch.

Yeah, I noticed the breakage after I pushed the results out and made an
equivalent quickfix and re-pushed out.
