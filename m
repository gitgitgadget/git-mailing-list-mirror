From: "J. Bakshi" <joydeep.bakshi@infoservices.in>
Subject: Re: How to add folder NON RECURSIVELY ?
Date: Wed, 4 Apr 2012 12:22:24 +0530
Message-ID: <201204040652.q346qaC8020941@VM-MailSafe-02.soltecsis.com>
References: <20120403173111.5329d7ed@shiva.selfip.org>
	<vpqzkatc915.fsf@bauges.imag.fr>
	<201204031223.q33CMvQC004186@VM-MailSafe-02.soltecsis.com>
	<vpqaa2tc5xi.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFK5X-000891-IQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 08:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab2DDGw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 02:52:58 -0400
Received: from smtp.unlimitedmail.net ([94.127.184.243]:43220 "EHLO
	VM-MailSafe-02.soltecsis.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751290Ab2DDGw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 02:52:58 -0400
Received: from shiva.selfip.org (ABTS-North-Static-116.30.176.122.airtelbroadband.in [122.176.30.116] (may be forged))
	(authenticated bits=0)
	by VM-MailSafe-02.soltecsis.com (8.14.5/8.14.5) with ESMTP id q346qaC8020941;
	Wed, 4 Apr 2012 08:52:38 +0200
In-Reply-To: <vpqaa2tc5xi.fsf@bauges.imag.fr>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAgMAAAAqbBEUAAAADFBMVEW2UCaWJQ3jnnRrCARshP4hAAACQElEQVQokRWSzU4aYRiFDwhiJjGAimxqRlzhbGpDm24wjmhTQtIIOlMag6GXUP92Tj5obcaaJqRJidvBlDi8N1FpbUzcFGgNK0MvgZKZsmHydVw+OWd1zgOiaH+98Ejt/SGCaTDlmZMYdl+cEmjMKQydBL97kJFAYlfbVab5KHS5AONrnoenPhVHbU1A4yezEYup+1crGRhtfuv9kPZtLRcz8Mw4ykJ1UPJF72Qkg09SdHFFxkY/iZW1HxNSY/zLSbS1B9sKLW7TaU3yB55DHXnjL4n0m1BSRNOZoKo8IXqx1YVqZ6is+C0YwS7Gml4q5/mdRFEbSkig95xbZEaHCMpEJ5x3yPRzyCEqzcTm0lMUscEEE0gfm/64RwPbpJyTIlPbLnNoMoku1JxNAHyTzhzQO2fWXL5PKgOD9H+fPQW4lUqnJk0OqkYEWorETE0SBzrmwFP0lj7Gn1r6qgZ4z8/jM/GVm7Mcg5apH4db8d43PccBoY6oHGAdPRuBX2m8DrSn+Y1+GALLNtLskjWFQHaEXsvMFvsFgc5sD4oyZT39wjiJQwu5ljRbSheqQnHIEfGfV2n+oL7KeBetvrcumQc1lbsQWJVj2fkDk/dceCwqi6qn4y7gcLxhlnCY71DgyGG4yNuvKnyPfBtzNipdRy6r/YXI9Pc+dM7WocqIHGU7KDlsSQn7wsHfSS9MVti9Dau5jfYkuU
 9Y13Z45+havZRg6H/Xhgk+au7c61L6FVD3XVu44IpkPpxUtnrqkiXRf3v/EFxxaZnHAAAAAElFTkSuQmCC
X-SOLTECSIS-MailScanner-ID: q346qaC8020941
X-SOLTECSIS-MailScanner: Found to be clean
X-SOLTECSIS-MailScanner-From: joydeep.bakshi@infoservices.in
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194682>

On Tue, 03 Apr 2012 15:15:37 +0200
Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> "J. Bakshi" <joydeep.bakshi@infoservices.in> writes:
> 
> > Could you please suggest how can I add foo/dir1/file1 ?
> >
> > guess
> >
> > touch foo/dir1/.gitignore
> > git add foo/dir1/
> 
> Not if you want only "file1" to be added. As I said, Git doesn't know
> and doesn't want to know about directories. So "git add directory/" is
> just a shorthand that adds all (non-ignored) files in this directory.
> 
> > git add foo/dir1/file1
> 
> This last line alone will do it.
> 

Thanks a lot to all of you for your valuable suggestion.
