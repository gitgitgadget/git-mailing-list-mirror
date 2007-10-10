From: David Kastrup <dak@gnu.org>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Wed, 10 Oct 2007 12:33:18 +0200
Message-ID: <858x6bw975.fsf@lola.goethe.zz>
References: <20071010015545.GA17336@lapse.madduck.net>
	<alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org>
	<20071010102528.GB20390@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 12:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfYry-0007Dn-BE
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 12:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXJJKci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 06:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbXJJKci
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 06:32:38 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:58805 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbXJJKch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 06:32:37 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IfYqk-0002ms-CK; Wed, 10 Oct 2007 06:31:34 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 941211C1F3DC; Wed, 10 Oct 2007 12:33:18 +0200 (CEST)
In-Reply-To: <20071010102528.GB20390@lapse.madduck.net> (martin f. krafft's message of "Wed\, 10 Oct 2007 11\:25\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60490>

martin f krafft <madduck@madduck.net> writes:

> also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.10.10.0354 +0100]:
>> Cherry-picking is immaterial. It doesn't matter how the changes
>> come into the tree. It doesn't matter what the history is. The
>> only thing git cares about is the content, and the end result.
>
> This is the part I over-estimated. I thought that Git would figure
> out that commits 1-3 had been merged into the target and thus apply,
> in sequence, only the commits from the source which had not been
> merged.
>
> Many thanks (again), Linus! Looking forward to your next content
> manager; you know, the one with artificial intelligence built in!
> You could call it "wit" :)

Well, there is also an obvious name choice when the distinguishing
innovation is a well-rounded feature set, but it would cause a name
collision for the equivalent of "tig".

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
