From: Thilo Borgmann <thilo.borgmann@mail.de>
Subject: [RFC] extend imap-send to accept pull-requests
Date: Wed, 14 Aug 2013 11:27:06 +0200
Message-ID: <520B4D6A.8020709@mail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 14 11:38:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9XXB-0003Om-6X
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 11:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab3HNJiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 05:38:25 -0400
Received: from shout01.mail.de ([213.128.151.216]:35888 "EHLO shout01.mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab3HNJiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 05:38:24 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2013 05:38:24 EDT
Received: from dovecot02.mail.de (dovecot02.bt.mail.de [10.0.121.112])
	by shout01.mail.de (Postfix) with ESMTP id 973ED42C9E
	for <git@vger.kernel.org>; Wed, 14 Aug 2013 11:27:06 +0200 (CEST)
Received: from nue066.nue.tu-berlin.de (expurgate12.bt.mail.de [10.0.121.212])
	by dovecot02.mail.de (Postfix) with ESMTP id 6AE1DC022C
	for <git@vger.kernel.org>; Wed, 14 Aug 2013 11:27:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mail201212; t=1376472426;
	bh=Mx3LTe6DdSUTP6Jf8AJ1xu4J77DSwp+IuFry0fJynz0=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=vzFr048iyoVztU7+IgbzV4j5KM9FAwCI3WribBKi32FPo9zCpMpr77oByey783zDd
	 6VeFjT7Viav6MMNpjUEQR6w2XUdl+SHnpu/Wu8syXg+3K0tY7jEDinJggcnqIzppEl
	 1mB9TKdHpFitr0U0m3Q9NkaaR2RQCXuQEvT9gvVQ=
Received: from [130.149.105.156] (helo=nue066.nue.tu-berlin.de)
	by smtp02.mail.de with ESMTPSA (eXpurgate 4.0.0)
	(envelope-from <thilo.borgmann@mail.de>)
	id 520b4d69-0736-0a0078d4024b-8295699cd1b5-3
	for <git@vger.kernel.org>; Wed, 14 Aug 2013 11:27:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
X-Enigmail-Version: 1.5.2
X-purgate-ID: 154282::1376472426-00000736-FA5BF33D/0-0/0-0
X-purgate-type: clean
X-purgate-size: 376
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232279>

Hi,

I want to get rid of my script attaching fake Header lines to a pull-request to
be send to my imap by imap-send.

Or in other words, I want "git request-pull <...> | git imap-send" to work as
expected. Bevore I'm going to work on the code and send patches I want to hear
from you if such a patch would be welcome or be declined for any reasons.

Thanks,
Thilo
