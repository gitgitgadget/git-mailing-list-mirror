From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] t7508-status: test all modes with color
Date: Tue, 08 Dec 2009 17:06:36 +0100
Message-ID: <4B1E798C.5050204@drmicha.warpmail.net>
References: <cover.1260266027.git.git@drmicha.warpmail.net> <39211ecec866882503d1188d359e1183341faeb1.1260266027.git.git@drmicha.warpmail.net> <hflc82$sf8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 17:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI2bd-0003X7-ES
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 17:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbZLHQHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 11:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbZLHQHs
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 11:07:48 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41292 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932332AbZLHQHs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 11:07:48 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2550EC54DD;
	Tue,  8 Dec 2009 11:07:54 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 08 Dec 2009 11:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vj97atAJJkCy4sSQH44dEe82Lrg=; b=WsanK9xehQFeHuXZB2vhiedWDOaOjqhGgghmu7c6sDoAk5btfvI/WsLUtSJcdUtOYV/v9zszVDSpgGiR+o/nZKf6j1DTraZnmNVy970wBzYI2GVHq34Z2uLjYm/TuWEDE6Raxm/XxVl53THF+/4z5ryzh5dWsi+MQnxwvoyvNQ4=
X-Sasl-enc: HEq4qUo5fDdVo7Iw6w3kFnC3EhS83ljtGnMBt7G4WwBv 1260288473
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8FD0A4A8B81;
	Tue,  8 Dec 2009 11:07:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <hflc82$sf8$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134889>

Jakub Narebski venit, vidit, dixit 08.12.2009 12:10:
> Michael J Gruber wrote:
> 
>> +decrypt_color () {
>> +       sed \
>> +               -e 's/.\[1m/<WHITE>/g' \
>> +               -e 's/.\[31m/<RED>/g' \
>> +               -e 's/.\[32m/<GREEN>/g' \
>> +               -e 's/.\[34m/<BLUE>/g' \
>> +               -e 's/.\[m/<RESET>/g'
>> +}
> 
> Shouldn't this be better in test-lib.sh, or some common lib 
> (lib-color.sh or color-lib.sh; we are unfortunately a bit inconsistent
> in naming here)?

Well, so far it's used in two places (and somewhat differently). I would
say test-libification starts at 3 :)

Michael
