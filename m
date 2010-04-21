From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Add warning when there are changes in the index and using -a with 
	git commit
Date: Thu, 22 Apr 2010 00:38:18 +0200
Message-ID: <w2r7fce93be1004211538pe406dfebs79e1f4673e521988@mail.gmail.com>
References: <v2m7fce93be1004211320r9adc0b14j11bd06c3b045e639@mail.gmail.com>
	 <q2pfabb9a1e1004211421q80d273ady11f4621284522c46@mail.gmail.com>
	 <0CCBCCA0-8378-42A8-A925-F60AA09949DC@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 00:38:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4iYu-0004zZ-BU
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 00:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab0DUWiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 18:38:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63099 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab0DUWiU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 18:38:20 -0400
Received: by wyb39 with SMTP id 39so4401339wyb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 15:38:18 -0700 (PDT)
Received: by 10.216.170.71 with HTTP; Wed, 21 Apr 2010 15:38:18 -0700 (PDT)
X-Originating-IP: [80.13.22.90]
In-Reply-To: <0CCBCCA0-8378-42A8-A925-F60AA09949DC@wincent.com>
Received: by 10.216.170.147 with SMTP id p19mr464847wel.129.1271889498833; 
	Wed, 21 Apr 2010 15:38:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145473>

On Wed, Apr 21, 2010 at 23:38, Wincent Colaiuta <win@wincent.com> wrote:

> Without even really meaning to, I ended up training myself to only commit what's staged in the index, because early on I acquired the habit of always reviewing every single changed hunk by using "git add --patch" (in fact I use it so often that I've created an alias of "git patch" for it). There's no telling how many times this kind of last-minute hunk-by-hunk reviewing has saved me from committing bad code.

Well, the thing is I do that to but instinctively, 3 seconds after, I
do my git commit -as -m "blah", making useless the time I spend
staging hunks with git add -p

-- 
Sylvain
