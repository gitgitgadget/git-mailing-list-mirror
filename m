From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Add a test case for rerere
Date: Fri, 28 Apr 2006 10:02:56 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060428080256.GA1877@informatik.uni-freiburg.de>
References: <20060428075604.GA30714@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 28 10:03:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZNwN-0007pV-NM
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 10:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWD1IC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 04:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWD1IC7
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 04:02:59 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:26273 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1030305AbWD1IC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 04:02:58 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FZNwH-0006fF-0F
	for git@vger.kernel.org; Fri, 28 Apr 2006 10:02:57 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k3S82uG01967
	for git@vger.kernel.org; Fri, 28 Apr 2006 10:02:56 +0200 (MEST)
To: git <git@vger.kernel.org>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060428075604.GA30714@digi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19268>

Hello,

Uwe Zeisberger wrote:
> +echo "added in branch" >> file-common &&
> +git add file-branch file-common &&
> +git commit -m "branch1" -i file-base file-branch file-common &&
> +git branch branch1'
> +
> ...
> + 
> +test_expect_failure 'pull branch1' \
> +'git pull . branch1'

When typing the test I first tried to pull branch^, but this failed with
"no such remote ref refs/heads/branch^".  Is it intended that one can
only pull branches and not any rev?

Best regards
Uwe

PS: I added a double blank line in the file.  Sorry for that...

-- 
Uwe Zeisberger

http://www.google.com/search?q=Planck%27s+constant%3D
