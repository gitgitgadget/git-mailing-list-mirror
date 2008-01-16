From: Neil Macneale <mac4-git@theory.org>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 21:27:52 -0800
Message-ID: <478D95D8.5040806@theory.org>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 06:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF0zh-0000Av-6c
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 06:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYAPFiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 00:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbYAPFiv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 00:38:51 -0500
Received: from in.theory.org ([64.147.163.250]:34412 "EHLO tesla.theory.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbYAPFiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 00:38:51 -0500
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2008 00:38:50 EST
Received: from [10.0.1.199] (63-231-48-22.tukw.qwest.net [63.231.48.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tesla.theory.org (Postfix) with ESMTP id 4231724AE2C;
	Tue, 15 Jan 2008 21:27:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <478D82FA.2030404@talkingspider.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70634>

Mike wrote:
> ....  And as for permissions and ownership, rsync takes care of that.
Perhaps "rsync --exclude *.git"?

It seems to me that you are asking git to be your deployment software, 
which is a bad fit.

Cheers,
Neil
