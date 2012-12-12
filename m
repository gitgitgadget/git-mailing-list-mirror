From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v2 1/6] git-remote-helpers.txt: document invocation before input format
Date: Thu, 13 Dec 2012 00:05:35 +0100
Message-ID: <A0E9390A-58CE-4E3E-A1A6-2D5CDB62FE06@quendi.de>
References: <1354057407-83151-1-git-send-email-max@quendi.de> <1354057407-83151-2-git-send-email-max@quendi.de> <CAMP44s3vO9b4-XxqatEc2w3KJLqLGgyjPuKpQkAXHQwTJJEQTg@mail.gmail.com> <839EECE2-4459-4358-B7E8-5D64374A0540@quendi.de> <CAMP44s1xetknwdOT5EseuASQE_2WFP1e1-Ao2RWYeya+EJ9SfQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:05:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivNE-0000Ks-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab2LLXFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:05:39 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:44319 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754013Ab2LLXFi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:05:38 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TivMt-0007pQ-Vl; Thu, 13 Dec 2012 00:05:36 +0100
In-Reply-To: <CAMP44s1xetknwdOT5EseuASQE_2WFP1e1-Ao2RWYeya+EJ9SfQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1355353538;f6fa2e64;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211412>


On 13.12.2012, at 00:00, Felipe Contreras wrote:
[...]

>>> 
>>> I find all this text a bit confusing. First argument, second argument,
>>> etc. Personally, I would describe everything in the terms of alias
>>> (1st arg), and URL (2nd arg).
>> 
>> Yeah, I also thought about that, but as above, deliberately did not touch it here, but only moved it around. I'll be happy to revisit this on a future date, though.
> 
> Oh, in that case it's fine, but I would have named it "move invocation
> before input format", or something that has *move*, or *shuffle*.

Agreed. It explicit says move in the body of the commit message, but not in the summary line.. That would be an improvement, I gueess. Junio, if you want, feel free to reword the summary line of the patch accordingly, e.g. changing it from

  git-remote-helpers.txt: document invocation before input format

to something like

  git-remote-helpers.txt: move 'invocation' section before 'input format'

Of course I can also re-roll, if that is necessary/preferred.


Cheers,
Max