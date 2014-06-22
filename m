From: Jeremy Harris <jgh@wizmail.org>
Subject: Re: gitk's truncated tags
Date: Sun, 22 Jun 2014 21:49:38 +0100
Message-ID: <53A74162.2060705@wizmail.org>
References: <53848147.1090604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Ondrej Oprala <ooprala@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 23:06:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyoyK-00035v-Mb
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 23:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbaFVVGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 17:06:35 -0400
Received: from wizmail.org ([217.146.107.12]:53500 "EHLO wizmail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbaFVVGe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 17:06:34 -0400
X-Greylist: delayed 1006 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jun 2014 17:06:34 EDT
Received: from [46.33.133.68] (helo=lap.dom.ain)
	from_AS 51561 by wizmail.org
	with esmtpsa
	(TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.83_RC2-19-1bbf2ec)
	id 1Wyohp-0005KX-IU
	(return-path <jgh@wizmail.org>); Sun, 22 Jun 2014 20:49:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53848147.1090604@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252314>

On 27/05/14 13:12, Ondrej Oprala wrote:
> Hi, is there any way to display full tag names in gitk,
> for tag names longer than 16 characters? The way 1.8.x did things?

The offending commit is 4399fe3 and reverting it restores my
preferred view, too (there was slight entanglement with
76d64ca which I ignored).
-- 
Cheers,
    Jeremy
