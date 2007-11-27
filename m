From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Make Git accept absolute path names for files within
 the work tree
Date: Tue, 27 Nov 2007 09:45:00 +0100
Message-ID: <474BD90C.5020102@viscovery.net>
References: <1196119109-27483-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iww4O-0000Uq-R0
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 09:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbXK0IpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 03:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbXK0IpH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 03:45:07 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7159 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbXK0IpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 03:45:05 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iww3H-0004Rv-6z; Tue, 27 Nov 2007 09:44:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AD5B06EF; Tue, 27 Nov 2007 09:45:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1196119109-27483-1-git-send-email-robin.rosenberg@dewire.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66172>

Robin Rosenberg schrieb:
> +test_expect_success 'add files using absolute path names' '
> +echo a >afile &&
> +echo b >bfile &&
> +git-add afile &&
> +git-add $(pwd)/bfile &&

Please use "$(pwd)/bfile" (d-quotes) throughout. Otherwise the test would 
fail if conducted in a directory with spaces.

-- Hannes
