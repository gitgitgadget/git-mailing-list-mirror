From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Mon, 30 May 2011 06:46:48 +0200
Message-ID: <4DE32138.4050104@alum.mit.edu>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com> <20110528230844.GA31498@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 06:47:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQuNY-0002SX-VY
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 06:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab1E3Eqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 00:46:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50644 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1E3Eqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 00:46:55 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BECF4D.dip.t-dialin.net [84.190.207.77])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p4U4kneL018979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 May 2011 06:46:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110528230844.GA31498@elie>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174718>

On 05/29/2011 01:08 AM, Jonathan Nieder wrote:
> Agh, "git rebase --abort --keep-head" feels a little too long to be
> memorable.  Still, hope that helps.

It seems like the distinction is analogous to "git reset --soft", so maybe

    git rebase --abort --soft

?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
