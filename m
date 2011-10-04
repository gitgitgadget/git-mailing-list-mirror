From: Gioele Barabucci <gioele@svario.it>
Subject: Git attributes ignored for root directory
Date: Tue, 04 Oct 2011 20:52:43 +0200
Message-ID: <4E8B55FB.1050203@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 21:00:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBAE4-0005CR-CV
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 21:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933404Ab1JDTAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 15:00:18 -0400
Received: from begonia.svario.it ([91.213.195.127]:48670 "EHLO
	begonia.svario.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab1JDTAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 15:00:18 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Oct 2011 15:00:18 EDT
Received: from [192.168.2.2] (dynamic-adsl-84-223-204-232.clienti.tiscali.it [84.223.204.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: gioele@svario.it)
	by begonia.svario.it (Postfix) with ESMTPSA id 191452CE3C
	for <git@vger.kernel.org>; Tue,  4 Oct 2011 18:52:43 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110923 Thunderbird/7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182787>

Hello,

I just updated to git v1.7.7 using the Ubuntu Lucid PPA and I found that 
`git check-attr` is broken now.

I have this attribute in my `$HOME/.gitattributes` file:

     /. show_in_prompt=no

Now, if I go to `$HOME` and run

     git check-attr show_in_prompt -- .

With git v1.7.6 this is the answer I got:

     .: show_in_prompt: no

With the newer v1.7.7 I get this, instead:

     .: show_in_prompt: unspecified

Also, if I use the `--all` option, `check-attr` does not show any 
attribute at all.

I see in the release notes of 1.7.7-rc1 that `check-attr` has been 
changed to allow relative paths to be specified. Maybe this error is 
related to that change.

Best,

-- 
Gioele Barabucci <gioele@svario.it>
