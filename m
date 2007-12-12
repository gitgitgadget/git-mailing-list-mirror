From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git annotate runs out of memory
Date: Wed, 12 Dec 2007 14:43:20 -0500
Message-ID: <4aca3dc20712121143q4d7ccd9n5408ad7199981164@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	 <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
	 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org>
	 <7vprxcdhis.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org>
	 <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Davide Libenzi" <davidel@xmailserver.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2XVZ-0002gK-JS
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 20:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760612AbXLLTnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 14:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760633AbXLLTnY
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 14:43:24 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:51322 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760538AbXLLTnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 14:43:22 -0500
Received: by wr-out-0506.google.com with SMTP id c49so106090wra.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 11:43:22 -0800 (PST)
Received: by 10.143.162.8 with SMTP id p8mr485083wfo.49.1197488600881;
        Wed, 12 Dec 2007 11:43:20 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Wed, 12 Dec 2007 11:43:20 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68094>

On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> Daniel, this is obviously on top of the patches that fix the memory leak.

Thanks, these patches work *great*.

I'm starting to have a few users who have no experience with git or hg
try their daily workflow with it, to see what UI issues they come up
with :)
