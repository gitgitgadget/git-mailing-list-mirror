From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about your git habits
Date: Fri, 22 Feb 2008 17:51:04 -0800
Message-ID: <7vfxvk4f07.fsf@gitster.siamese.dyndns.org>
References: <200802221837.37680.chase.venters@clientec.com>
 <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr>
 <20080223014445.GK27894@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@computergmbh.de>,
	Chase Venters <chase.venters@clientec.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
X-From: git-owner@vger.kernel.org Sat Feb 23 02:52:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjYn-0002gi-OM
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbYBWBvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYBWBvY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:51:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbYBWBvY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 20:51:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E3F1F566F;
	Fri, 22 Feb 2008 20:51:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A1BB9566B; Fri, 22 Feb 2008 20:51:12 -0500 (EST)
In-Reply-To: <20080223014445.GK27894@ZenIV.linux.org.uk> (Al Viro's message
 of "Sat, 23 Feb 2008 01:44:45 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74783>

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Sat, Feb 23, 2008 at 02:37:00AM +0100, Jan Engelhardt wrote:
>
>> >do you tend to clone the entire repository repeatedly into a series
>> >of separate working directories
>> 
>> Too time consuming on consumer drives with projects the size of Linux.
>
> git clone -l -s
>
> is not particulary slow...

How big is a checkout of a single revision of kernel these days,
compared to a well-packed history since v2.6.12-rc2?

The cost of writing out the work tree files isn't ignorable and
probably more than writing out the repository data (which -s
saves for you).
