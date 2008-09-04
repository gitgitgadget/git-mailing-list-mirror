From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitweb pathinfo improvements
Date: Thu, 04 Sep 2008 12:02:37 -0700
Message-ID: <7v63pb4tv6.fsf@gitster.siamese.dyndns.org>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
 <g9lncf$182$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbK7V-0004Kr-Ak
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbYIDTCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYIDTCq
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:02:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbYIDTCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:02:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 093035B10B;
	Thu,  4 Sep 2008 15:02:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2A67B5B109; Thu,  4 Sep 2008 15:02:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E19A85E-7AB4-11DD-9306-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94946>

Please don't top post ;-).

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Damn, I forgot the patch sequence numbers.

And please don't send a message without useful contents.  Instead of
cursing alone, after that sentence you could have said:

    Each of them is a reply to the previous one in the sequence so if your
    MUA threads correctly that is the order of the patches in the sequence,
    but in case yours doesn't, they should apply in this order:

        [PATCH 1/5] gitweb: action in path with use_pathinfo
        [PATCH 2/5] gitweb: use_pathinfo filenames start with /
        [PATCH 3/5] gitweb: parse parent..current syntax from pathinfo
        [PATCH 4/5] gitweb: use_pathinfo creates parent..current paths
        [PATCH 5/5] gitweb: remove PATH_INFO from $my_url and $my_uri
