From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Unable to Revert Commit
Date: Fri, 28 Nov 2014 15:05:10 -0000
Organization: OPDS
Message-ID: <3CDBFA67BE744B97B9C40FB3F3115A7D@PhilipOakley>
References: <547752ED.8010208@macey.us>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: "Rex Macey" <rex@macey.us>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 28 16:04:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuN6H-0002Xu-Gb
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 16:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbaK1PEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 10:04:45 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:7821 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751198AbaK1PEp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 10:04:45 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkYKAHWOeFRZ8Y9EPGdsb2JhbABbgwaHYmzGYwSBERcBAQEBAQEFAQEBATg7g30GAQEECAEBLh4BASwCAwUCAQMVDCUUAQQaBgcDFAYBEggCAQIDAYgzwy2PRJQwgR8Fi2iGfW2MZINZgzmKS4VTDAGCJj8wgkoBAQE
X-IPAS-Result: AkYKAHWOeFRZ8Y9EPGdsb2JhbABbgwaHYmzGYwSBERcBAQEBAQEFAQEBATg7g30GAQEECAEBLh4BASwCAwUCAQMVDCUUAQQaBgcDFAYBEggCAQIDAYgzwy2PRJQwgR8Fi2iGfW2MZINZgzmKS4VTDAGCJj8wgkoBAQE
X-IronPort-AV: E=Sophos;i="5.07,477,1413241200"; 
   d="scan'208";a="17824986"
Received: from host-89-241-143-68.as13285.net (HELO PhilipOakley) ([89.241.143.68])
  by out1.ip02ir2.opaltelecom.net with SMTP; 28 Nov 2014 15:04:42 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260365>

From: "Rex Macey" <rex@macey.us>
> "Unable to Revert Commit ... Resolve the conflicts in your working 
> directory and commit them before trying the revert again".  Please 
> help me understand how to resolve the conflicts.  Here's what happened 
> (as best as I remember).
> Created a windows folder "github_learn" (not under my 
> \documents\github  folder) ;
> Created a file file1.r.
> Dragged folder into Github for Windows.  Committed; I could see the 
> file in my directory, Github for Windows, and on the server 
> (github.com);
> I modified the first file.  Checked that there were different versions 
> and then committed it.;
> I created a second file, file2.r Committed it.  All good.;
> Then I tested whether I could retrieve the first version of file1.r 
> (before modification).  In the History area of Github for Windows, I 
> can see this version.  I click on that, and then I click on "Revert" 
> which produces the error.
>
> I am very new to Git and have read some of the documentation and this 
> exercise is my attempt to test myself.  So far my grade is not good. 
> I appreciate any guidance including links to instructions.
> Thank you.
> Rex Macey
> --

I belive that what is trying to be said is:

 "You have a 'dirty' worktree which currently contains un-resolved 
conflicts. It would be unwise to attempt a revert, which may further 
conflict with those conflict markers. The easy way out is to resolve 
those conflict markers first."

I'd agree that for the beginner, the compactness of the error messages 
can be a be difficult to understand.

--

Philip 
