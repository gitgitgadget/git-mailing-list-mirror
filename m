From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] config.c: Add git_config_bool_or_int to handle
 bool/int variable
Date: Sun, 13 Apr 2008 02:03:43 -0700
Message-ID: <7vprsucej4.fsf@gitster.siamese.dyndns.org>
References: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
 <1208012733-18211-2-git-send-email-pkufranky@gmail.com>
 <7vmynye0cz.fsf@gitster.siamese.dyndns.org>
 <46dff0320804130030q19dd9f23j66d9b7adc7d305d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 11:04:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jky8g-0008T6-7i
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 11:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbYDMJD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 05:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbYDMJD4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 05:03:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbYDMJD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 05:03:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94BD33619;
	Sun, 13 Apr 2008 05:03:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1389C3618; Sun, 13 Apr 2008 05:03:48 -0400 (EDT)
In-Reply-To: <46dff0320804130030q19dd9f23j66d9b7adc7d305d3@mail.gmail.com>
 (Ping Yin's message of "Sun, 13 Apr 2008 15:30:28 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79397>

"Ping Yin" <pkufranky@gmail.com> writes:

>>         return git_config_int(name, value) != 0;
>>   }
>
> Should return an interger if *is_bool==0
> s/!=0//

Yeah, you are right.  I do not know where that "!= 0" came from.
