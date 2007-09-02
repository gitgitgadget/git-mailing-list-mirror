From: "Alan M. Feldstein" <alan@alanfeldstein.com>
Subject: conflict markers not documented
Date: Sun, 02 Sep 2007 13:32:28 -0500
Organization: Cosmic Horizon
Message-ID: <46DB01BC.8030606@alanfeldstein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 20:33:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRuGe-0003Zy-Mj
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 20:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXIBSds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbXIBSds
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 14:33:48 -0400
Received: from smtpauth14.prod.mesa1.secureserver.net ([64.202.165.39]:41543
	"HELO smtpauth14.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751457AbXIBSds (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 14:33:48 -0400
Received: (qmail 21152 invoked from network); 2 Sep 2007 18:33:47 -0000
Received: from unknown (24.206.104.60)
  by smtpauth14.prod.mesa1.secureserver.net (64.202.165.39) with ESMTP; 02 Sep 2007 18:33:47 -0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070303)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57376>

I can't find Git conflict markers documented anywhere. If I do

    git pull git://icarus.com/~steve-icarus/verilog v0_8-branch

that results in files marked like this, for example

    <<<<<<< HEAD:Attrib.cc
    #ident "$Id: Attrib.cc,v 1.5 2002/08/12 01:34:58 steve Exp $"
    =======
    #ident "$Id: Attrib.cc,v 1.6 2004/02/20 18:53:33 steve Exp $"
     >>>>>>> f600e774d54f14d2cc2848ea5ef663233f8a6f6e:Attrib.cc

The git-pull(1) Manual Page 
<http://www.kernel.org/pub/software/scm/git/docs/git-pull.html> mentions 
conflicts in three places, but fails to document the markers or lead me 
to a page that does. The closest thing I've found is Git User's Manual 
(for version 1.5.3 or newer) 
<http://www.kernel.org/pub/software/scm/git/docs/user-manual.html> with

    <<<<<<< HEAD:file.txt
    Hello world
    =======
    Goodbye
     >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt

but it fails to explain which is which, only stating that "All you need 
to do is edit the files to resolve the conflicts ...". That's not enough 
information.

In _Essential CVS_ by Jennifer Vesperman, she documents (even more 
clearly than the Cederqvist) CVS conflict markers like this

    <<<<<<< filename
    sandbox content
    =======
    repository content
     >>>>>>> revision

 >From this, I can infer that

    #ident "$Id: Attrib.cc,v 1.5 2002/08/12 01:34:58 steve Exp $"

was my Git repository content and

    #ident "$Id: Attrib.cc,v 1.6 2004/02/20 18:53:33 steve Exp $"

was the other repository content (from which I fetched).

But I shouldn't need to refer to a CVS book to understand Git. Git's 
documentation should have made this clear. So I'm not writing this to 
ask for confirmation of my inference from the Git mailing list. I'm 
writing this to ask that the Git documentation be improved to adequately 
explain conflict markers.
-- 

Alan Feldstein

Cosmic Horizon logo

http://www.alanfeldstein.com/

+1 585 415 6682
