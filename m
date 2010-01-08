From: "James Beck" <james@jmbeck.com>
Subject: Linking multiple Git repositories for version tracking
Date: Fri, 08 Jan 2010 12:03:58 -0500
Message-ID: <op.u574cwxqn3qeew@klee>
References: <op.u573txvdn3qeew@klee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 18:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTIG8-00064G-2X
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 18:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab0AHRET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 12:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692Ab0AHRES
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 12:04:18 -0500
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:48385 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752462Ab0AHRES (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 12:04:18 -0500
X-Greylist: delayed 681 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jan 2010 12:04:18 EST
Received: from klee (unknown [12.173.234.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.g.dreamhost.com (Postfix) with ESMTP id 8D2B04043A
	for <git@vger.kernel.org>; Fri,  8 Jan 2010 09:04:17 -0800 (PST)
In-Reply-To: <op.u573txvdn3qeew@klee>
User-Agent: Opera Mail/10.10 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136459>

Hi,

I'm developing firmware that is composed of multiple projects. Each  
section of the firmware has it's own git repository (each section  
correlates to a physical processor). But the firmware as a whole is  
getting to the point where I have to remember which version of Firmware A  
is compatible with Firmware B. If I add a feature to B that requires some  
tweaks in A, I need to know that both A v3.04 and B v2.7 need to be used  
together.

I'm starting to move into alpha with this code, so I really need to have a  
system that keeps track of compatible firmware versions. The best I can  
come up with is a plain text file (or Excel spreadsheet) that lists the  
overall firmware version, and the Git hash for each individual project.  
That way, if I want to load up a particular firmware version, I can  
checkout each hash for that version. Seems foolproof, but not terribly  
easy, and somewhat annoying.

I know submodules might be used, but it's not super obvious how to make  
their paradigm work nicely here. (You check out a version you want, and  
then list all the submodule git hashes for that version? What happens if  
one hash needs updating? Do you branch it?) It seems more complicated than  
I'd like.

But this can't be a problem that only I have. What have you done to keep  
track of software bundle versions?

Thanks!
James
