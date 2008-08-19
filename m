From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] test-lib.sh: work around ksh's trap shortcomings
Date: Mon, 18 Aug 2008 20:27:14 -0500
Message-ID: <cqiOMMbzSSjqZoLDEa5uscl2d0D71PrGu2TpSOULLuV5nTVnEEWCzQ@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil> <7vbpzplw9o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 03:28:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVG1V-0004RW-W8
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 03:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYHSB1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 21:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYHSB1e
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 21:27:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54941 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbYHSB1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 21:27:34 -0400
Received: by mail.nrlssc.navy.mil id m7J1REX2006521; Mon, 18 Aug 2008 20:27:14 -0500
In-Reply-To: <7vbpzplw9o.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Aug 2008 01:27:14.0080 (UTC) FILETIME=[B5A43A00:01C9019A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92804>

Junio C Hamano wrote:
> Your alias test_done that calls function test_done look ugly and confusing
> beyond words.  Perhaps test_done() can instead set a global variable and
> die() can notice it instead, like this?  I haven't bothered to change the
> other "trap - exit" but I think you got the idea...

Yes that works and is much clearer. Tested on solaris and irix.

-brandon
