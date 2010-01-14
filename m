From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Using GIT with FrameMaker
Date: Thu, 14 Jan 2010 10:33:34 +0100
Message-ID: <vpq1vhtuj2p.fsf@bauges.imag.fr>
References: <loom.20100114T094846-797@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rivka Pollack <Rivka_P1@verifone.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 10:36:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVM7f-0001Uj-Bc
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 10:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab0ANJgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 04:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071Ab0ANJgF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 04:36:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:50532 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab0ANJgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 04:36:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o0E9XZm1021523
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jan 2010 10:33:36 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NVM58-0001zV-PZ; Thu, 14 Jan 2010 10:33:34 +0100
In-Reply-To: <loom.20100114T094846-797@post.gmane.org> (Rivka Pollack's message of "Thu\, 14 Jan 2010 08\:50\:49 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 14 Jan 2010 10:33:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136978>

Rivka Pollack <Rivka_P1@verifone.com> writes:

> Hi,
> My Technical Documentation team has recently been informed that we are to be
> moving to GIT for our version control.
> We will be working in GIT GUI or GIT extensions.
> I see, however, that you cannot properly use the "diff" view properly with the
> FrameMaker files, but only, from what I can tell, .txt, and .html.

Not just .txt and .html. Anything that looks like text (i.e. anything
that can be opened in a text editor and looks good in it).

> Is there a good way to work with GIT from FrameMaker?

FrameMaker, I have no idea. But Git has two things that can help you:

* External diff engine: read about GIT_EXTERNAL_DIFF in
  http://www.kernel.org/pub/software/scm/git/docs/v1.0.13/git-diff-files.html
  and look for "Defining an external diff driver" in
  http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html

  Roughly, if FrameMaker has a way to compare two documents, then Git
  can call it automatically.

* Text Converters: Read the section "Performing text diffs of binary
  files" in
  http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html

  Roughly: if you have a way to display the content of your framemaker
  files as text, then Git can call this, and then show a textual diff
  of your document.

In this page http://www-verimag.imag.fr/~moy/opendocument/ I explain
how to do that with OpenDocument files (OpenOffice & friends). If
FrameMaker provides the relevant tools, it shouldn't be hard to adapt.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
