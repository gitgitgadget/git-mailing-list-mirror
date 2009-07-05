From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] run_command: report system call errors instead of returning error codes
Date: Sun, 05 Jul 2009 12:14:45 -0700
Message-ID: <7v3a9bj61m.fsf@alter.siamese.dyndns.org>
References: <cover.1246734159.git.j6t@kdbg.org>
	<4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org>
	<ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
	<200907052101.13741.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 05 21:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNXB3-0005gj-8V
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 21:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbZGETOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 15:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbZGETOy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 15:14:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58473 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbZGETOx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 15:14:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090705191446.DOAU2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 5 Jul 2009 15:14:46 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id CKEl1c00F4aMwMQ03KElVt; Sun, 05 Jul 2009 15:14:46 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=BJGm1wWIO1YA:10 a=A9qS8gIqAAAA:8
 a=9jCltSVw1oBi8_XC18QA:9 a=wHJAjDF8DKpeZxpo_NA2ywbJW1kA:4 a=Kj4G0JfAssAA:10
X-CM-Score: 0.00
In-Reply-To: <200907052101.13741.j6t@kdbg.org> (Johannes Sixt's message of "Sun\, 5 Jul 2009 21\:01\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122749>

Johannes Sixt <j6t@kdbg.org> writes:

> On Samstag, 4. Juli 2009, Johannes Sixt wrote:
>> +	if (status >= 0 || errno != ENOENT)
>> +		exit(status & 0xff);
>
> With my replacement patch 1/7 this '& 0xff' is no longer necessary. Would you
> kindly squash this in?

Sounds sensible.  Thanks.
