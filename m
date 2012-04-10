From: greened@obbligato.org
Subject: Re: git-subtree Next Round Ready
Date: Mon, 09 Apr 2012 22:34:50 -0500
Message-ID: <87bon01cpx.fsf@smith.obbligato.org>
References: <87398we3ox.fsf@smith.obbligato.org>
	<7vobrgs5tb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 05:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHRvs-00064s-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 05:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495Ab2DJDja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 23:39:30 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:41259 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758446Ab2DJDiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 23:38:55 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SHOCi-0005zC-JU; Mon, 09 Apr 2012 18:41:00 -0500
In-Reply-To: <7vobrgs5tb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 28 Mar 2012 15:45:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > I think it would
    make more sense, from the history viewpoint, to: > > - Stop the history of
    the "subtree" branch at commit d3a04e0 (Use Test > Harness, 2012-01-29);
   > > - Create "for-upstream" branch that is a fork of 1.7.10 (when tagged);
    > > - On "for-upstream" branch, add all the files from d3a04e0 (Use Test
   > Harness, 2012-01-29) to contrib/subtree, and record it as a merge > between
    1.7.10 and d3a04e0 (you can use subtree merge for this); and > finally >
   > - Replay the 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195056>

Junio C Hamano <gitster@pobox.com> writes:

> I think it would make more sense, from the history viewpoint, to:
>
>  - Stop the history of the "subtree" branch at commit d3a04e0 (Use Test
>    Harness, 2012-01-29);
>
>  - Create "for-upstream" branch that is a fork of 1.7.10 (when tagged);
>
>  - On "for-upstream" branch, add all the files from d3a04e0 (Use Test
>    Harness, 2012-01-29) to contrib/subtree, and record it as a merge
>    between 1.7.10 and d3a04e0 (you can use subtree merge for this); and
>    finally
>
>  - Replay the commits between d3a04e0 and the tip of your current
>    "subtree" branch on top of "for-upstream".

All right, this should be ready to go.

git clone git://sources.obbligato.org/git/git.git

Branch is "for-upstream."

Also accessible via gitweb.

                           -Dave
