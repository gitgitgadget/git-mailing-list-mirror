From: David Abrahams <dave@boostpro.com>
Subject: Re: git diff bug?
Date: Mon, 6 Apr 2009 13:58:08 -0400
Message-ID: <D4B0EDF7-E1BD-44E3-858F-002CFF2C496A@boostpro.com>
References: <m2ocvdkyul.fsf@boostpro.com> <20090404014527.GA13350@coredump.intra.peff.net> <1BF9172A-BE91-4D1C-932A-EB9FD79BA402@boostpro.com> <49DA156A.1000105@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 20:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqt6q-0003w6-6C
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 19:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbZDFR6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 13:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbZDFR6N
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 13:58:13 -0400
Received: from boost-consulting.com ([206.71.190.141]:61380 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbZDFR6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 13:58:12 -0400
Received: from [192.168.188.134] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id ED3A41CC1F;
	Mon,  6 Apr 2009 10:56:13 -0700 (PDT)
In-Reply-To: <49DA156A.1000105@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115861>


On Apr 6, 2009, at 10:44 AM, Michael J Gruber wrote:

>
> Well, I don't think anayone else has tried putting config lines into
> .gitattributes ;)
>
> The "*.el" line goes into .gitattributes (or .git/info/a...), the  
> other
> lines are config lines and thus goe into .git/config or .gitconfig.


Aha, thanks.  The hunk header section in the gitattributes manpage  
turns out to be the only one that shows config stuff without  
mentioning a config file, thus my confusion.  I suggest a tiny patch  
('cept I don't know how to write manpage format)

--
David Abrahams
BoostPro Computing
http://boostpro.com
