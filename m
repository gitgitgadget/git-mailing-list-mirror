From: "Philip Oakley" <philipoakley@iee.org>
Subject: Improve 'git help' with basic user guide linkss
Date: Fri, 8 Feb 2013 20:28:39 -0000
Organization: OPDS
Message-ID: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uZG-0005xO-Be
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947070Ab3BHU2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:28:33 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:23339 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946949Ab3BHU23 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 15:28:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqkTAOxeFVFcHls+/2dsb2JhbABFjAmtC4ZqAgKBCBdzghoUAQETGx4BASwCCAIBJDkBBBoGBx0bAgECAwGIBAieKoZamjCNORkDS4JbYQOIMIVXmHCDAA
X-IronPort-AV: E=Sophos;i="4.84,630,1355097600"; 
   d="scan'208";a="413754034"
Received: from host-92-30-91-62.as13285.net (HELO PhilipOakley) ([92.30.91.62])
  by out1.ip03ir2.opaltelecom.net with SMTP; 08 Feb 2013 20:28:27 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215814>

I'm looking at extending the 'git help' to include some information for 
the basic user who isn't ready for the extensive man page documentation 
for the various commands.

If the user doesn't yet know which is the relevant command then they 
should also be offered a clue on how to finding the various guides. Many 
users are stuck on the 'If I were you I wouldn't start from here' step 
(many blog comments on the alleged poor documentation and difficulty of 
understanding ...).

I've started on adding a few tweaks to the basic 'git help' message, 
adding an end line indicating that there are guides, such as 'tutorial'. 
Initial hacks at https://github.com/PhilipOakley/git/commits/morehelp 
for thos interested.

My real question is on the right approach to generating a list of guides 
and including them into the git help options. I'm planning on extending 
the command-list.txt file to include 'guides' and then extending the 
generate-cmdlist.sh to generate a guides array in common-cmds.h.

I'm thinking of adding -g --guides and -c --commands options to 
complement the existing -a --all (becomes both commands and guides) 
option. I'm not yet sure how to determine which other special guides 
should be listed (api- etc.) and when.

I was expecting to update the user-manual. to become gituser-manual.txt 
so that the existing 'git help user-manual' scheme would discover it. 
The Tutorial and the User manual obviously(?) being the first port of 
call for the confused user.

Does this appear sensible, and should the Documentation/* directories 
also be searched for 'guides', or is that a step too far [and it's less 
coding] ?

Philip Oakley
