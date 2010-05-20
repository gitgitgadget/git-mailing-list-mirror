From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 12:38:43 +0200
Message-ID: <4BF51133.6040504@syntevo.com>
References: <4BF4E40B.30205@math.tu-dortmund.de> <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com> <4BF4F7D7.60002@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 20 12:38:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF39E-00032J-Mh
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0ETKi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:38:29 -0400
Received: from syntevo.com ([85.214.39.145]:35605 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326Ab0ETKi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:38:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 1027717402C
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF4F7D7.60002@drmicha.warpmail.net>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147381>

On 20.05.2010 10:50, Michael J Gruber wrote:
> There seems to be no way to reliably detect which one HFS+ uses.

IIRC, HFS+ always stores and reports the file names with decomposed UTF-8,
even if the file is created using composed UTF-8. IMHO, Git should
standardize on the file and text encoding (e.g. commit messages) used in the
repository, so such problems can't occur. SVN has standardized on "UTF-8" in
the repository, but had/s similar problems on OS X with the decomposed
characters:

 http://subversion.tigris.org/issues/show_bug.cgi?id=2464

Tom
