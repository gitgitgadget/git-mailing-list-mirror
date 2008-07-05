From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH v4 0/3]
Date: Sat,  5 Jul 2008 16:40:31 -0400
Message-ID: <1215290434-27694-1-git-send-email-adambrewster@gmail.com>
References: <7vod5crydx.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, adambrewster@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 22:41:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFEZs-00068Q-Tr
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 22:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYGEUks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 16:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbYGEUks
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 16:40:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:47841 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYGEUkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 16:40:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so734742ywe.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=xmFqhYiJj/PgJbdaBoZjbDbbjBGgAeweKYuQy6vWilM=;
        b=WAHbAtNLDpqcSBUg3KZeg/P6VZUp6aowuEpo16c1ZBdR2WOxo2Qo3N9Zw/ABlrgkhg
         h0cC/Bp8FAYWFm57oo8Z4W9sKWB9rpR0nTlZHgh9yoEGy88kpp4fy5OycQHzXLU6kvJf
         36gCrhwi6ieR5bF/WiqGFZnxfNfn41aBtihuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EBhVO2Ptg1QsYn1Wuw272SeeQHodBGexOu8qD2sfzJsJ5LZPVWQ5nD2uUHWYaEHxla
         e9SrKbfvFd7aR+iNCra5TDlPxoMSULdT+cQaAwwQD4FD6ir+Dr6pk3Hniak8e2LypvKs
         QN5EkQDm0AJ5gzPJDro1MtcCuhH0HBN0nBvkE=
Received: by 10.151.145.17 with SMTP id x17mr4743288ybn.20.1215290437022;
        Sat, 05 Jul 2008 13:40:37 -0700 (PDT)
Received: from MBE.internal ( [65.96.168.20])
        by mx.google.com with ESMTPS id 9sm2733970yxs.5.2008.07.05.13.40.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 13:40:36 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id C9AD910499B; Sat,  5 Jul 2008 16:40:34 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <7vod5crydx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87461>


Sorry for the idiotic wrapping problems in my last email.

Previously, I was trying to keep from changing any of the important stuff,
like git-rev-list, but I should know better than cut-and-pasting code.

As requested, I've broken the change into a multiple of patches.  First moving
read_revisions_from_stdin to revision.c, next modifying git-bundle to handle
--stdin, and finally a patch adding my old git-basis to contrib.

I think I've corrected all of the style issues you pointed out, and I've also 
tried to craft more informative commit messages.
