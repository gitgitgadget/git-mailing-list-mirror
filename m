From: greened@obbligato.org
Subject: Re: [PATCH] Add --unannotate option to git-subtree
Date: Tue, 22 Jan 2013 02:41:02 -0600
Message-ID: <87d2wxfw4h.fsf@waller.obbligato.org>
References: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com>
	<87a9st4sb8.fsf@waller.obbligato.org>
	<CABVa4NhwcD584ptSazOR9WvSWep1z+krhxkWDvUk8nXaF8EYxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:42:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxZQi-0002Mo-GP
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab3AVIln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:41:43 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:37832 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752263Ab3AVIlm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:41:42 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TxZQN-0002dM-Eu; Tue, 22 Jan 2013 02:41:43 -0600
In-Reply-To: <CABVa4NhwcD584ptSazOR9WvSWep1z+krhxkWDvUk8nXaF8EYxQ@mail.gmail.com>
	(James Nylen's message of "Thu, 17 Jan 2013 15:56:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  James Nylen <jnylen@gmail.com> writes: > Wow, I missed a bunch
    of emails on this. Thanks for applying and for > writing tests! Sorry it
   took so long. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214222>

James Nylen <jnylen@gmail.com> writes:

> Wow, I missed a bunch of emails on this.  Thanks for applying and for
> writing tests!

Sorry it took so long.

> This is as intended.  You wouldn't want subtree to modify commits that
> occurred in the full repository for project A.  Furthermore, you
> wouldn't have a "subproj:" commit in project A's standalone repo since
> it wasn't a subproject at that time.

Yes, that makes sense.

> The --annotate option confused me because it was the reverse of what I
> wanted.  As in your example, a typical use would be 'add a file to
> subdir with message "subproj: add F3" ' to make it clear that you were
> committing to the "subproj" part of a larger repository.  Then, when
> splitting back out to subproj's main repository, you'd want to remove
> the prefix.

Ok.  I'll re-submit as part of the final sequence.

Thanks for the patch!

                            -David
