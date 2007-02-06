From: Junio C Hamano <junkio@cox.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 06 Feb 2007 11:14:03 -0800
Message-ID: <7vwt2vgkuc.fsf@assigned-by-dhcp.cox.net>
References: <87odognuhl.wl%cworth@cworth.org>
	<87y7nbdeaw.wl%cworth@cworth.org>
	<7vveifkczt.fsf@assigned-by-dhcp.cox.net>
	<87wt2vce31.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 20:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEVlY-0008RZ-Qx
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 20:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbXBFTOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 14:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbXBFTOF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 14:14:05 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:42335 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751753AbXBFTOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 14:14:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206191403.PUYF1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 14:14:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LKE31W00R1kojtg0000000; Tue, 06 Feb 2007 14:14:03 -0500
In-Reply-To: <87wt2vce31.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	06 Feb 2007 10:53:38 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38869>

Carl Worth <cworth@cworth.org> writes:

> On Mon, 05 Feb 2007 22:37:42 -0800, Junio C Hamano wrote:
>> Carl Worth <cworth@cworth.org> writes:
>>
>> > So, could we fix this so that a remote branch name will resolve
>> > without the "origin/" prefix if it is not ambiguous?
>>
>> I am fairly negative on this one, especially I do not think the
>> symptom deserves to be described with the word "fix".  DWIM is
>> good, but it has bounds, and this particular one feels it is
>> slightly on the other side of the boundary.
>
> I can accept that argument.
>
> With "fix" I was referring to the backwards-compatibility problem,
> (that I don't have a way to give branch checkout instructions to users
> that will work for both 1.5 and pre-1.5 versions of git).

If you tell your users to --use-separate-remote in the "git
clone" instruction, would that solve your backward compatibility
problem?
